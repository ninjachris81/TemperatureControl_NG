#define CMD_LENGTH 3

// OTHERS
#define CMD_TIME 10
#define CMD_FREE_RAM 11
#define CMD_UPTIME 12

// SERVICE
#define CMD_RADIATOR_LEVEL 20

// IO
#define CMD_DISABLE_SIMULATION 39
#define CMD_IO_BASE 40

#define CMD_SOLAR_PUMP 40
#define CMD_RADIATOR_PUMP 41
#define CMD_GAS_BURNER 42
#define CMD_CIRCULATION_PUMP 43
#define CMD_HEAT_CHANGER_PUMP 44
#define CMD_BUZZER 45

// SENSORS
#define CMD_TEMP_BASE 60
// DIGITAL SENSORS
#define CMD_DTEMP_HC 60
#define CMD_DTEMP_WATER 61
#define CMD_DTEMP_TANK 62
#define CMD_DTEMP_SOLAR_BACK 63
// ANALOG SENSORS
#define CMD_ATEMP_TANK 64
#define CMD_ATEMP_BOILER 65
#define CMD_ATEMP_OUTSIDE 66
#define CMD_ATEMP_SOLAR 67

// CONFIG
#define CMD_CONF_HOLIDAY_MODE 80
#define CMD_CONF_PREHEAT_HOUR_FROM 81
#define CMD_CONF_PREHEAT_TARGET_TEMP_HC 82
#define CMD_CONF_PREHEAT_TARGET_TEMP_WATER 83
#define CMD_CONF_NORMAL_TEMP_HC 84
#define CMD_CONF_NORMAL_TEMP_WATER 85

// sync
#define CMD_SYNC_DATA 99

// errors
#define CMD_ERROR_BASE 100

#define CMD_ERROR_TIME 100
#define CMD_ERROR_DTEMP 101