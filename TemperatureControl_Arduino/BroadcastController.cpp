#include "BroadcastController.h"

#include "CommController.h"
#include "TaskIDs.h"
#include "SerialProtocol.h"
#include <Time.h>
#include <TimeLib.h>
#include <LogHelper.h>

BroadcastController::BroadcastController() : AbstractIntervalTask(BROADCAST_INTERVAL) {
}

void BroadcastController::init() {
  freeRam.init(0, getFreeRam());
}

void BroadcastController::onPropertyValueChange(uint8_t id, int value) {
  taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_FREE_RAM, String(value));
}

int BroadcastController::getFreeRam()
{
  extern int __heap_start, *__brkval;
  int v;

  return (int)&v - (__brkval == 0 ? (int)&__heap_start : (int)__brkval);
}

void BroadcastController::update() {
  freeRam.setValue(getFreeRam());
  
  taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_UPTIME, String(millis()));
  taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_TIME, String(now()));
}

void BroadcastController::registerSyncSupport(SyncSupport* ss) {
  if (syncSupportCount>=MAX_SYNC_SUPPORT) return;
  syncSupports[syncSupportCount] = ss;
  syncSupportCount++;
}

void BroadcastController::syncData(int filter) {
  if (filter==-1 || filter==CMD_FREE_RAM) taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_FREE_RAM, String(freeRam.getValue()));
  if (filter==-1 || filter==CMD_UPTIME) taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_UPTIME, String(millis()));
  if (filter==-1 || filter==CMD_TIME) taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_TIME, String(now()));

  for (uint8_t i=0;i<syncSupportCount;i++) {
    syncSupports[i]->syncData(filter);
  }
}

