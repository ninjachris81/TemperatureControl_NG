#ifndef COMMCONTROLLER_H
#define COMMCONTROLLER_H

#include <AbstractTask.h>

class CommController : public AbstractTask {
  public:
    CommController();
  
    void init();

    void update();

    void sendCmd(uint8_t cmd, String value);

    void incomingData(String data);

private:
    void _sendCmd(HardwareSerial &target, String receiver, uint8_t cmd, String value);
};

#endif
