#ifndef COMMINTERFACE_H
#define COMMINTERFACE_H

#include <QObject>

class CommInterface : public QObject
{
    Q_OBJECT
public:
    CommInterface(QObject *parent = nullptr);

    Q_PROPERTY(bool isConnected READ isConnected NOTIFY isConnectedChanged)

    virtual void sendCmd(quint8 cmd, QString value);

    virtual void write(const QByteArray &writeData) = 0;

    bool isConnected() const;
    void setIsConnected(bool isConnected);

protected:
    bool mIsConnected = false;

signals:
    void isConnectedChanged();

};

#endif // COMMINTERFACE_H
