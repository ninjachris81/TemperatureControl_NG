#include "SolarController.h"
#include "TemperatureController.h"
#include "ConfigController.h"
#include "IOController.h"

#include <Time.h>
#include <TimeLib.h>
#include <LogHelper.h>

#include "Pins.h"
#include "TaskIDs.h"

SolarController::SolarController() : AbstractIntervalTask(1000) {
  
}

void SolarController::init() {
  pumpState.init(0, false);

  pumpState.registerValueChangeListener(this);
}

void SolarController::update() {
  float tempSolar = taskManager->getTask<TemperatureController*>(TEMPERATURE_CONTROLLER)->getTemp(DIGITAL_SENSOR_COUNT + ATEMP_SENSOR_INDEX_SOLAR);
  float tempSolarBack = taskManager->getTask<TemperatureController*>(TEMPERATURE_CONTROLLER)->getTemp(DTEMP_SENSOR_INDEX_SOLAR_BACK);
  float tempTank = taskManager->getTask<TemperatureController*>(TEMPERATURE_CONTROLLER)->getTemp(DIGITAL_SENSOR_COUNT + ATEMP_SENSOR_INDEX_TANK);
  uint8_t delta = taskManager->getTask<ConfigController*>(CONFIG_CONTROLLER)->getConfig()->tempSolarDelta;

  bool newState = pumpState.getValue();
  
  if (!pumpState.getValue() && (tempSolar > tempTank + delta)) {
    newState = true;
  } else if (pumpState.getValue()) {
    // check if solar back is ok
    if (tempSolarBack < tempTank) {
      newState = false;
    }
  }

  pumpState.setValue(newState);
}

void SolarController::onPropertyValueChange(uint8_t id, bool value) {
  LOG_PRINT(F("Solar pump: "));
  LOG_PRINTLN(value);
  taskManager->getTask<IOController*>(IO_CONTROLLER)->setState(INDEX_CIRCULATION_PUMP, value);  
}

