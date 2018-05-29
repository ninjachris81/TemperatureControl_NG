#include "localconfig.h"

LocalConfig::LocalConfig(QObject *parent) : QObject(parent)
{
    connect(&mTimer, SIGNAL(timeout()), SLOT(onUpdateTime()));
    mTimer.start(1000);
}

QDateTime LocalConfig::currentDateTime() {
    return QDateTime::currentDateTime();
}

void LocalConfig::onUpdateTime() {
    //qDebug() << "Updating time";

    Q_EMIT currentDateTimeChanged();
}
