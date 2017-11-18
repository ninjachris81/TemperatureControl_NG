#ifndef SERIALCOMM_H
#define SERIALCOMM_H

#include <AbstractTask.h>
#include <SoftwareSerial.h>

class SerialComm : public AbstractTask {
public:
  SerialComm();

  void init();

  void update();

  void sendCmd(uint8_t cmd, String value);
  
};


#endif   // SERIALCOMM_H
