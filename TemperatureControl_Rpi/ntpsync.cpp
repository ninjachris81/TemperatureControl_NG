#include "ntpsync.h"

#include "devicestate.h"

NTPSync::NTPSync(QObject *parent) : QObject(parent)
{
    connect(&mNtpClient, SIGNAL(replyReceived(QHostAddress,quint16,NtpReply)), SLOT(onReplyReceived(QHostAddress,quint16,NtpReply)));
}

void NTPSync::syncNTPTime() {
    qDebug() << "Sending ntp request";

    QHostAddress addr("52.58.132.98");
    mNtpClient.sendRequest(addr, 123);
}

void NTPSync::onReplyReceived(QHostAddress host, quint16 port, NtpReply reply)
{
    Q_UNUSED(host)
    Q_UNUSED(port)

    qDebug() << "setting time" << reply.referenceTime();
    DeviceState::instance()->setTimestampFromNTP(reply.referenceTime().toSecsSinceEpoch());

    emit ntpTimeSynced();
}
