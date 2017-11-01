#ifndef HEATERCONTROLLER_H
#define HEATERCONTROLLER_H

#include <AbstractIntervalTask.h>

class HeaterController : public AbstractIntervalTask {
public:
  HeaterController();

  void init();

  void update();

private:

};


#endif   // HEATERCONTROLLER_H
