#ifndef CONFIGCONTROLLER_H
#define CONFIGCONTROLLER_H

#include <EEPROM.h>
#include <AbstractTriggerTask.h>

#define CONFIG_START 32
#define CONFIG_VERSION "ls1"

class ConfigController : public AbstractTriggerTask {

public:
  ConfigController();

  struct ConfigStruct {
    bool holidayMode;
    
    uint8_t preheatHourFrom;
    uint8_t preheatTargetTempHC;
    uint8_t preheatTargetTempWater;

    uint8_t normalTempHC;
    uint8_t normalTempWater;

    uint8_t gasBurnerTankStartTemp;
    uint8_t gasBurnerTankEndTemp;
    uint8_t gasBurnerMinToggleTimeMin;
    uint8_t gasBurnerActiveHourFrom;
    uint8_t gasBurnerActiveHourTo;

    uint8_t tempSolarDelta;
    
    // This is for mere detection if they are your settings
    char version_of_program[4]; // it is the last variable of the struct
    // so when settings are saved, they will only be validated if
    // they are stored completely.
  } settings = {
    // The default values
    false,
    6, 38,32,
    32, 25,
    38, 45, 10,
    5, 23,
    3,
    CONFIG_VERSION
  };

  void init();

  void update();

  ConfigStruct* getConfig();
  
  void saveConfig();

  void setConfigValue(uint8_t cmd, String value);

private:
  void loadConfig();

  void printConfig();
};

#endif    // CONFIGCONTROLLER_H
