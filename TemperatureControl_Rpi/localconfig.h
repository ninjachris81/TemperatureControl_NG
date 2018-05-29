#ifndef LOCALCONFIG_H
#define LOCALCONFIG_H

#include <QObject>
#include <QTimer>
#include <QDateTime>
#include <QQmlEngine>
#include <QDebug>

class LocalConfig : public QObject
{
    Q_OBJECT
public:
    explicit LocalConfig(QObject *parent = nullptr);

    static QObject *newInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
    {
        Q_UNUSED(engine);
        Q_UNUSED(scriptEngine);

        qDebug() << "New instance of LocalConfig";

        LocalConfig* tempInstance = instance();
        engine->setObjectOwnership(tempInstance, QQmlEngine::CppOwnership);
        return tempInstance;
    }

    static LocalConfig* instance() {
        static LocalConfig m_instance;
        return &m_instance;
    }

    Q_PROPERTY(QDateTime currentDateTime READ currentDateTime NOTIFY currentDateTimeChanged)

    QDateTime currentDateTime();

private:
    QTimer mTimer;

signals:
    void currentDateTimeChanged();

private slots:
    void onUpdateTime();

public slots:
};

#endif // LOCALCONFIG_H
