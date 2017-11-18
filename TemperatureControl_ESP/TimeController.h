#ifndef TIMECONTROLLER_H
#define TIMECONTROLLER_H

#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <AbstractIntervalTask.h>

#include "Debug.h"

#define UDP_LOCAL_PORT 2390

#define NTP_PACKET_SIZE 48

#define TIME_FAST_INTERVAL_MS 1000

#define NTP_RECEIVE_TIMEOUT 10

#ifdef IS_DEBUG
  #define TIME_SLOW_INTERVAL_MS 60000    // 60 sec
#else
  #define TIME_SLOW_INTERVAL_MS 86400000    // 1 day
#endif

class TimeController : public AbstractIntervalTask {
public:
  enum NTP_STATE {
    NTP_LOOKUP,
    NTP_SEND_PACKET,
    NTP_RECV_PACKET,
    NTP_COMPLETE
  };


  TimeController();
  
  void init();

  void update();

private:
  WiFiUDP udp;
  byte packetBuffer[NTP_PACKET_SIZE]; //buffer to hold incoming and outgoing packets
  
  IPAddress timeServerIP;

  NTP_STATE currentState = NTP_LOOKUP;

  bool receiveNTPpacket();
  bool sendNTPpacket(IPAddress& address);
  uint8_t receiveTimeout;
};

#endif    //TIMECONTROLLER_H
