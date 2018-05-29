#ifndef SERIALCOMM_H
#define SERIALCOMM_H

#include <QObject>
#include <QtSerialPort/QtSerialPort>
#include <QTimer>
#include <QDebug>
#include <QQmlEngine>

#include "comminterface.h"

class SerialComm : public CommInterface
{
    Q_OBJECT
public:
    static QObject *newInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
    {
        Q_UNUSED(engine);
        Q_UNUSED(scriptEngine);

        qDebug() << "New instance of SerialComm";

        SerialComm* tempInstance = instance();
        engine->setObjectOwnership(tempInstance, QQmlEngine::CppOwnership);
        return tempInstance;
    }

    static SerialComm* instance() {
        static SerialComm m_instance;
        return &m_instance;
    }

    void write(const QByteArray &writeData) override;

private:
    explicit SerialComm(QObject *parent = nullptr);
    ~SerialComm();

    QSerialPort mSerialPort;

    qint64 mBytesWritten;
    qint64 mBytesToWrite;

    QTimer mTimer;

    void parseLine(QString line);

private slots:
    void handleReadyRead();
    void handleError(QSerialPort::SerialPortError error);
    void handleTimeout();
    void handleBytesWritten(qint64 bytes);

public slots:
    void tryConnect();
};

#endif // SERIALCOMM_H
