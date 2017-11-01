#include "SolarController.h"
#include "TemperatureController.h"
#include <Time.h>
#include <TimeLib.h>

#include "Pins.h"
#include "TaskIDs.h"

SolarController::SolarController() : AbstractIntervalTask(1000) {
  
}

void SolarController::init() {
  
}

void SolarController::update() {
}
