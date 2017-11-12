#include "BuzzerController.h"
#include <LogHelper.h>

#include "Pins.h"
#include "IOController.h"
#include "TaskIDs.h"

BuzzerController::BuzzerController() : AbstractIntervalTask(BEEP_INTERVAL) { 
}

void BuzzerController::init() {
  buzzerState.registerValueChangeListener(this);
  
  taskManager->getTask<IOController*>(IO_CONTROLLER)->setState(INDEX_BUZZER, LOW);
  pinMode(PIN_BUZZER, INPUT);
}

void BuzzerController::update() {
  if (buzzerState.getValue()) {
    // osscilate
    beepState = !beepState;
    if (beepState) {
      tone(PIN_BUZZER, BUZZER_FREQ);
    } else {
      noTone(PIN_BUZZER);
    }
  }
}

void BuzzerController::onPropertyValueChange(uint8_t id, bool value) {
  pinMode(PIN_BUZZER, value ? OUTPUT : INPUT);
}

void BuzzerController::setBuzzerState(bool buzzerOn) {
  LOG_PRINT(F("Buzzer "));
  LOG_PRINTLN(buzzerOn);
  buzzerState.setValue(buzzerOn);
}

