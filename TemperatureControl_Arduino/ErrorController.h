#ifndef ERRORCONTROLLER_H
#define ERRORCONTROLLER_H

#include <AbstractTriggerTask.h>
#include "BroadcastController.h"

#define ERROR_COUNT 2

#define INDEX_ERROR_TIME 0
#define INDEX_ERROR_DTEMP 1

class ErrorController : public AbstractTriggerTask, public BroadcastController::SyncSupport {
  public:
    ErrorController();

    void init();

    void update();

    void syncData(int filter = -1);

    void raiseError(uint8_t type);

    void clearError(uint8_t type);
    
  private:
    bool errors[ERROR_COUNT];

    void checkBuzzerState();
  
};

#endif
