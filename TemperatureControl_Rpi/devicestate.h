#ifndef DEVICESTATE_H
#define DEVICESTATE_H

#include <QObject>
#include <QDebug>
#include <QQmlEngine>
#include <QHostAddress>
#include <QNetworkReply>

#include "qntp/NtpReply.h"
#include "qntp/NtpClient.h"

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

    enum Temperature {
        TEMP_HC,
        TEMP_WATER,
        TEMP_TANK,
        TEMP_TANK2,
        TEMP_BOILER,
        TEMP_OUTSIDE,
        TEMP_SOLAR,

        TEMP_COUNT
    };
    Q_ENUMS(Temperature)

    Q_PROPERTY(quint16 freeRam READ freeRam NOTIFY freeRamChanged)
    Q_PROPERTY(quint64 timestamp READ timestamp NOTIFY timestampChanged)
    Q_PROPERTY(quint64 uptime READ uptime NOTIFY uptimeChanged)

    Q_PROPERTY(bool solarPump READ solarPump NOTIFY solarPumpChanged)
    Q_PROPERTY(bool radiatorPump READ radiatorPump NOTIFY radiatorPumpChanged)
    Q_PROPERTY(bool gasBurner READ gasBurner NOTIFY gasBurnerChanged)
    Q_PROPERTY(bool circulationPump READ circulationPump NOTIFY circulationPumpChanged)
    Q_PROPERTY(bool heatChangerPump READ heatChangerPump NOTIFY heatChangerPumpChanged)

    Q_PROPERTY(float tempHC READ tempHC NOTIFY tempHCChanged)
    Q_PROPERTY(float tempWater READ tempWater NOTIFY tempWaterChanged)
    Q_PROPERTY(float tempTank READ tempTank NOTIFY tempTankChanged)
    Q_PROPERTY(float tempTank2 READ tempTank2 NOTIFY tempTank2Changed)
    Q_PROPERTY(float tempBoiler READ tempBoiler NOTIFY tempBoilerChanged)
    Q_PROPERTY(float tempOutside READ tempOutside NOTIFY tempOutsideChanged)
    Q_PROPERTY(float tempSolar READ tempSolar NOTIFY tempSolarChanged)

    Q_INVOKABLE void sendTimestamp(quint64 timestamp);
    Q_INVOKABLE void toggleAndSendIOState(IoDevice device);
    Q_INVOKABLE void disableIOSimulations();
    Q_INVOKABLE void simulateTemp(Temperature temp, float value);
    Q_INVOKABLE void disableTempSimulation(Temperature temp);

    Q_INVOKABLE float getSimulatedValue(Temperature temp);
    Q_INVOKABLE bool isSimulated(Temperature temp);

    Q_INVOKABLE void syncNTPTime();

    Q_INVOKABLE void syncData(int filter = -1);

    void receivedCmd(QString cmd);

    quint16 freeRam() const;

    quint64 timestamp() const;

    quint64 uptime() const;

    bool solarPump() const;
    bool radiatorPump() const;
    bool gasBurner() const;
    bool circulationPump() const;
    bool heatChangerPump() const;

    float tempHC() const;
    float tempWater() const;
    float tempTank() const;
    float tempTank2() const;
    float tempBoiler() const;
    float tempOutside() const;
    float tempSolar() const;

public slots:
    void onReplyReceived(QHostAddress host, quint16 port, NtpReply reply);

private:
    quint16 mFreeRam = 0;
    quint64 mTimestamp = 0;
    quint64 mUptime = 0;

    bool mSolarPump = false;
    bool mRadiatorPump = false;
    bool mGasBurner = false;
    bool mCirculationPump = false;
    bool mHeatChangerPump = false;

    float mTempHC = 0.0;
    float mTempWater = 0.0;
    float mTempTank = 0.0;
    float mTempTank2 = 0.0;
    float mTempBoiler = 0.0;
    float mTempOutside = 0.0;
    float mTempSolar = 0.0;

    NtpClient mNtpClient;

    bool mTempIsSimulated[TEMP_COUNT];
    float mTempSimulated[TEMP_COUNT];

    void setFreeRam(const quint16 &freeRam);
    void setTimestamp(const quint64 &timestamp);
    void setUptime(const quint64 &uptime);

    void setSolarPump(bool solarPump);
    void setRadiatorPump(bool radiatorPump);
    void setGasBurner(bool gasBurner);
    void setCirculationPump(bool circulationPump);
    void setHeatChangerPump(bool heatChangerPump);

    void setTempHC(float tempHC);
    void setTempWater(float tempWater);
    void setTempTank(float tempTank);
    void setTempTank2(float tempTank2);
    void setTempBoiler(float tempBoiler);
    void setTempOutside(float tempOutside);
    void setTempSolar(float tempSolar);

    void sendCmd(quint8 cmd, quint64 value);
    void sendCmd(quint8 cmd, qlonglong value);
    void sendCmd(quint8 cmd, float value);
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

    void tempHCChanged();
    void tempWaterChanged();
    void tempTankChanged();
    void tempTank2Changed();
    void tempBoilerChanged();
    void tempOutsideChanged();
    void tempSolarChanged();

    void ntpTimeSynced();

public slots:
};

#endif // DEVICESTATE_H
