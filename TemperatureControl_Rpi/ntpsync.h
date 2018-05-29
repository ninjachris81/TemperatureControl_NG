#ifndef NTPSYNC_H
#define NTPSYNC_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>
#include <QHostAddress>
#include <QNetworkReply>

#include "qntp/NtpReply.h"
#include "qntp/NtpClient.h"

class NTPSync : public QObject
{
    Q_OBJECT
public:
    explicit NTPSync(QObject *parent = nullptr);

    static QObject *newInstance(QQmlEngine *engine, QJSEngine *scriptEngine) {
        Q_UNUSED(engine);
        Q_UNUSED(scriptEngine);

        qDebug() << "New instance of NTPSync";

        NTPSync* tempInstance = instance();
        engine->setObjectOwnership(tempInstance, QQmlEngine::CppOwnership);
        return tempInstance;
    }

    static NTPSync* instance() {
        static NTPSync m_instance;
        return &m_instance;
    }

    Q_INVOKABLE void syncNTPTime();

public slots:
    void onReplyReceived(QHostAddress host, quint16 port, NtpReply reply);

private:
    NtpClient mNtpClient;

signals:
    void ntpTimeSynced();

public slots:
};

#endif // NTPSYNC_H
