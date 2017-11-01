#include "devicestate.h"

#include "serialcomm.h"
#include "../TemperatureControl_Arduino/SerialProtocol.h"

DeviceState::DeviceState(QObject *parent) : QObject(parent)
{

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

void DeviceState::disableSimulations() {
    qDebug() << "Disable simulations";
    sendCmd(CMD_DISABLE_SIMULATION, (qlonglong)CMD_SOLAR_PUMP);
    sendCmd(CMD_DISABLE_SIMULATION, (qlonglong)CMD_RADIATOR_PUMP);
    sendCmd(CMD_DISABLE_SIMULATION, (qlonglong)CMD_GAS_BURNER);
    sendCmd(CMD_DISABLE_SIMULATION, (qlonglong)CMD_CIRCULATION_PUMP);
    sendCmd(CMD_DISABLE_SIMULATION, (qlonglong)CMD_HEAT_CHANGER_PUMP);
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
