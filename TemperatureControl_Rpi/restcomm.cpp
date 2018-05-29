#include "restcomm.h"

#include "devicestate.h"

#include <QUrlQuery>
#include <QUrl>
#include <QJsonDocument>
#include <QJsonObject>

RestComm::RestComm()
{
    mTimer.setInterval(1000);
    connect(&mTimer, SIGNAL(timeout()), SLOT(onTimeout()));

    connect(&mNam, SIGNAL(finished(QNetworkReply*)), SLOT(onSyncReplReceived(QNetworkReply*)));
}

void RestComm::sendCmd(quint8 cmd, QString value) {
    QNetworkRequest req;

    QUrl url;
    url.setScheme("http");
    url.setHost("192.178.0.111");
    url.setPath("/sendCmd");

    QUrlQuery query;
    query.addQueryItem("c", QString::number(cmd));
    query.addQueryItem("v", value);

    url.setQuery(query);

    req.setUrl(url);
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    mNam.get(req);
}

void RestComm::write(const QByteArray &writeData) {

}

void RestComm::onTimeout() {
    mTimer.stop();

    mNam.get(mSyncReq);

    mTimer.start();
}

void RestComm::onSyncReplReceived(QNetworkReply *reply) {
    if (reply->canReadLine()) {
        QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
        if (doc.isObject()) {
            if (doc.object().contains("props") && doc.object().value("props").isObject()) {
                for (QString key : doc.object().value("props").toObject().keys()) {
                    DeviceState::instance()->receivedCmd(static_cast<quint8>(key.toShort()), doc.object().value("props").toObject().value(key).toString());
                }
            }
        }

    }
}
