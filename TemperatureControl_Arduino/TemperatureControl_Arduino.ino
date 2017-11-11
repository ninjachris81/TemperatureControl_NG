/* META INFOS
target_package=arduino
target_platform=avr
board=mega
*/

#include "Globals.h"

#include <LogHelper.h>
#include <AbstractIntervalTask.h>
#include <AbstractTask.h>
#include <AbstractTriggerTask.h>
#include <TaskManager.h>

#include "Debug.h"
#include "Credentials.h"
#include "IOController.h"
#include "TemperatureController.h"
#include "SolarController.h"
#include "CommController.h"
#include "HeaterController.h"
#include "ConfigController.h"
#include "BroadcastController.h"

TaskManager taskManager;

ConfigController configController;
IOController ioController;
TemperatureController temperatureController;
SolarController solarController;
CommController commController;
HeaterController heaterController;
BroadcastController broadcastController;

void setup() {
  LOG_INIT();

  LOG_PRINTLN(F("INIT"));

  taskManager.registerTask(&configController);
  taskManager.registerTask(&ioController);
  taskManager.registerTask(&temperatureController);
  taskManager.registerTask(&solarController);
  taskManager.registerTask(&commController);
  taskManager.registerTask(&heaterController);
  taskManager.registerTask(&broadcastController);

  taskManager.init();

  broadcastController.registerSyncSupport(&temperatureController);
  broadcastController.registerSyncSupport(&ioController);
}

void loop() {
  taskManager.update();
  delay(10);
}
