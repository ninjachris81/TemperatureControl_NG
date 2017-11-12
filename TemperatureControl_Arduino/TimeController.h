#ifndef TIMEHELPER_H
#define TIMEHELPER_H

#include <AbstractIntervalTask.h>
#include "BroadcastController.h"

#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif

class TimeController : public AbstractIntervalTask, public BroadcastController::SyncSupport {

public:
  TimeController();

  void init();

  void update();
  
  void syncData(int filter = -1);

  void handleTime(unsigned long ts);

  bool timeIsSet();
  
private:
  bool timeSet = false;
};

#endif
