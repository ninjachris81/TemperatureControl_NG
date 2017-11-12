#ifndef SOLARCONTROLLER_H
#define SOLARCONTROLLER_H

#include <AbstractIntervalTask.h>
#include <Property.h>

class SolarController : public AbstractIntervalTask, public Property<bool>::ValueChangeListener {
public:
  SolarController();

  void init();

  void update();

  void onPropertyValueChange(uint8_t id, bool value);

private:
  Property<bool> pumpState;

};


#endif   // SOLARCONTROLLER_H
