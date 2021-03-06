#include "CommController.h"
#include <LogHelper.h>
#include <Time.h>
#include <TimeLib.h>

#include "Pins.h"
#include "TimeController.h"
#include "SerialProtocol.h"
#include "IOController.h"
#include "ConfigController.h"
#include "TemperatureController.h"
#include "BroadcastController.h"
#include "HeaterController.h"
#include "BuzzerController.h"
#include "ErrorController.h"
#include "TaskIDs.h"

CommController::CommController() : AbstractTask() {
  
}

void CommController::init() {
  PIN_SERIAL_COMM.begin(9600);
  PIN_SERIAL_ESP.begin(9600);
  PIN_SERIAL_COMM.setTimeout(500);
  PIN_SERIAL_ESP.setTimeout(500);
}

void CommController::update() {
  //_update(PIN_SERIAL_COMM);
  //_update(PIN_SERIAL_ESP);
}

void CommController::incomingData(String data) {
  if (data.substring(0,CMD_ID)==RECEIVER_MEGA || data.substring(0, CMD_ID)==RECEIVER_ALL) {
    LOG_PRINT(F("Received: "));
    LOG_PRINTLN(data);

    uint8_t cmd = data.substring(CMD_ID,CMD_VALUE_OFFSET).toInt();

    switch(cmd) {
      case CMD_TIME: {
        unsigned long epoch = strtoul(data.substring(CMD_VALUE_OFFSET).c_str(), NULL, 10);
        taskManager->getTask<TimeController*>(TIME_CONTROLLER)->handleTime(epoch);
        break;
      }
      case CMD_RADIATOR_LEVEL:
        taskManager->getTask<HeaterController*>(HEATER_CONTROLLER)->setRadiatorLevel(data.substring(CMD_VALUE_OFFSET).toInt());
        break;
      case CMD_SOLAR_PUMP:
      case CMD_RADIATOR_PUMP:
      case CMD_GAS_BURNER:
      case CMD_CIRCULATION_PUMP:
      case CMD_HEAT_CHANGER_PUMP:
        LOG_PRINTLN(F("Simulating IO"));
        taskManager->getTask<IOController*>(IO_CONTROLLER)->simulateState(cmd - CMD_IO_BASE, data.substring(CMD_VALUE_OFFSET).toInt()==1);
        break;
        
      case CMD_BUZZER:
        LOG_PRINTLN(F("Buzzer"));
        taskManager->getTask<BuzzerController*>(BUZZER_CONTROLLER)->setBuzzerState(data.substring(CMD_VALUE_OFFSET).toInt()==1);
        break;

      case CMD_DISABLE_SIMULATION:
        if (data.substring(CMD_VALUE_OFFSET).toInt()>=CMD_TEMP_BASE) {
          LOG_PRINTLN(F("Disable Temp simulation"));
          taskManager->getTask<TemperatureController*>(TEMPERATURE_CONTROLLER)->disableSimulation(data.substring(CMD_VALUE_OFFSET).toInt() - CMD_TEMP_BASE);
        } else if (data.substring(CMD_VALUE_OFFSET).toInt()>=CMD_IO_BASE) {
          LOG_PRINTLN(F("Disable IO simulation"));
          taskManager->getTask<IOController*>(IO_CONTROLLER)->disableSimulation(data.substring(CMD_VALUE_OFFSET).toInt() - CMD_IO_BASE);
        } else {
          LOG_PRINTLN(F("Unknown disable simu"));
        }
        break;
        
      case CMD_CONF_HOLIDAY_MODE:
      case CMD_CONF_PREHEAT_HOUR_FROM:
      case CMD_CONF_PREHEAT_TARGET_TEMP_HC:
      case CMD_CONF_PREHEAT_TARGET_TEMP_WATER:
      case CMD_CONF_NORMAL_TEMP_HC:
      case CMD_CONF_NORMAL_TEMP_WATER:
        LOG_PRINTLN(F("Set Config"));
        taskManager->getTask<ConfigController*>(CONFIG_CONTROLLER)->setConfigValue(cmd, data.substring(CMD_VALUE_OFFSET));
        break;

      case CMD_DTEMP_HC:
      case CMD_DTEMP_WATER:
      case CMD_DTEMP_TANK:
      case CMD_DTEMP_SOLAR_BACK:
      case CMD_ATEMP_TANK:
      case CMD_ATEMP_BOILER:
      case CMD_ATEMP_OUTSIDE:
      case CMD_ATEMP_SOLAR:
        LOG_PRINTLN(F("Simulating Temp"));
        taskManager->getTask<TemperatureController*>(TEMPERATURE_CONTROLLER)->simulateTemp(cmd - CMD_TEMP_BASE, data.substring(CMD_VALUE_OFFSET).toFloat());
        break;
        
      case CMD_SYNC_DATA: {
        int filter = -1;
        if (data.length()>CMD_VALUE_OFFSET) filter = data.substring(CMD_VALUE_OFFSET).toInt();
        LOG_PRINT(F("Sync data "));
        LOG_PRINTLN(filter);
        taskManager->getTask<BroadcastController*>(BROADCAST_CONTROLLER)->syncData(filter);
        break;
      }
      
      case CMD_ERROR_TIME:
      case CMD_ERROR_DTEMP:
        if (data.substring(CMD_VALUE_OFFSET).toInt()==1) {
          LOG_PRINTLN(F("Simulate raise error"));
          taskManager->getTask<ErrorController*>(ERROR_CONTROLLER)->raiseError(CMD_ERROR_BASE - cmd);
        } else {
          LOG_PRINTLN(F("Simulate clear error"));
          taskManager->getTask<ErrorController*>(ERROR_CONTROLLER)->clearError(CMD_ERROR_BASE - cmd);
        }
        break;
        
      default:
        LOG_PRINT(F("Unknown cmd "));
        LOG_PRINTLN(cmd);
    }
  } else {
    // ignore
  }
}

void CommController::sendCmd(uint8_t cmd, String value) {
  _sendCmd(PIN_SERIAL_COMM, RECEIVER_RPI, cmd, value);
  _sendCmd(PIN_SERIAL_ESP, RECEIVER_ESP, cmd, value);
}

void CommController::_sendCmd(HardwareSerial &target, String receiver, uint8_t cmd, String value) {
  LOG_PRINT(F("Sending: "));
  LOG_PRINT(cmd);
  LOG_PRINT(" ");
  LOG_PRINTLN(value);

  if (target) {
    target.print(receiver);
    if (cmd<10) {
      target.print("00");
    } else if (cmd<100) {
      target.print("0");
    }
    target.print(cmd);
    target.println(value);
  } else {
    LOG_PRINT(F("Cannot send to target"));
  }
}

