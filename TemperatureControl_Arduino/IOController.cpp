#include "IOController.h"
#include <LogHelper.h>

#include "Pins.h"

#include "CommController.h"
#include "ConfigController.h"
#include "TaskIDs.h"
#include "SerialProtocol.h"

IOController::IOController() : AbstractIntervalTask(1000) {
}

void IOController::init() {
  pinMode(PIN_BUILTIN_LED, OUTPUT);

  for (uint8_t i=0;i<STATE_COUNT;i++) {
    ioStates[i].registerValueChangeListener(this);
    pinMode(PIN_IO_BASE + i, OUTPUT);

    switch (i) {
      case INDEX_GAS_BURNER:
        ioStates[i].init(i, false, taskManager->getTask<ConfigController*>(CONFIG_CONTROLLER)->getConfig()->gasBurnerMinToggleTimeMin * GAS_BURNER_TOGGLE_TIME_MIN_FACTOR);
        break;
      case INDEX_RADIATOR_PUMP:
        ioStates[i].init(i, false, 1000);
        break;
      case INDEX_BUZZER:
        ioStates[i].init(i, false, 0);
        break;
      default:
        ioStates[i].init(i, false, GENERAL_TOGGLE_TIME);
    }
  }
}

void IOController::update() {
  if (digitalRead(PIN_BUILTIN_LED)==HIGH) {
    digitalWrite(PIN_BUILTIN_LED, LOW);
  } else {
    digitalWrite(PIN_BUILTIN_LED, HIGH);    
  }
  for (uint8_t i=0;i<STATE_COUNT;i++) ioStates[i].update();
}

void IOController::syncData(int filter) {
  for (uint8_t i=0;i<STATE_COUNT;i++) {
    if (filter==-1 || filter==i) taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(PIN_IO_BASE + i, String(ioStates[i].getValue()));
  }
}

void IOController::onPropertyValueChange(uint8_t id, bool value) {
  LOG_PRINT(F("IO State changed to "));
  LOG_PRINTLN(value);
  digitalWrite(PIN_IO_BASE + id, value);
  taskManager->getTask<CommController*>(COMM_CONTROLLER)->sendCmd(PIN_IO_BASE + id, String(value));
}

void IOController::disableSimulation(uint8_t index) {
  if (index<STATE_COUNT) {
    LOG_PRINT(F("Disable Simulation "));
    LOG_PRINT(index);
    ioStates[index].setSimulationOff();
  } else {
    LOG_PRINT(F("Invalid index"));
    LOG_PRINTLN(index);
  }
}

void IOController::setState(uint8_t index, bool state) {
  if (index<STATE_COUNT) {
    LOG_PRINT(F("IO State "));
    LOG_PRINT(index);
    LOG_PRINT(F("->"));
    LOG_PRINTLN(state);
    ioStates[index].setValue(state);
  } else {
    LOG_PRINT(F("Invalid index"));
    LOG_PRINTLN(index);
  }
}

void IOController::simulateState(uint8_t index, bool state) {
  if (index<STATE_COUNT) {
    LOG_PRINT(F("Simulating IO State "));
    LOG_PRINT(index);
    LOG_PRINT(F("->"));
    LOG_PRINTLN(state);
    ioStates[index].setSimulatedValue(state);
  } else {
    LOG_PRINT(F("Invalid index"));
    LOG_PRINTLN(index);
  }
}
