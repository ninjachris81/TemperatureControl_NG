#include "WifiServer.h"

#include <Time.h>
#include <TimeLib.h>
#include <LogHelper.h>
#include <ESP8266WiFi.h>

#include "Credentials.h"
#include "SerialComm.h"
#include "TaskIDs.h"

ESP8266WebServer* WifiServer::server = NULL;
WifiServer* WifiServer::instance = NULL;

WifiServer::WifiServer() : AbstractTask() {
  if (server==NULL) {
    LOG_PRINTLN(F("Creating new web server"));
    server = new ESP8266WebServer(SERVER_PORT);
  }
  if (instance==NULL) {
    instance = this;
  }

  for (uint8_t i=0;i<CMD_MAX;i++) {
    properties[i] = "";
  }
}

WifiServer::~WifiServer() {
  server->stop();
  delete server;
}

void WifiServer::init() {
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  while (WiFi.waitForConnectResult() != WL_CONNECTED) {
    LOG_PRINTLN(F("Connection Failed! Rebooting..."));
    delay(5000);
    ESP.restart();
  }
  LOG_PRINTLN(F("Wifi connected"));

  server->onNotFound(WifiServer::handleNotFound);
  server->on("/status", WifiServer::handleStatus);
  server->on("/sendCmd", WifiServer::handleSendCmd);
  server->begin();
}

void WifiServer::update() {
  server->handleClient();
}

void WifiServer::setProperty(uint8_t index, String value) {
  if (index>CMD_MAX) return;
  
  LOG_PRINT(F("Set "));
  LOG_PRINT(index);
  LOG_PRINT(" to ");
  LOG_PRINTLN(value);

  properties[index] = value;
}


TaskManager* WifiServer::getTaskManager() {
  return taskManager;
}

WifiServer* WifiServer::getInstance() {
  return instance;
}

void WifiServer::handleNotFound() {
  handleError(404, F("Not Found"));
}

void WifiServer::handleError(int code, String desc) {
  server->send ( code, "text/plain", desc );
}

void WifiServer::handleStatus() {
  if (server->hasArg(F("refresh"))) {
    getInstance()->getTaskManager()->getTask<SerialComm*>(SERIAL_COMM)->sendCmd(CMD_SYNC_DATA, String("0"));
  }

  StaticJsonBuffer<2000> jsonBuffer;
  JsonObject& root = jsonBuffer.createObject();

  root["ut"] = millis();
  root["t"] = now();
  root["rssi"] = WiFi.RSSI();
  root["fh"] = ESP.getFreeHeap();

  JsonObject& props = root.createNestedObject("props");
  for (uint8_t i=0;i<CMD_MAX;i++) {
    if (getInstance()->properties[i]!="") {
      props["" + String(i)] = getInstance()->properties[i];
    }
  }
  

  String tmpStr;
  root.printTo(tmpStr);
  server->send ( 200, "application/json", tmpStr);
}

void WifiServer::handleSendCmd() {
  if (server->hasArg(F("c")) && server->hasArg(F("v"))) {
    uint8_t cmd = server->arg(F("c")).toInt();
    String value = server->arg(F("v"));

    LOG_PRINT(F("Send Cmd "));
    LOG_PRINT(cmd);
    LOG_PRINT(" ");
    LOG_PRINTLN(value);
    getInstance()->getTaskManager()->getTask<SerialComm*>(SERIAL_COMM)->sendCmd(cmd, value);
    server->send ( 200, "text/plain", "");
  } else {
    handleError(400, F("Bad Request"));
  }
}

