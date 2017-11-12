#ifndef IOCONTROLLER_H
#define IOCONTROLLER_H

#include <AbstractIntervalTask.h>
#include <BehaviorProperty.h>
#include "BroadcastController.h"
#include "Debug.h"

#define STATE_COUNT 6

#define INDEX_SOLAR_PUMP PIN_SOLAR_PUMP - PIN_IO_BASE
#define INDEX_RADIATOR_PUMP PIN_RADIATOR_PUMP - PIN_IO_BASE
#define INDEX_GAS_BURNER PIN_GAS_BURNER - PIN_IO_BASE
#define INDEX_CIRCULATION_PUMP PIN_CIRCULATION_PUMP - PIN_IO_BASE
#define INDEX_HEAT_CHANGER_PUMP PIN_HEAT_CHANGER_PUMP - PIN_IO_BASE
#define INDEX_BUZZER PIN_BUZZER - PIN_IO_BASE

#ifdef IS_DEBUG
  #define GENERAL_TOGGLE_TIME 5000
  #define GAS_BURNER_TOGGLE_TIME_MIN_FACTOR 1000
#else
  #define GENERAL_TOGGLE_TIME 10000
  #define GAS_BURNER_TOGGLE_TIME_MIN_FACTOR 60000
#endif

class IOController : public AbstractIntervalTask, public Property<bool>::ValueChangeListener, public BroadcastController::SyncSupport {
public:
  IOController();

  void syncData(int filter = -1);

  void init();

  void update();

  void setState(uint8_t index, bool state);

  void simulateState(uint8_t index, bool state);

  void disableSimulation(uint8_t index);

  void onPropertyValueChange(uint8_t id, bool value);

private:
  BehaviorProperty<bool> ioStates[STATE_COUNT];


};

#endif
