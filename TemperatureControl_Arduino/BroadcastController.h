#ifndef BROADCASTCONTROLLER_H
#define BROADCASTCONTROLLER_H

#include <AbstractIntervalTask.h>
#include "Debug.h"
#include "Property.h"

#ifdef IS_DEBUG
  #define BROADCAST_INTERVAL 5000
#else 
  #define BROADCAST_INTERVAL 10000
#endif

#define MAX_SYNC_SUPPORT 10

class BroadcastController : public AbstractIntervalTask, public Property<int>::ValueChangeListener {
public:
  class SyncSupport {
  public:
    virtual void syncData(int filter = -1) = 0;
  };

  BroadcastController();

  void init();

  void update();

  void syncData(int filter = -1);

  void onPropertyValueChange(uint8_t id, int value);

  void registerSyncSupport(SyncSupport* ss);
  
private:
  int getFreeRam();
  uint8_t syncSupportCount = 0;

  SyncSupport* syncSupports[MAX_SYNC_SUPPORT];

  Property<int> freeRam;

};


#endif   // BROADCASTCONTROLLER_H
