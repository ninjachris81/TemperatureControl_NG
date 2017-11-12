#ifndef HEATERCONTROLLER_H
#define HEATERCONTROLLER_H

#include <AbstractIntervalTask.h>
#include <Property.h>
#include "BroadcastController.h"
#include "Debug.h"

#define PROP_ID_HEATING 0
#define PROP_ID_RADIATOR 1

#ifdef IS_DEBUG
  #define RADIATOR_BASE_INTERVAL 30000
#else
  #define RADIATOR_BASE_INTERVAL 600000       // 10 min
#endif

#define RADIATOR_PAUSE 2000

class HeaterController : public AbstractIntervalTask, public Property<bool>::ValueChangeListener, public BroadcastController::SyncSupport {
public:
  HeaterController();

  void init();

  void update();

  void onPropertyValueChange(uint8_t id, bool value);

  void syncData(int filter = -1);

  void setRadiatorLevel(uint8_t radiatorLevel);

private:
  uint8_t radiatorLevel = 0;
  uint64_t radiatorLastToggle = 0;
  
  Property<bool> heatingState;
  Property<bool> radiatorState;

};


#endif   // HEATERCONTROLLER_H
