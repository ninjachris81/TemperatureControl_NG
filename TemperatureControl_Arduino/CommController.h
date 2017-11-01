#ifndef COMMCONTROLLER_H
#define COMMCONTROLLER_H

#include <AbstractTask.h>

class CommController : public AbstractTask {
  public:
    CommController();
  
    void init();

    void update();

    void sendCmd(uint8_t cmd, String value);
};

#endif
