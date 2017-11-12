#include "HeaterController.h"

#include <LogHelper.h>
#include <Time.h>
#include <TimeLib.h>

#include "Pins.h"
#include "TaskIDs.h"
#include "IOController.h"
#include "TemperatureController.h"
#include "ConfigController.h"
#include "CommController.h"
#include "SerialProtocol.h"

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
    //LOG_PRINTLN(F("Gas Burner not active"));
    heatingState.setValue(false);
  }

  if (radiatorLevel>0) {
    // check if we need to toggle
    if (radiatorState.getValue() && (radiatorLastToggle==0 || millis() - radiatorLastToggle > (RADIATOR_BASE_INTERVAL / radiatorLevel))) {
      // ok, toggle off shortly
      LOG_PRINTLN(F("Rad short toggle off"));
      radiatorState.setValue(false);
      radiatorLastToggle = millis();
    } else if (!radiatorState.getValue() && (radiatorLastToggle==0 || millis() - radiatorLastToggle > RADIATOR_PAUSE)) {
      // ok, toggle on
      LOG_PRINTLN(F("Rad short toggle on"));
      radiatorState.setValue(true);
      radiatorLastToggle = millis();
    } else {
      /*
      LOG_PRINT(F("Rad"));
      LOG_PRINT(String((unsigned int)(millis() - radiatorLastToggle)));
      LOG_PRINTLN(String(RADIATOR_BASE_INTERVAL / radiatorLevel));
      */
    }
  } else {
    radiatorState.setValue(false);
  }
  //float tempTank2 = taskManager->getTask<TemperatureController*>(TEMPERATURE_CONTROLLER)->getTemp(DIGITAL_SENSOR_COUNT + ATEMP_SENSOR_INDEX_TANK);
}

void HeaterController::onPropertyValueChange(uint8_t id, bool value) {
  switch(id) {
    case PROP_ID_HEATING:
      LOG_PRINT(F("HEATING "));
      LOG_PRINTLN(value);
      taskManager->getTask<IOController*>(IO_CONTROLLER)->setState(INDEX_GAS_BURNER, value);
      break;
    case PROP_ID_RADIATOR:
      LOG_PRINT(F("RADIATOR "));
      LOG_PRINTLN(value);
      taskManager->getTask<IOController*>(IO_CONTROLLER)->setState(INDEX_RADIATOR_PUMP, value);
      break;
  }
}

void HeaterController::syncData(int filter) {
  if (filter==0 || filter==CMD_RADIATOR_LEVEL) taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_RADIATOR_LEVEL, String(radiatorLevel));
}

void HeaterController::setRadiatorLevel(uint8_t radiatorLevel) {
  if (this->radiatorLevel==radiatorLevel) return;
  
  radiatorLevel = constrain(radiatorLevel, 0, 8);
  this->radiatorLevel = radiatorLevel;
  taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_RADIATOR_LEVEL, String(radiatorLevel));
}


