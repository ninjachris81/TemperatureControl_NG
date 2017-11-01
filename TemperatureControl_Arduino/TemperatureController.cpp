#include "TemperatureController.h"
#include <LogHelper.h>

TemperatureController::TemperatureController() : AbstractIntervalTask(TEMP_INTERVAL_MS) {
  oneWire = new OneWire(PIN_DIGITAL_TEMP_SENSORS);
  sensors = new DallasTemperature(oneWire);
  for (uint8_t i=0;i<DIGITAL_SENSOR_COUNT;i++) digitalTemps[i].init(SMOOTH_SIZE, DEVICE_DISCONNECTED_C);
  
  for (uint8_t i=0;i<ANALOG_SENSOR_COUNT;i++) {
    int addr;
    switch(i) {
      case ATEMP_SENSOR_INDEX_TANK:
        addr = PIN_TEMP_TANK;
        break;
      case ATEMP_SENSOR_INDEX_BOILER:
        addr = PIN_TEMP_BOILER;
        break;
      case ATEMP_SENSOR_INDEX_OUTSIDE:
        addr = PIN_TEMP_OUTSIDE;
        break;
      case ATEMP_SENSOR_INDEX_SOLAR:
        addr = PIN_TEMP_SOLAR;
        break;
    }
    
    analogTemps[i].init(addr, SMOOTH_SIZE, DEVICE_DISCONNECTED_C, ANALOG_KNOWN_R);
  }
}

TemperatureController::~TemperatureController() {
  delete oneWire;
  delete sensors;
}

void TemperatureController::init() {
  sensors->begin();
  sensors->setWaitForConversion(false);
}

void TemperatureController::update() {
  // update digital
  if (foundSensors==DIGITAL_SENSOR_COUNT) {
    for (uint8_t i=0;i<DIGITAL_SENSOR_COUNT;i++) {
      digitalTemps[i].pushValue(sensors->getTempCByIndex(i));
      if (digitalTemps[i].getValue()==DEVICE_DISCONNECTED_C) {
        sensors->begin();
        foundSensors = sensors->getDeviceCount();
        LOG_PRINT(F("Devices: "));
        LOG_PRINTLNF(sensors->getDeviceCount(), DEC);
      }
    }
    sensors->requestTemperatures();
    
  } else {
    byte addr[8];
    
    if (oneWire->search(addr)) {
      LOG_PRINT(F("Devices: "));
      LOG_PRINTLNF(sensors->getDeviceCount(), DEC);
      foundSensors = sensors->getDeviceCount();
    } else {
      LOG_PRINTLN(F("no 1-wire devices"));
      sensors->begin();
    }
  }

  // update analog
  for (uint8_t i=0;i<ANALOG_SENSOR_COUNT;i++) {
    analogTemps[i].read();
  }
  
}

float TemperatureController::getTempHC() {
  return digitalTemps[DTEMP_SENSOR_INDEX_HC].getValue();;
}

float TemperatureController::getTempW() {
  return digitalTemps[DTEMP_SENSOR_INDEX_W].getValue();;
}

float TemperatureController::getTempTank() {
  return digitalTemps[DTEMP_SENSOR_INDEX_TANK].getValue();;
}

