#ifndef SOLARCONTROLLER_H
#define SOLARCONTROLLER_H

#include <AbstractIntervalTask.h>

class SolarController : public AbstractIntervalTask {
public:
  SolarController();

  void init();

  void update();
private:

};


#endif   // SOLARCONTROLLER_H
