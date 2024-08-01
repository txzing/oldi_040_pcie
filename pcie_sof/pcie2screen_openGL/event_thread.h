#ifndef EVENT_THREAD_H
#define EVENT_THREAD_H
#include <QtWidgets>
#include "xdma_programe.h"


class event_thread0 : public QThread
{
    Q_OBJECT
public:
    volatile char event_id;
    event_thread0();
    ~event_thread0();
    void setstart(bool isRuning);
    void run();

    xdma_programe *pXdma;
    int wr_index = 0;
    int rd_index = 0;
    /*
     * Framebuffers for video data
     */
    int WriteOneFrameEnd = -1;


private:
    bool stateWorking;

};



#endif // EVENT_THREAD_H
