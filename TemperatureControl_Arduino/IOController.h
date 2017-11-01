#ifndef IOCONTROLLER_H
#define IOCONTROLLER_H

#include <AbstractIntervalTask.h>
#include <Property.h>

#define STATE_COUNT 5

class IOController : public AbstractIntervalTask, public Property<bool>::ValueChangeListener {
public:
  IOController();

  void init();

  void update();

  void setState(uint8_t index, bool state);

  void simulateState(uint8_t index, bool state);

  void disableSimulation(uint8_t index);

  void onPropertyValueChange(uint8_t id, bool value);

private:
  Property<bool> ioStates[STATE_COUNT];


};

#endif
