#include "comminterface.h"
#include <QDebug>

#include "../TemperatureControl_Arduino/SerialProtocol.h"

CommInterface::CommInterface(QObject *parent) : QObject(parent)
{

}

bool CommInterface::isConnected() const {
    return mIsConnected;
}

void CommInterface::setIsConnected(bool isConnected) {
    if (mIsConnected==isConnected) return;
    mIsConnected = isConnected;
    emit isConnectedChanged();
}

void CommInterface::sendCmd(quint8 cmd, QString value) {
    QByteArray data;

    data.append(RECEIVER_MEGA);
    data.append(QString("%1").arg(cmd, CMD_LENGTH, 10, QChar('0')));
    data.append(value);
    data.append("\n");

    qDebug() << "Sending cmd" << data;
    write(data);
}
