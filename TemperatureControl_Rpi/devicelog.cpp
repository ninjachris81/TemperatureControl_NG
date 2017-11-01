#include "devicelog.h"

DeviceLog::DeviceLog(QObject *parent) : QObject(parent)
{
}

QString DeviceLog::log() {
    return mLogBuffer.join('\n');
}

void DeviceLog::appendLog(QString data) {
    if (mLogBuffer.size()>=DEVICE_LOG_MAX_LINE_COUNT) {
        mLogBuffer.removeLast();
    }

    mLogBuffer.insert(0, data);
    emit logChanged();
}
