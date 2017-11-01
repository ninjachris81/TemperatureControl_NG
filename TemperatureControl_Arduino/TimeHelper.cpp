#include "TimeHelper.h"

#include <LogHelper.h>
#include <Time.h>
#include <TimeLib.h>

bool TimeHelper::timeSet = false;

void TimeHelper::handleTime(unsigned long ts) {
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
  
  timeSet = true;
}

bool TimeHelper::timeIsSet() {
  return timeSet;
}

