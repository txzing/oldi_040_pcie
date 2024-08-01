#ifndef SET_CAPTURE_H
#define SET_CAPTURE_H

#include <QtWidgets>
#include "xdma_programe.h"
#include "event_thread.h"

class xdma_getImg : public QThread
{
    Q_OBJECT
public:
    xdma_getImg(xdma_programe *pXdma, unsigned char *pRGB, pthread_mutex_t *pOptNotice);
    event_thread0 pcie_c2h_event0;
    void run(void);
    void setstart(bool isRuning);
    unsigned short W_size, H_size;
    unsigned short stride;


    void clear_display(void);
    void video_stream_switch(unsigned char SiIndex, unsigned char MiIndex);

Q_SIGNALS:
    void flushImg();

private:
    xdma_programe *pXdma;
    bool stateWorking;
    unsigned char *pRGB;
    pthread_mutex_t *pOptNotice;

    int wr_index = 0;
    int rd_index = 0;
    /*
     * Framebuffers for video data
     */
    int WriteOneFrameEnd = -1;
    long IMG_RAM_POS[3];

};


#endif // SET_CAPTURE_H
