#ifndef TEMPERATURECONTROLLER_H
#define TEMPERATURECONTROLLER_H

#include <AbstractIntervalTask.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <SmoothValue.h>
#include <Property.h>
#include <AnalogTempSensor.h>
#include "BroadcastController.h"

#include "Pins.h"

#define TEMP_INTERVAL_MS 1000

#define DIGITAL_SENSOR_COUNT 4

#define DTEMP_SENSOR_INDEX_HC 0
#define DTEMP_SENSOR_INDEX_W 1
#define DTEMP_SENSOR_INDEX_TANK 2
#define DTEMP_SENSOR_INDEX_SOLAR_BACK 3

#define ANALOG_SENSOR_COUNT 4

#define ANALOG_KNOWN_R 9910.0

#define ATEMP_SENSOR_INDEX_TANK 0
#define ATEMP_SENSOR_INDEX_BOILER 1
#define ATEMP_SENSOR_INDEX_OUTSIDE 2
#define ATEMP_SENSOR_INDEX_SOLAR 3

#define TEMPERATURES_COUNT DIGITAL_SENSOR_COUNT+ANALOG_SENSOR_COUNT

class TemperatureController : public AbstractIntervalTask, public Property<float>::ValueChangeListener, public BroadcastController::SyncSupport {
public:
  TemperatureController();
  ~TemperatureController();

  void syncData(int filter = -1);

  void init();

  void update();

  void simulateTemp(uint8_t index, float value);
  
  void disableSimulation(uint8_t index);

  float getTemp(uint8_t index);

  void onPropertyValueChange(uint8_t id, float value);

private:
  uint8_t foundSensors = 0;
  OneWire *oneWire;
  DallasTemperature* sensors;
  SmoothValue digitalTemps[DIGITAL_SENSOR_COUNT];

  AnalogTempSensor analogTemps[ANALOG_SENSOR_COUNT];

  Property<float> temperatures[TEMPERATURES_COUNT];
};

#endif    // TEMPERATURECONTROLLER_H
