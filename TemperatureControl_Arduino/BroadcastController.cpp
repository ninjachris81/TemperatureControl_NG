#include "BroadcastController.h"

#include "CommController.h"
#include "TaskIDs.h"
#include "SerialProtocol.h"
#include <Time.h>
#include <TimeLib.h>

BroadcastController::BroadcastController() : AbstractIntervalTask(BROADCAST_INTERVAL) {
  
}

void BroadcastController::init() {
  
}

int BroadcastController::getFreeRam()
{
  extern int __heap_start, *__brkval;
  int v;

  return (int)&v - (__brkval == 0 ? (int)&__heap_start : (int)__brkval);
}

void BroadcastController::update() {
    taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_FREE_RAM, String(getFreeRam()));
    taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_UPTIME, String(millis()));
    taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_TIME, String(now()));
}
