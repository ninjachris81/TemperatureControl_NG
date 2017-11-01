#ifndef TEMPERATURECONTROLLER_H
#define TEMPERATURECONTROLLER_H

#include <AbstractIntervalTask.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <SmoothValue.h>
#include <AnalogTempSensor.h>

#include "Pins.h"

#define TEMP_INTERVAL_MS 1000

#define DIGITAL_SENSOR_COUNT 3

#define DTEMP_SENSOR_INDEX_HC 0
#define DTEMP_SENSOR_INDEX_W 1
#define DTEMP_SENSOR_INDEX_TANK 2

#define ANALOG_SENSOR_COUNT 4

#define ANALOG_KNOWN_R 9910.0

#define ATEMP_SENSOR_INDEX_TANK 0
#define ATEMP_SENSOR_INDEX_BOILER 1
#define ATEMP_SENSOR_INDEX_OUTSIDE 2
#define ATEMP_SENSOR_INDEX_SOLAR 3

class TemperatureController : public AbstractIntervalTask {
public:
  TemperatureController();
  ~TemperatureController();

  void init();

  void update();

  float getTempHC();
  float getTempW();
  float getTempTank();

private:
  uint8_t foundSensors = 0;
  OneWire *oneWire;
  DallasTemperature* sensors;
  SmoothValue digitalTemps[DIGITAL_SENSOR_COUNT];

  AnalogTempSensor analogTemps[ANALOG_SENSOR_COUNT];
};

#endif    // TEMPERATURECONTROLLER_H
