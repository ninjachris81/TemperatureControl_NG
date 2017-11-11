#include "serialcomm.h"
#include <QDebug>
#include "devicelog.h"
#include "devicestate.h"

SerialComm::SerialComm(QObject *parent) : QObject(parent), mBytesWritten(0)
{
    mSerialPort.setPortName("ttyMega");
    mSerialPort.setBaudRate(QSerialPort::Baud9600);
    mSerialPort.setDataBits(QSerialPort::Data8);
    mSerialPort.setParity(QSerialPort::NoParity);
    mSerialPort.setStopBits(QSerialPort::OneStop);

    connect(&mSerialPort, SIGNAL(readyRead()), SLOT(handleReadyRead()));
    connect(&mSerialPort, SIGNAL(error(QSerialPort::SerialPortError)), SLOT(handleError(QSerialPort::SerialPortError)));
    connect(&mSerialPort, SIGNAL(bytesWritten(qint64)), SLOT(handleBytesWritten(qint64)));
    connect(&mTimer, SIGNAL(timeout()), SLOT(handleTimeout()));

    tryConnect();
}

bool SerialComm::isConnected() const
{
    return mIsConnected;
}

void SerialComm::setIsConnected(bool isConnected)
{
    if (mIsConnected==isConnected) return;
    mIsConnected = isConnected;
    emit isConnectedChanged();
}

SerialComm::~SerialComm() {
    //delete inputStream;
}

void SerialComm::tryConnect() {
    setIsConnected(false);
    if (mSerialPort.isOpen()) mSerialPort.close();
    
    if (mSerialPort.open(QIODevice::ReadWrite)) {
        qDebug() << mSerialPort.portName() << "opened";
        mTimer.stop();
        setIsConnected(true);
    } else {
        qDebug() << "Reconnecting";
        mTimer.start(5000);
    }
}

void SerialComm::handleReadyRead() {
    if (mSerialPort.canReadLine()) {
        parseLine(mSerialPort.readLine());
    }
}

void SerialComm::parseLine(QString line) {
    if (line.endsWith("\r\n")) line.chop(2);
    if (line.endsWith("\n")) line.chop(1);
    qDebug() << "Parsing line" << line;

    if (line.startsWith("!")) {
        DeviceState::instance()->receivedCmd(line.mid(1));
    } else {
        DeviceLog::instance()->appendLog(line);
    }
}

void SerialComm::handleError(QSerialPort::SerialPortError error) {
    if (error==QSerialPort::DeviceNotFoundError) {
        qWarning() << "Device not found";
    } else if (error!=QSerialPort::NoError) {
        qWarning() << "Handle error" << error;
        mTimer.start(5000);
    } else {
        qDebug() << "No Error";
    }
}

void SerialComm::handleTimeout() {
    qWarning() << "Operation timeout";
    tryConnect();
}

void SerialComm::handleBytesWritten(qint64 bytes) {
    mBytesWritten += bytes;
    if (mBytesWritten == mBytesToWrite) {
        qDebug() << "All bytes written";
        mBytesWritten = 0;
        mTimer.stop();
    }
}

void SerialComm::write(const QByteArray &writeData)
{
    mBytesToWrite += writeData.size();
    quint64 bytesWritten = mSerialPort.write(writeData);
    if (bytesWritten<writeData.size()) mTimer.start(5000);
}
