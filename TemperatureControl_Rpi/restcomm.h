#ifndef RESTCOMM_H
#define RESTCOMM_H

#include <QObject>
#include <QDebug>
#include <QTimer>
#include <QQmlEngine>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QNetworkAccessManager>

#include "comminterface.h"

class RestComm : public CommInterface
{
    Q_OBJECT

public:

    static QObject *newInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
    {
        Q_UNUSED(engine);
        Q_UNUSED(scriptEngine);

        qDebug() << "New instance of RestComm";

        RestComm* tempInstance = instance();
        engine->setObjectOwnership(tempInstance, QQmlEngine::CppOwnership);
        return tempInstance;
    }

    static RestComm* instance() {
        static RestComm m_instance;
        return &m_instance;
    }

    void sendCmd(quint8 cmd, QString value) override;

    void write(const QByteArray &writeData) override;

private slots:
    void onTimeout();
    void onSyncReplReceived(QNetworkReply* reply);

protected:
    RestComm();
    QNetworkRequest mSyncReq;
    QNetworkReply* mCurrentSyncReply;

    QTimer mTimer;

    QNetworkAccessManager mNam;

};

#endif // RESTCOMM_H
