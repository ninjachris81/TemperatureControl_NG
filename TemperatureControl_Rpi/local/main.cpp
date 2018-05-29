#include <QApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QDebug>
#include <QDir>
#include <QQuickStyle>

#include "screennames.h"
#include "serialcomm.h"
#include "devicelog.h"
#include "devicestate.h"
#include "ntpsync.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));       // must be before app inst
    //qputenv("QT_VIRTUALKEYBOARD_LAYOUT_PATH", Env::layoutPath().toLatin1());     // fix this

    QQuickStyle::setStyle("ACX");

    QApplication app(argc, argv);

    QFontDatabase fontDatabase;
    fontDatabase.addApplicationFont(":/fonts/HLM_____.TTF");
    fontDatabase.addApplicationFont(":/fonts/HLL_____.TTF");

    //qDebug() << fontDatabase.families();

    QQmlApplicationEngine engine;

    DeviceState::instance()->setComm(SerialComm::instance());

    qmlRegisterSingletonType<ScreenNames>("de.tempcontrol", 1, 0, "ScreenNames", &ScreenNames::newInstance);
    qmlRegisterSingletonType<DeviceLog>("de.tempcontrol", 1, 0, "DeviceLog", &DeviceLog::newInstance);
    qmlRegisterSingletonType<DeviceState>("de.tempcontrol", 1, 0, "DeviceState", &DeviceState::newInstance);
    qmlRegisterSingletonType<SerialComm>("de.tempcontrol", 1, 0, "SerialComm", &SerialComm::newInstance);
    qmlRegisterSingletonType<NTPSync>("de.tempcontrol", 1, 0, "NTPSync", &NTPSync::newInstance);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main_local.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
