#ifndef SERIALCOMM_H
#define SERIALCOMM_H

#include <QObject>
#include <QtSerialPort/QtSerialPort>
#include <QTimer>
#include <QDebug>
#include <QQmlEngine>

class SerialComm : public QObject
{
    Q_OBJECT
public:
    ~SerialComm();

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

    Q_PROPERTY(bool isConnected READ isConnected NOTIFY isConnectedChanged)

    void write(const QByteArray &writeData);

    bool isConnected() const;
    void setIsConnected(bool isConnected);

private:
    explicit SerialComm(QObject *parent = nullptr);

    QSerialPort mSerialPort;

    bool mIsConnected = false;

    qint64 mBytesWritten;
    qint64 mBytesToWrite;

    QTimer mTimer;

    void parseLine(QString line);

private slots:
    void handleReadyRead();
    void handleError(QSerialPort::SerialPortError error);
    void handleTimeout();
    void handleBytesWritten(qint64 bytes);

signals:
    void isConnectedChanged();

public slots:
    void tryConnect();
};

#endif // SERIALCOMM_H
