#include "TimeController.h"

#include <LogHelper.h>
#include <Time.h>
#include <TimeLib.h>
#include <DS1307RTC.h>

#include "TaskIDs.h"
#include "CommController.h"
#include "SerialProtocol.h"

TimeController::TimeController() : AbstractIntervalTask(5000, true) {
  
}

void TimeController::init() {
}

void TimeController::update() {
  if (!timeSet) {
    tmElements_t tm;
  
    if (RTC.read(tm)) {
      LOG_PRINTLN("RTC Time set");
      setTime(makeTime(tm));
      timeSet = true;
    } else {
      LOG_PRINTLN(F("DS1307 read error!"));
    }
  }
}

void TimeController::syncData(int filter) {
  if (filter==0 || filter==CMD_TIME)  taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(CMD_TIME, String(now()));
}

void TimeController::handleTime(unsigned long ts) {
  LOG_PRINT(F("Set time "));
  LOG_PRINTLN(ts);
  
  setTime(ts);

  LOG_PRINT(hour());
  LOG_PRINT(F(":"));
  LOG_PRINT(minute());
  LOG_PRINT(F(":"));
  LOG_PRINT(second());
  LOG_PRINT(" ");
  LOG_PRINT(day());
  LOG_PRINT(" ");
  LOG_PRINT(month());
  LOG_PRINT(" ");
  LOG_PRINTLN(year());
  
  tmElements_t tm;
  breakTime(ts, tm);
  if (!RTC.write(tm)) {
    LOG_PRINTLN(F("Error while setting RTC time"));
  }

  timeSet = true;
}

bool TimeController::timeIsSet() {
  return timeSet;
}

