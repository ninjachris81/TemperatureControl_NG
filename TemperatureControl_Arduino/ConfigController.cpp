#include "ConfigController.h"

#include <LogHelper.h>
#include "SerialProtocol.h"

ConfigController::ConfigController() : AbstractTriggerTask() {
}

void ConfigController::init() {
  loadConfig();
}

void ConfigController::update() {  
}

ConfigController::ConfigStruct* ConfigController::getConfig() {
  return &settings;
}

void ConfigController::setConfigValue(uint8_t cmd, String value) {
  LOG_PRINT(F("Setting "));
  LOG_PRINT(cmd);
  LOG_PRINT(F("->"));
  LOG_PRINTLN(value);

  switch(cmd) {
    case CMD_CONF_HOLIDAY_MODE:
      settings.holidayMode = value=="1" ? true : false;
      break;
    case CMD_CONF_PREHEAT_HOUR_FROM:
      settings.preheatHourFrom = constrain(value.toInt(), 0, 23);
      break;
    case CMD_CONF_PREHEAT_TARGET_TEMP_HC:
      settings.preheatTargetTempHC = constrain(value.toInt(), 10, 50);
      break;
    case CMD_CONF_PREHEAT_TARGET_TEMP_WATER:
      settings.preheatTargetTempWater = constrain(value.toInt(), 10, 50);
      break;
    case CMD_CONF_NORMAL_TEMP_HC:
      settings.normalTempHC = constrain(value.toInt(), 10, 50);
      break;
    case CMD_CONF_NORMAL_TEMP_WATER:
      settings.normalTempWater = constrain(value.toInt(), 10, 50);
      break;
    default:
      LOG_PRINT(F("Unknown config cmd "));
      LOG_PRINTLN(cmd);
      return;
  }

  saveConfig();
}

void ConfigController::loadConfig() {
  LOG_PRINTLN(F("Loading config"));

  // To make sure there are settings, and they are YOURS!
  // If nothing is found it will use the default settings.
  if (//EEPROM.read(CONFIG_START + sizeof(settings) - 1) == settings.version_of_program[3] // this is '\0'
      EEPROM.read(CONFIG_START + sizeof(settings) - 2) == settings.version_of_program[2] &&
      EEPROM.read(CONFIG_START + sizeof(settings) - 3) == settings.version_of_program[1] &&
      EEPROM.read(CONFIG_START + sizeof(settings) - 4) == settings.version_of_program[0])
  { // reads settings from EEPROM
    for (unsigned int t=0; t<sizeof(settings); t++)
      *((char*)&settings + t) = EEPROM.read(CONFIG_START + t);
  } else {
    // settings aren't valid! will overwrite with default settings
    saveConfig();
  }

  printConfig();  
}

void ConfigController::printConfig() {
  LOG_PRINTLN(F("Config:"));
  LOG_PRINT(F("HM:"));
  LOG_PRINTLN(settings.holidayMode);
  LOG_PRINT(F("PHF:"));
  LOG_PRINTLN(settings.preheatHourFrom);
  LOG_PRINT(F("PTTHC:"));
  LOG_PRINTLN(settings.preheatTargetTempHC);
  LOG_PRINT(F("PTTW:"));
  LOG_PRINTLN(settings.preheatTargetTempWater);
  LOG_PRINT(F("NTHC:"));
  LOG_PRINTLN(settings.normalTempHC);
  LOG_PRINT(F("NTW"));
  LOG_PRINTLN(settings.normalTempWater);
}

void ConfigController::saveConfig() {
  LOG_PRINTLN(F("Saving config"));
  
  for (unsigned int t=0; t<sizeof(settings); t++)
  { // writes to EEPROM
    EEPROM.write(CONFIG_START + t, *((char*)&settings + t));
    // and verifies the data
    if (EEPROM.read(CONFIG_START + t) != *((char*)&settings + t))
    {
      // error writing to EEPROM
    }
  }

  printConfig();
}
