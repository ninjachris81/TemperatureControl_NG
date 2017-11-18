/* META INFOS
target_package=esp8266
target_platform=esp8266
board=generic
*/

#include <AbstractIntervalTask.h>
#include <AbstractTask.h>
#include <AbstractTriggerTask.h>
#include <TaskManager.h>
#include <LogHelper.h>
#include <SoftwareSerial.h>

#include "WifiServer.h"
#include "SerialComm.h"
#include "TimeController.h"

TaskManager tm;

WifiServer wifiServer;
SerialComm serialComm;
TimeController timeController;

void setup() {
  // Open serial communications and wait for port to open:
  LOG_INIT();

  LOG_PRINTLN(F("INIT"));

  // same order as TaskIDs.h !!!
  tm.registerTask(&wifiServer);
  tm.registerTask(&timeController);
  tm.registerTask(&serialComm);

  tm.init();
}

void loop() {
  tm.update();
  delay(50);
}
