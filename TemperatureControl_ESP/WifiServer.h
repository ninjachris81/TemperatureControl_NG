#ifndef WIFISERVER_H
#define WIFISERVER_H

#include <AbstractTask.h>
#include <ArduinoJson.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <AbstractTask.h>

#include "SerialProtocol.h"

#define SERVER_PORT 80

class WifiServer : public AbstractTask {
public:
  WifiServer();
  ~WifiServer();

  void init();

  void update();

  TaskManager* getTaskManager();

  static WifiServer* getInstance();

  void setProperty(uint8_t index, String value);
  
  String properties[CMD_MAX];

private:

  static WifiServer* instance;
  static ESP8266WebServer *server;

  static void handleNotFound();
  static void handleStatus();
  static void handleSendCmd();
  static void handleError(int code, String desc);
  
};


#endif   // WIFISERVER_H
