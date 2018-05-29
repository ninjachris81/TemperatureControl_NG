#include <QApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QDebug>
#include <QDir>
#include <QQuickStyle>

#include "screennames.h"
#include "devicestate.h"
#include "restcomm.h"
#include "localconfig.h"

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

    // TODO
    DeviceState::instance()->setComm(RestComm::instance());

    ScreenNames::setHomeScreen("HomeRemote");

    qmlRegisterSingletonType<ScreenNames>("de.tempcontrol", 1, 0, "ScreenNames", &ScreenNames::newInstance);
    qmlRegisterSingletonType<DeviceState>("de.tempcontrol", 1, 0, "DeviceState", &DeviceState::newInstance);
    qmlRegisterSingletonType<RestComm>("de.tempcontrol", 1, 0, "RestComm", &RestComm::newInstance);
    qmlRegisterSingletonType<LocalConfig>("de.tempcontrol", 1, 0, "LocalConfig", &LocalConfig::newInstance);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main_remote.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
