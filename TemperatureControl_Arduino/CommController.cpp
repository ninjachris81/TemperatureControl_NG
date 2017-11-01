#include "CommController.h"
#include <LogHelper.h>
#include <Time.h>
#include <TimeLib.h>

#include "Pins.h"
#include "TimeHelper.h"
#include "SerialProtocol.h"
#include "IOController.h"
#include "ConfigController.h"
#include "TaskIDs.h"

CommController::CommController() : AbstractTask() {
  
}

void CommController::init() {
  PIN_SERIAL_COMM.begin(9600);
}

void CommController::update() {
  if (PIN_SERIAL_COMM.available()) {
    String s = PIN_SERIAL_COMM.readStringUntil('\n');

    LOG_PRINTLN(F("Received:"));
    LOG_PRINTLN(s);

    uint8_t cmd = s.substring(0,2).toInt();

    switch(cmd) {
      case CMD_TIME: {
        unsigned long epoch = strtoul(s.substring(2).c_str(), NULL, 10);
        TimeHelper::handleTime(epoch);
        break;
      }
      case CMD_SOLAR_PUMP:
      case CMD_RADIATOR_PUMP:
      case CMD_GAS_BURNER:
      case CMD_CIRCULATION_PUMP:
      case CMD_HEAT_CHANGER_PUMP:
        LOG_PRINTLN(F("Simulating IO"));
        taskManager->getTask<IOController*>(IO_CONTROLLER)->simulateState(cmd - PIN_IO_BASE, s.substring(2).toInt()==1);
        break;
      case CMD_DISABLE_SIMULATION:
        LOG_PRINTLN(F("Disable simulation"));
        taskManager->getTask<IOController*>(IO_CONTROLLER)->disableSimulation(s.substring(2).toInt() - PIN_IO_BASE);
        break;
      case CMD_CONF_HOLIDAY_MODE:
      case CMD_CONF_PREHEAT_HOUR_FROM:
      case CMD_CONF_PREHEAT_TARGET_TEMP_HC:
      case CMD_CONF_PREHEAT_TARGET_TEMP_WATER:
      case CMD_CONF_NORMAL_TEMP_HC:
      case CMD_CONF_NORMAL_TEMP_WATER:
        LOG_PRINTLN(F("Set Config"));
        taskManager->getTask<ConfigController*>(CONFIG_CONTROLLER)->setConfigValue(cmd, s.substring(2));
        break;
      default:
        LOG_PRINT(F("Unknown cmd "));
        LOG_PRINTLN(cmd);
    }
  }
}

void CommController::sendCmd(uint8_t cmd, String value) {
  PIN_SERIAL_COMM.print("!");
  PIN_SERIAL_COMM.print(cmd);
  PIN_SERIAL_COMM.println(value);
}

