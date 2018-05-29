#include "devicestate.h"

#include "../TemperatureControl_Arduino/SerialProtocol.h"

DeviceState::DeviceState(QObject *parent) : QObject(parent)
{
    for (quint8 i=0;i<TEMP_COUNT;i++) {
        mTempIsSimulated[i] = false;
        mTempSimulated[i] = 0;
        mTemps[i] = 0.0;
    }
}

void DeviceState::setComm(CommInterface* comm) {
    mComm = comm;
}

void DeviceState::receivedCmd(QString cmd) {
    uint8_t cmdId = cmd.mid(0,CMD_LENGTH).toShort();
    QString value = cmd.mid(CMD_LENGTH);
    receivedCmd(cmdId, value);
}

void DeviceState::receivedCmd(quint8 cmdId, QString value) {
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

    case CMD_CONF_RADIATOR_LEVEL_DAY:
        setRadiatorLevelDay(value.toUShort());
        break;
    case CMD_CONF_RADIATOR_LEVEL_NIGHT:
        setRadiatorLevelNight(value.toUShort());
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
    case CMD_DTEMP_SOLAR_BACK:
        setTempSolarBack(value.toFloat());
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
    return mTemps[TEMP_HC];
}

float DeviceState::tempWater() const {
    return mTemps[TEMP_WATER];
}

float DeviceState::tempTank() const {
    return mTemps[TEMP_TANK];
}

float DeviceState::tempSolarBack() const {
    return mTemps[TEMP_SOLAR_BACK];
}

float DeviceState::tempTank2() const {
    return mTemps[TEMP_TANK2];
}

float DeviceState::tempBoiler() const {
    return mTemps[TEMP_BOILER];
}

float DeviceState::tempOutside() const {
    return mTemps[TEMP_OUTSIDE];
}

float DeviceState::tempSolar() const {
    return mTemps[TEMP_SOLAR];
}

quint8 DeviceState::radiatorLevelDay() const {
    return mRadiatorLevelDay;
}

quint8 DeviceState::radiatorLevelNight() const {
    return mRadiatorLevelNight;
}

void DeviceState::setTimestampFromNTP(const quint64 &timestamp) {
    setTimestamp(timestamp);
    sendTimestamp(timestamp);
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
    if (mTemps[TEMP_HC]==tempHC) return;
    mTemps[TEMP_HC] = tempHC;
    emit tempHCChanged();
}

void DeviceState::setTempWater(float tempWater) {
    if (mTemps[TEMP_WATER]==tempWater) return;
    mTemps[TEMP_WATER] = tempWater;
    emit tempWaterChanged();
}

void DeviceState::setTempTank(float tempTank) {
    if (mTemps[TEMP_TANK]==tempTank) return;
    mTemps[TEMP_TANK] = tempTank;
    emit tempTankChanged();
}

void DeviceState::setTempSolarBack(float tempSolarBack) {
    if (mTemps[TEMP_SOLAR_BACK]==tempSolarBack) return;
    mTemps[TEMP_SOLAR_BACK] = tempSolarBack;
    emit tempSolarBackChanged();
}

void DeviceState::setTempTank2(float tempTank2) {
    if (mTemps[TEMP_TANK2]==tempTank2) return;
    mTemps[TEMP_TANK2] = tempTank2;
    emit tempTank2Changed();
}

void DeviceState::setTempBoiler(float tempBoiler) {
    if (mTemps[TEMP_BOILER]==tempBoiler) return;
    mTemps[TEMP_BOILER] = tempBoiler;
    emit tempBoilerChanged();
}

void DeviceState::setTempOutside(float tempOutside) {
    if (mTemps[TEMP_OUTSIDE]==tempOutside) return;
    mTemps[TEMP_OUTSIDE] = tempOutside;
    emit tempOutsideChanged();
}

void DeviceState::setTempSolar(float tempSolar) {
    if (mTemps[TEMP_SOLAR]==tempSolar) return;
    mTemps[TEMP_SOLAR] = tempSolar;
    emit tempSolarChanged();
}

void DeviceState::setRadiatorLevelDay(quint8 level) {
    if (mRadiatorLevelDay==level) return;
    mRadiatorLevelDay = level;
    emit radiatorLevelDayChanged();
}

void DeviceState::setRadiatorLevelNight(quint8 level) {
    if (mRadiatorLevelNight==level) return;
    mRadiatorLevelNight = level;
    emit radiatorLevelNightChanged();
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
    case TEMP_SOLAR_BACK:
        cmd = CMD_DTEMP_SOLAR_BACK;
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

    sendCmd(cmd, value);
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

QString DeviceState::getTempName(Temperature temp) {
    switch(temp) {
    case TEMP_HC: return "HC";
    case TEMP_WATER: return "WAT";
    case TEMP_TANK: return "TA1";
    case TEMP_SOLAR_BACK: return "SOB";
    case TEMP_TANK2: return "TA2";
    case TEMP_BOILER: return "BOI";
    case TEMP_OUTSIDE: return "OUT";
    case TEMP_SOLAR: return "SOL";
    }
}

void DeviceState::syncData(int filter) {
    sendCmd(CMD_SYNC_DATA, (qlonglong)filter);
}

void DeviceState::sendRadiatorLevel(quint8 level, bool isDay) {
    sendCmd(isDay ? CMD_CONF_RADIATOR_LEVEL_DAY : CMD_CONF_RADIATOR_LEVEL_NIGHT, (qlonglong)level);
}

void DeviceState::sendTimestamp(quint64 timestamp) {
    qDebug() << "Setting time" << timestamp;
    sendCmd(CMD_TIME, timestamp);
}

void DeviceState::sendCmd(quint8 cmd, quint64 value) {
    mComm->sendCmd(cmd, QString::number(value));
}

void DeviceState::sendCmd(quint8 cmd, qlonglong value) {
    mComm->sendCmd(cmd, QString::number(value));
}

void DeviceState::sendCmd(quint8 cmd, float value) {
    mComm->sendCmd(cmd, QString::number(value));
}

void DeviceState::sendCmd(quint8 cmd, bool value) {
    QString v = value ? "1" : "0";
    mComm->sendCmd(cmd, v);
}
