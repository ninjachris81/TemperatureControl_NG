#include "TimeController.h"

#include <Time.h>
#include <TimeLib.h>
#include <LogHelper.h>

#include "SerialProtocol.h"
#include "SerialComm.h"
#include "TaskIDs.h"

TimeController::TimeController() : AbstractIntervalTask(TIME_FAST_INTERVAL_MS) {
  
}

void TimeController::init() {
}

void TimeController::update() {
  switch(currentState) {
    case NTP_LOOKUP:
      LOG_PRINTLN(F("NTP lookup"));
      udp.begin(UDP_LOCAL_PORT);
      WiFi.hostByName("time.nist.gov", timeServerIP);
      currentState=NTP_SEND_PACKET;
      break;
    case NTP_SEND_PACKET:
      LOG_PRINTLN(F("NTP send"));
      if (sendNTPpacket(timeServerIP)) {
        currentState=NTP_RECV_PACKET;
        receiveTimeout = NTP_RECEIVE_TIMEOUT;
      }
      break;
    case NTP_RECV_PACKET:
      LOG_PRINTLN(F("NTP receive"));
      if (receiveNTPpacket()) {
        currentState = NTP_COMPLETE;
        setInterval(TIME_SLOW_INTERVAL_MS);
        udp.stop();
        LOG_PRINTLN(F("NTP complete"));
      } else {
        receiveTimeout--;
      }

      if (receiveTimeout==0) {
        LOG_PRINTLN(F("NTP recv timeout"));
        currentState = NTP_SEND_PACKET;
      }
      break;
    case NTP_COMPLETE:
      // reset
      LOG_PRINTLN(F("NTP reset"));
      currentState = NTP_LOOKUP;
      setInterval(TIME_FAST_INTERVAL_MS);
      break;
  }  
}

bool TimeController::receiveNTPpacket() {

 int size = udp.parsePacket();
  if (size >= NTP_PACKET_SIZE) {
    // We've received a packet, read the data from it
    udp.read(packetBuffer, NTP_PACKET_SIZE); // read the packet into the buffer

    //the timestamp starts at byte 40 of the received packet and is four bytes,
    // or two words, long. First, esxtract the two words:

    unsigned long highWord = word(packetBuffer[40], packetBuffer[41]);
    unsigned long lowWord = word(packetBuffer[42], packetBuffer[43]);
    // combine the four bytes (two words) into a long integer
    // this is NTP time (seconds since Jan 1 1900):
    unsigned long secsSince1900 = highWord << 16 | lowWord;

    // Unix time starts on Jan 1 1970. In seconds, that's 2208988800:
    const unsigned long seventyYears = 2208988800UL;
    // subtract seventy years:
    unsigned long epoch = secsSince1900 - seventyYears;
    // print Unix time:
    setTime(epoch);

    LOG_PRINT(F("New time: "));
    LOG_PRINTLN(epoch);

    taskManager->getTask<SerialComm*>(SERIAL_COMM)->sendCmd(CMD_TIME, String(epoch));
    
    return true;
  } else {
    return false;
  }
}

bool TimeController::sendNTPpacket(IPAddress& address) {
  // set all bytes in the buffer to 0
  memset(packetBuffer, 0, NTP_PACKET_SIZE);
  // Initialize values needed to form NTP request
  // (see URL above for details on the packets)
  packetBuffer[0] = 0b11100011;   // LI, Version, Mode
  packetBuffer[1] = 0;     // Stratum, or type of clock
  packetBuffer[2] = 6;     // Polling Interval
  packetBuffer[3] = 0xEC;  // Peer Clock Precision
  // 8 bytes of zero for Root Delay & Root Dispersion
  packetBuffer[12]  = 49;
  packetBuffer[13]  = 0x4E;
  packetBuffer[14]  = 49;
  packetBuffer[15]  = 52;

  // all NTP fields have been given values, now
  // you can send a packet requesting a timestamp:
  udp.beginPacket(address, 123); //NTP requests are to port 123
  udp.write(packetBuffer, NTP_PACKET_SIZE);
  udp.endPacket();
  return true;
}
