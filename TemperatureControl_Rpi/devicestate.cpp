#include "devicestate.h"

#include "serialcomm.h"
#include "../TemperatureControl_Arduino/SerialProtocol.h"

DeviceState::DeviceState(QObject *parent) : QObject(parent)
{
    connect(&mNtpClient, SIGNAL(replyReceived(QHostAddress,quint16,NtpReply)), SLOT(onReplyReceived(QHostAddress,quint16,NtpReply)));

    for (quint8 i=0;i<TEMP_COUNT;i++) {
        mTempIsSimulated[i] = false;
        mTempSimulated[i] = 0;
    }
}

void DeviceState::receivedCmd(QString cmd) {
    uint8_t cmdId = cmd.mid(0,2).toShort();
    QString value = cmd.mid(2);

    switch(cmdId) {
    case CMD_FREE_RAM:
        setFreeRam(value.toInt());
        break;
    case CMD_TIME:
        setTimestamp(value.toLongLong());
        break;
    case CMD_UPTIME:
        setUptime(value.toLongLong());
        break;

    case CMD_SOLAR_PUMP:
        setSolarPump(value.toInt()==1);
        break;
    case CMD_RADIATOR_PUMP:
        setRadiatorPump(value.toInt()==1);
        break;
    case CMD_GAS_BURNER:
        setGasBurner(value.toInt()==1);
        break;
    case CMD_CIRCULATION_PUMP:
        setCirculationPump(value.toInt()==1);
        break;
    case CMD_HEAT_CHANGER_PUMP:
        setHeatChangerPump(value.toInt()==1);
        break;

    case CMD_DTEMP_HC:
        setTempHC(value.toFloat());
        break;
    case CMD_DTEMP_WATER:
        setTempWater(value.toFloat());
        break;
    case CMD_DTEMP_TANK:
        setTempTank(value.toFloat());
        break;

    case CMD_ATEMP_TANK:
        setTempTank2(value.toFloat());
        break;
    case CMD_ATEMP_BOILER:
        setTempBoiler(value.toFloat());
        break;
    case CMD_ATEMP_OUTSIDE:
        setTempOutside(value.toFloat());
        break;
    case CMD_ATEMP_SOLAR:
        setTempSolar(value.toFloat());
        break;

    }

}

quint16 DeviceState::freeRam() const
{
    return mFreeRam;
}

quint64 DeviceState::timestamp() const
{
    return mTimestamp;
}

quint64 DeviceState::uptime() const
{
    return mUptime;
}

bool DeviceState::solarPump() const
{
    return mSolarPump;
}

bool DeviceState::radiatorPump() const
{
    return mRadiatorPump;
}

bool DeviceState::gasBurner() const
{
    return mGasBurner;
}

bool DeviceState::circulationPump() const
{
    return mCirculationPump;
}

bool DeviceState::heatChangerPump() const
{
    return mHeatChangerPump;
}

float DeviceState::tempHC() const {
    return mTempHC;
}

float DeviceState::tempWater() const {
    return mTempWater;
}

float DeviceState::tempTank() const {
    return mTempTank;
}

float DeviceState::tempTank2() const {
    return mTempTank2;
}

float DeviceState::tempBoiler() const {
    return mTempBoiler;
}

float DeviceState::tempOutside() const {
    return mTempOutside;
}

float DeviceState::tempSolar() const {
    return mTempSolar;
}

void DeviceState::setHeatChangerPump(bool heatChangerPump)
{
    if (mHeatChangerPump == heatChangerPump) return;
    mHeatChangerPump = heatChangerPump;
    emit heatChangerPumpChanged();
}

void DeviceState::setCirculationPump(bool circulationPump)
{
    if (mCirculationPump == circulationPump) return;
    mCirculationPump = circulationPump;
    emit circulationPumpChanged();
}

void DeviceState::setGasBurner(bool gasBurner)
{
    if (mGasBurner == gasBurner) return;
    mGasBurner = gasBurner;
    emit gasBurnerChanged();
}

void DeviceState::setRadiatorPump(bool radiatorPump)
{
    if (mRadiatorPump == radiatorPump) return;
    mRadiatorPump = radiatorPump;
    emit radiatorPumpChanged();
}

void DeviceState::setSolarPump(bool solarPump)
{
    if (mSolarPump == solarPump) return;
    mSolarPump = solarPump;
    emit solarPumpChanged();
}

void DeviceState::setUptime(const quint64 &uptime)
{
    if (mUptime==uptime) return;
    mUptime = uptime;
    emit uptimeChanged();
}

void DeviceState::setTimestamp(const quint64 &timestamp)
{
    if (mTimestamp==timestamp) return;
    mTimestamp = timestamp;
    emit timestampChanged();
}

void DeviceState::setFreeRam(const quint16 &freeRam)
{
    if (mFreeRam==freeRam) return;
    mFreeRam = freeRam;
    emit freeRamChanged();
}

void DeviceState::setTempHC(float tempHC) {
    if (mTempHC==tempHC) return;
    mTempHC = tempHC;
    emit tempHCChanged();
}

void DeviceState::setTempWater(float tempWater) {
    if (mTempWater==tempWater) return;
    mTempWater = tempWater;
    emit tempWaterChanged();
}

void DeviceState::setTempTank(float tempTank) {
    if (mTempTank==tempTank) return;
    mTempTank = tempTank;
    emit tempTankChanged();
}

void DeviceState::setTempTank2(float tempTank2) {
    if (mTempTank2==tempTank2) return;
    mTempTank2 = tempTank2;
    emit tempTank2Changed();
}

void DeviceState::setTempBoiler(float tempBoiler) {
    if (mTempBoiler==tempBoiler) return;
    mTempBoiler = tempBoiler;
    emit tempBoilerChanged();
}

void DeviceState::setTempOutside(float tempOutside) {
    if (mTempOutside==tempOutside) return;
    mTempOutside = tempOutside;
    emit tempOutsideChanged();
}

void DeviceState::setTempSolar(float tempSolar) {
    if (mTempSolar==tempSolar) return;
    mTempSolar = tempSolar;
    emit tempSolarChanged();
}

void DeviceState::toggleAndSendIOState(IoDevice device) {
    bool toSetState;
    quint8 cmd;

    qDebug() << "Toggle state" << device;

    switch (device) {
    case IOD_SOLAR_PUMP:
        cmd = CMD_SOLAR_PUMP;
        toSetState = !mSolarPump;
        break;
    case IOD_RADIATOR_PUMP:
        cmd = CMD_RADIATOR_PUMP;
        toSetState = !mRadiatorPump;
        break;
    case IOD_GAS_BURNER:
        cmd = CMD_GAS_BURNER;
        toSetState = !mGasBurner;
        break;
    case IOD_CIRCULATION_PUMP:
        cmd = CMD_CIRCULATION_PUMP;
        toSetState = !mCirculationPump;
        break;
    case IOD_HEAT_CHANGER_PUMP:
        cmd = CMD_HEAT_CHANGER_PUMP;
        toSetState = !mHeatChangerPump;
        break;
    default:
        qWarning() << "Invalid device" << device;
        return;
    }

    qDebug() << "Setting" << cmd << toSetState;

    sendCmd(cmd, toSetState);
}

void DeviceState::disableIOSimulations() {
    qDebug() << "Disable IO simulations";
    sendCmd(CMD_DISABLE_SIMULATION, (qlonglong)CMD_SOLAR_PUMP);
    sendCmd(CMD_DISABLE_SIMULATION, (qlonglong)CMD_RADIATOR_PUMP);
    sendCmd(CMD_DISABLE_SIMULATION, (qlonglong)CMD_GAS_BURNER);
    sendCmd(CMD_DISABLE_SIMULATION, (qlonglong)CMD_CIRCULATION_PUMP);
    sendCmd(CMD_DISABLE_SIMULATION, (qlonglong)CMD_HEAT_CHANGER_PUMP);
}

void DeviceState::simulateTemp(Temperature temp, float value) {
    quint8 cmd;

    mTempSimulated[temp] = value;
    mTempIsSimulated[temp] = true;

    switch(temp) {
    case TEMP_HC:
        cmd = CMD_DTEMP_HC;
        break;
    case TEMP_WATER:
        cmd = CMD_DTEMP_WATER;
        break;
    case TEMP_TANK:
        cmd = CMD_DTEMP_TANK;
        break;
    case TEMP_TANK2:
        cmd = CMD_ATEMP_TANK;
        break;
    case TEMP_BOILER:
        cmd = CMD_ATEMP_BOILER;
        break;
    case TEMP_OUTSIDE:
        cmd = CMD_ATEMP_OUTSIDE;
        break;
    case TEMP_SOLAR:
        cmd = CMD_ATEMP_SOLAR;
        break;
    }

    sendCmd(cmd, QString::number(value));
}

float DeviceState::getSimulatedValue(Temperature temp) {
    return mTempSimulated[temp];
}

bool DeviceState::isSimulated(Temperature temp) {
    return mTempIsSimulated[temp];
}

void DeviceState::disableTempSimulation(Temperature temp) {
    mTempIsSimulated[temp] = false;
    sendCmd(CMD_DISABLE_SIMULATION, (quint64)(CMD_TEMP_BASE + temp));
}

void DeviceState::syncNTPTime() {
    qDebug() << "Sending ntp request";

    QHostAddress addr("52.58.132.98");
    mNtpClient.sendRequest(addr, 123);
}

void DeviceState::syncData(int filter) {
    sendCmd(CMD_SYNC_DATA, (qlonglong)filter);
}

void DeviceState::onReplyReceived(QHostAddress host, quint16 port, NtpReply reply)
{
    Q_UNUSED(host)
    Q_UNUSED(port)

    qDebug() << "setting time" << reply.referenceTime();
    setTimestamp(reply.referenceTime().toSecsSinceEpoch());
    sendTimestamp(reply.referenceTime().toSecsSinceEpoch());

    emit ntpTimeSynced();
}

void DeviceState::sendTimestamp(quint64 timestamp) {
    qDebug() << "Setting time" << timestamp;
    sendCmd(CMD_TIME, timestamp);
}

void DeviceState::sendCmd(quint8 cmd, quint64 value) {
    sendCmd(cmd, QString::number(value));
}

void DeviceState::sendCmd(quint8 cmd, qlonglong value) {
    sendCmd(cmd, QString::number(value));
}

void DeviceState::sendCmd(quint8 cmd, bool value) {
    QString v = value ? "1" : "0";
    sendCmd(cmd, v);
}

void DeviceState::sendCmd(quint8 cmd, QString value) {
    QByteArray data;
    data.append(QString::number(cmd));
    data.append(value);
    data.append("\n");

    qDebug() << "Sending cmd" << data;
    SerialComm::instance()->write(data);
}
