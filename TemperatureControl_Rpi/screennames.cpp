#include "screennames.h"

ScreenNames::ScreenNames() : QObject()
{
}

QString ScreenNames::resolveScreenUrl(ScreenName sn)
{
    static int enumIdx = ScreenNames::staticMetaObject.indexOfEnumerator("ScreenName");
    QString t = ScreenNames::staticMetaObject.enumerator(enumIdx).valueToKey(sn);

    t = t.mid(6).toLower().replace("__", "/_");

    //qDebug() << t;

    QStringList parts = t.split('_', QString::SkipEmptyParts);

    for (int i=0; i<parts.size(); ++i) parts[i].replace(0, 1, parts[i][0].toUpper());
    t = parts.join("");

    parts = t.split("/", QString::SkipEmptyParts);
    for (int i=0; i<parts.size()-1; ++i) parts[i].replace(0, 1, parts[i][0].toLower());
    t = parts.join("/");

    //qDebug() << t;

    return t;
}

QString ScreenNames::resolveScreenName(ScreenName sn)
{
    switch(sn) {
    case SCREEN_HOME: return tr("Home");
    case SCREEN_DEVICE_LOG: return tr("Device Log");
    case SCREEN_TIME_SETTINGS: return tr("Time Settings");
    case SCREEN_IO_CONTROL: return tr("IO Control");
    case SCREEN_TEMPERATURE_CONTROL: return tr("Temperature Control");
    case SCREEN_DEVICE_CONFIGURATION: return tr("Device Configuration");
    case SCREEN_HEATING_CONTROL: return tr("Heating Control");

    default:
        qWarning() << "Unknown screen name:" << sn;
        return "";
    }
}
