#ifndef DEVICELOG_H
#define DEVICELOG_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>

#define DEVICE_LOG_MAX_LINE_COUNT 100

class DeviceLog : public QObject
{
    Q_OBJECT
public:
    explicit DeviceLog(QObject *parent = nullptr);

    static QObject *newInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
    {
        Q_UNUSED(engine);
        Q_UNUSED(scriptEngine);

        qDebug() << "New instance of DeviceLog";

        DeviceLog* tempInstance = instance();
        engine->setObjectOwnership(tempInstance, QQmlEngine::CppOwnership);
        return tempInstance;
    }

    static DeviceLog* instance() {
        static DeviceLog m_instance;
        return &m_instance;
    }

    Q_PROPERTY(QString log READ log NOTIFY logChanged)

    QString log();

    void appendLog(QString data);

signals:
    void logChanged();

private:
    QStringList mLogBuffer;

public slots:
};

#endif // DEVICELOG_H
