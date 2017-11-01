#ifndef DEVICESTATE_H
#define DEVICESTATE_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>

class DeviceState : public QObject
{
    Q_OBJECT
public:
    explicit DeviceState(QObject *parent = nullptr);

    static QObject *newInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
    {
        Q_UNUSED(engine);
        Q_UNUSED(scriptEngine);

        qDebug() << "New instance of DeviceState";

        DeviceState* tempInstance = instance();
        engine->setObjectOwnership(tempInstance, QQmlEngine::CppOwnership);
        return tempInstance;
    }

    static DeviceState* instance() {
        static DeviceState m_instance;
        return &m_instance;
    }

    enum IoDevice {
        IOD_SOLAR_PUMP,
        IOD_RADIATOR_PUMP,
        IOD_GAS_BURNER,
        IOD_CIRCULATION_PUMP,
        IOD_HEAT_CHANGER_PUMP
    };
    Q_ENUMS(IoDevice)

    Q_PROPERTY(quint16 freeRam READ freeRam NOTIFY freeRamChanged)
    Q_PROPERTY(quint64 timestamp READ timestamp NOTIFY timestampChanged)
    Q_PROPERTY(quint64 uptime READ uptime NOTIFY uptimeChanged)

    Q_PROPERTY(bool solarPump READ solarPump NOTIFY solarPumpChanged)
    Q_PROPERTY(bool radiatorPump READ radiatorPump NOTIFY radiatorPumpChanged)
    Q_PROPERTY(bool gasBurner READ gasBurner NOTIFY gasBurnerChanged)
    Q_PROPERTY(bool circulationPump READ circulationPump NOTIFY circulationPumpChanged)
    Q_PROPERTY(bool heatChangerPump READ heatChangerPump NOTIFY heatChangerPumpChanged)

    Q_INVOKABLE void sendTimestamp(quint64 timestamp);
    Q_INVOKABLE void toggleAndSendIOState(IoDevice device);
    Q_INVOKABLE void disableSimulations();

    void receivedCmd(QString cmd);

    quint16 freeRam() const;

    quint64 timestamp() const;

    quint64 uptime() const;

    bool solarPump() const;
    bool radiatorPump() const;
    bool gasBurner() const;
    bool circulationPump() const;
    bool heatChangerPump() const;

private:
    quint16 mFreeRam = 0;
    quint64 mTimestamp = 0;
    quint64 mUptime = 0;

    bool mSolarPump = false;
    bool mRadiatorPump = false;
    bool mGasBurner = false;
    bool mCirculationPump = false;
    bool mHeatChangerPump = false;

    void setFreeRam(const quint16 &freeRam);
    void setTimestamp(const quint64 &timestamp);
    void setUptime(const quint64 &uptime);

    void setSolarPump(bool solarPump);
    void setRadiatorPump(bool radiatorPump);
    void setGasBurner(bool gasBurner);
    void setCirculationPump(bool circulationPump);
    void setHeatChangerPump(bool heatChangerPump);

    void sendCmd(quint8 cmd, quint64 value);
    void sendCmd(quint8 cmd, qlonglong value);
    void sendCmd(quint8 cmd, bool value);
    void sendCmd(quint8 cmd, QString value);
signals:
    void freeRamChanged();
    void timestampChanged();
    void uptimeChanged();

    void solarPumpChanged();
    void radiatorPumpChanged();
    void gasBurnerChanged();
    void circulationPumpChanged();
    void heatChangerPumpChanged();

public slots:
};

#endif // DEVICESTATE_H
