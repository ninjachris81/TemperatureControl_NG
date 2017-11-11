#include "HeaterController.h"

#include <LogHelper.h>
#include <Time.h>
#include <TimeLib.h>

#include "Pins.h"
#include "TaskIDs.h"
#include "IOController.h"
#include "TemperatureController.h"
#include "ConfigController.h"

HeaterController::HeaterController() : AbstractIntervalTask(1000) {
  
}

void HeaterController::init() {
  heatingState.init(PROP_ID_HEATING, false);
  radiatorState.init(PROP_ID_RADIATOR, false);

  heatingState.registerValueChangeListener(this);
  radiatorState.registerValueChangeListener(this);
}

void HeaterController::update() {

  float tempTank1 = taskManager->getTask<TemperatureController*>(TEMPERATURE_CONTROLLER)->getTemp(DTEMP_SENSOR_INDEX_TANK);

  if (hour() >= taskManager->getTask<ConfigController*>(CONFIG_CONTROLLER)->getConfig()->gasBurnerActiveHourFrom && hour() < taskManager->getTask<ConfigController*>(CONFIG_CONTROLLER)->getConfig()->gasBurnerActiveHourTo) {
    uint8_t startTemp = taskManager->getTask<ConfigController*>(CONFIG_CONTROLLER)->getConfig()->gasBurnerTankStartTemp;
    uint8_t endTemp = taskManager->getTask<ConfigController*>(CONFIG_CONTROLLER)->getConfig()->gasBurnerTankEndTemp;
  
    if (tempTank1 < startTemp) {
      heatingState.setValue(true);
    } else if (tempTank1 > endTemp) {
      heatingState.setValue(false);
    }
  } else {
    LOG_PRINTLN(F("Gas Burner not active"));
    heatingState.setValue(false);
  }
  
  //float tempTank2 = taskManager->getTask<TemperatureController*>(TEMPERATURE_CONTROLLER)->getTemp(DIGITAL_SENSOR_COUNT + ATEMP_SENSOR_INDEX_TANK);

  
  //taskManager->getTask<IOController*>(IO_CONTROLLER)->

}

void HeaterController::onPropertyValueChange(uint8_t id, bool value) {
  switch(id) {
    case PROP_ID_HEATING:
      LOG_PRINT(F("HEATING "));
      LOG_PRINTLN(value);
      taskManager->getTask<IOController*>(IO_CONTROLLER)->setState(PIN_GAS_BURNER - PIN_IO_BASE, value);
      break;
    case PROP_ID_RADIATOR:
      LOG_PRINT(F("RADIATOR "));
      LOG_PRINTLN(value);
      taskManager->getTask<IOController*>(IO_CONTROLLER)->setState(PIN_RADIATOR_PUMP - PIN_IO_BASE, value);
      break;
  }
}

