#include "ErrorController.h"

#include <LogHelper.h>

#include "SerialProtocol.h"
#include "BuzzerController.h"
#include "CommController.h"
#include "TimeController.h"
#include "TaskIDs.h"

ErrorController::ErrorController() :  AbstractTriggerTask() {
}

void ErrorController::init() {
  triggerUpdateDelay(10000);    // do delayed sanity check

  for (uint8_t i=0;i<ERROR_COUNT;i++) errors[i] = false;
}

void ErrorController::update() {
  LOG_PRINTLN(F("Sanity check"));

  if (!taskManager->getTask<TimeController*>(TIME_CONTROLLER)->timeIsSet()) raiseError(INDEX_ERROR_TIME);
}

void ErrorController::syncData(int filter) {
  for (uint8_t i=0;i<ERROR_COUNT;i++) {
    if (filter==-1 || filter==i) taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_ERROR_BASE + i, String(errors[i]));
  }
}

void ErrorController::checkBuzzerState() {
  for (uint8_t i=0;i<ERROR_COUNT;i++) {
    if (errors[i]) {
      taskManager->getTask<BuzzerController*>(BUZZER_CONTROLLER)->setBuzzerState(true);
      return;
    }
  }
  
  taskManager->getTask<BuzzerController*>(BUZZER_CONTROLLER)->setBuzzerState(false);
}

void ErrorController::raiseError(uint8_t type) {
  if (type>=ERROR_COUNT) return;
  
  if (errors[type]) return;    // already
  
  errors[type] = true;
  taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_ERROR_BASE + type, F("0"));
  checkBuzzerState();
}

void ErrorController::clearError(uint8_t type) {
  if (type>=ERROR_COUNT) return;
  if (!errors[type]) return;    // already

  errors[type] = false;
  taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_ERROR_BASE + type, F("0"));
  checkBuzzerState();
}

