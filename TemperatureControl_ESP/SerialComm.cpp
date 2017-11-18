#include "SerialComm.h"

#include "Debug.h"
#include <LogHelper.h>
#include "TaskIDs.h"
#include "SerialProtocol.h"
#include "WifiServer.h"

SerialComm::SerialComm() : AbstractTask() {
}

void SerialComm::init() {
  Serial.begin(9600);
}

void SerialComm::update() {
  if (Serial.available()) {
    String s = Serial.readStringUntil('\n');

    LOG_PRINT(F("Received: "));
    LOG_PRINTLN(s);

    if (s.substring(0,CMD_ID)==RECEIVER_ESP || s.substring(0,CMD_ID)==RECEIVER_ALL) {
      uint8_t cmd = s.substring(CMD_ID,CMD_VALUE_OFFSET).toInt();
      taskManager->getTask<WifiServer*>(WIFI_SERVER)->setProperty(cmd, s.substring(CMD_VALUE_OFFSET));
    } else {
      // ignore
    }
  }
  
}

void SerialComm::sendCmd(uint8_t cmd, String value) {
  Serial.print(RECEIVER_MEGA);
  if (cmd<10) {
    Serial.print("00");
  } else if (cmd<100) {
    Serial.print("0");
  }
  Serial.print(cmd);
  Serial.println(value);
}
