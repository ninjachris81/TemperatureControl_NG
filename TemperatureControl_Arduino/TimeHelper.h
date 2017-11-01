#ifndef TIMEHELPER_H
#define TIMEHELPER_H

#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif

class TimeHelper {

public:
  static void handleTime(unsigned long ts);

  static bool timeIsSet();
  
private:
  static bool timeSet;
};

#endif
