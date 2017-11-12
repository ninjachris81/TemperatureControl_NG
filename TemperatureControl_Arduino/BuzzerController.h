#ifndef BUZZERCONTROLLER_H
#define BUZZERCONTROLLER_H

#include <AbstractIntervalTask.h>
#include <Property.h>

#define BEEP_INTERVAL 500
#define BUZZER_FREQ 600

class BuzzerController : public AbstractIntervalTask, public Property<bool>::ValueChangeListener {
  public:
    BuzzerController();
  
    void init();

    void update();

    void onPropertyValueChange(uint8_t id, bool value);

    void setBuzzerState(bool buzzerOn);
  private:
    Property<bool> buzzerState;
    bool beepState = false;
    
};

#endif
