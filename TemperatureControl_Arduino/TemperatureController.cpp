#include "TemperatureController.h"
#include <LogHelper.h>
#include "TaskIDs.h"
#include "CommController.h"
#include "ErrorController.h"
#include "SerialProtocol.h"

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

  for (uint8_t i=0;i<TEMPERATURES_COUNT;i++) {
    temperatures[i].init(i, DEVICE_DISCONNECTED_C);
    temperatures[i].registerValueChangeListener(this);
  }
}

void TemperatureController::syncData(int filter) {
  for (uint8_t i=0;i<TEMPERATURES_COUNT;i++) {
    if (filter==-1 || filter==i) taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_TEMP_BASE + i, String(temperatures[i].getValue()));
  }
}

TemperatureController::~TemperatureController() {
  delete oneWire;
  delete sensors;
}

void TemperatureController::init() {
  sensors->begin();
  sensors->setWaitForConversion(false);

  byte addr[8];
  oneWire->search(addr);
  LOG_PRINT(F("Devices: "));
  LOG_PRINTLNF(sensors->getDeviceCount(), DEC);
  foundSensors = sensors->getDeviceCount();
}

void TemperatureController::update() {
  // update digital
  bool hadError = false;

  if (foundSensors==DIGITAL_SENSOR_COUNT) {
    
    for (uint8_t i=0;i<DIGITAL_SENSOR_COUNT;i++) {
      float v = sensors->getTempCByIndex(i);
      if (v!=DEVICE_DISCONNECTED_C) {
        digitalTemps[i].pushValue(v);
        temperatures[i].setValue(digitalTemps[i].getValue());
      } else {
        hadError = true;
      }
    }
    sensors->requestTemperatures();
  } else {
    hadError = true;
  }
  
  if (hadError) {
    byte addr[8];
    
    if (oneWire->search(addr)) {
      LOG_PRINT(F("Devices: "));
      LOG_PRINTLNF(sensors->getDeviceCount(), DEC);
      foundSensors = sensors->getDeviceCount();
    } else {
      LOG_PRINTLN(F("no 1-wire devices"));
      sensors->begin();
    }

    taskManager->getTask<ErrorController*>(ERROR_CONTROLLER)->raiseError(INDEX_ERROR_DTEMP);
  } else {
    taskManager->getTask<ErrorController*>(ERROR_CONTROLLER)->clearError(INDEX_ERROR_DTEMP);
  }

  // update analog
  for (uint8_t i=0;i<ANALOG_SENSOR_COUNT;i++) {
    analogTemps[i].read();
    temperatures[DIGITAL_SENSOR_COUNT + i].setValue(analogTemps[i].getValue());
  }
  
}

void TemperatureController::onPropertyValueChange(uint8_t id, float value) {
  /*
  LOG_PRINT(F("Temp "));
  LOG_PRINT(id);
  LOG_PRINT(F("changed to "));
  LOG_PRINTLN(value);
  */
  taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_TEMP_BASE + id, String(value));
}

void TemperatureController::simulateTemp(uint8_t index, float value) {
  if (index<TEMPERATURES_COUNT) {
    LOG_PRINT(F("Simulating Temp "));
    LOG_PRINT(index);
    LOG_PRINT(F("->"));
    LOG_PRINTLN(value);
    temperatures[index].setSimulatedValue(value);
  } else {
    LOG_PRINT(F("Invalid index"));
    LOG_PRINTLN(index);
  }
}

void TemperatureController::disableSimulation(uint8_t index) {
  if (index<TEMPERATURES_COUNT) {
    LOG_PRINT(F("Disable Simulation "));
    LOG_PRINT(index);
    temperatures[index].setSimulationOff();
  } else {
    LOG_PRINT(F("Invalid index"));
    LOG_PRINTLN(index);
  }
}

float TemperatureController::getTemp(uint8_t index) {
  return temperatures[index].getValue();
}
