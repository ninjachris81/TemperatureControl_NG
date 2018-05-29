#ifndef SCREENNAMES_H
#define SCREENNAMES_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>
#include <QList>

class ScreenNames : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(ScreenNames)

public:
    ScreenNames();

    enum ScreenName
    {
        SCREEN_INVALID = -3,
        SCREEN_POP = -2,
        SCREEN_MANUAL_NEXT = -1,
        SCREEN_HOME = 0,
        SCREEN_HOME_REMOTE,
        SCREEN_DEVICE_LOG,
        SCREEN_TIME_SETTINGS,
        SCREEN_IO_CONTROL,
        SCREEN_TEMPERATURE_CONTROL,
        SCREEN_DEVICE_CONFIGURATION,
        SCREEN_HEATING_CONTROL,
        SCREEN_SOLAR_CONTROL

    };
    Q_ENUMS(ScreenName)

    static QObject *newInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
    {
        Q_UNUSED(engine);
        Q_UNUSED(scriptEngine);

        qDebug() << "New instance of ScreenNames";

        static ScreenNames m_instance;
        engine->setObjectOwnership(&m_instance, QQmlEngine::CppOwnership);
        return &m_instance;
    }

    Q_INVOKABLE QString resolveScreenUrl(ScreenName sn);
    Q_INVOKABLE QString resolveScreenName(ScreenName sn);

    static void setHomeScreen(const QString &value);

private:
    static QString homeScreen;

signals:

public slots:

};

#endif // SCREENNAMES_H
