#include "event_thread.h"


event_thread0::event_thread0()
{
    stateWorking = false;
    start();
}
event_thread0::~event_thread0() {}



void event_thread0::run()
{
    int hold_rd;
    while(1)
    {
        if(stateWorking)
        {

            if(pXdma->wait_event0() == 1)
            {
                // qDebug("event0 trigger");
                if(WriteOneFrameEnd == -1)
                {
                    hold_rd = rd_index;
                    if(wr_index == 2)
                    {
                        wr_index = 0;
                        rd_index = 2;
                    }
                    else
                    {
                        rd_index = wr_index;
                        wr_index++;
                    }
                    /* Set park pointer */
                    pXdma->vdma_StartParking(wr_index);//写通道停留在此区域
                    WriteOneFrameEnd = hold_rd;//读出上一帧已写完
                }
            }
        }
        else
        {
            usleep(100000);
        }
    }

}



void event_thread0::setstart(bool isRuning)
{
    stateWorking = isRuning;
}
