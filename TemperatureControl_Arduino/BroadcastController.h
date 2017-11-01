#ifndef BROADCASTCONTROLLER_H
#define BROADCASTCONTROLLER_H

#include <AbstractIntervalTask.h>
#include "Debug.h"

#ifdef IS_DEBUG
  #define BROADCAST_INTERVAL 2000
#else 
  #define BROADCAST_INTERVAL 5000
#endif

class BroadcastController : public AbstractIntervalTask {
public:
  BroadcastController();

  void init();

  void update();
private:
  int getFreeRam();

};


#endif   // BROADCASTCONTROLLER_H
