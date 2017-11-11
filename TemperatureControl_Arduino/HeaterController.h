#ifndef HEATERCONTROLLER_H
#define HEATERCONTROLLER_H

#include <AbstractIntervalTask.h>
#include <Property.h>

#define PROP_ID_HEATING 0
#define PROP_ID_RADIATOR 1

class HeaterController : public AbstractIntervalTask, public Property<bool>::ValueChangeListener {
public:
  HeaterController();

  void init();

  void update();

  void onPropertyValueChange(uint8_t id, bool value);

private:
  Property<bool> heatingState;
  Property<bool> radiatorState;

};


#endif   // HEATERCONTROLLER_H
