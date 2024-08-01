#include <unistd.h>
#include "set_capture.h"


#define DDR_BASEADDR 0x00000000
#define FRAME_BUFFER_SIZE0      0x2000000    //0x2000000 for max 4KW RGB888 8bpc
//#define FRAME_BUFFER_SIZE1      0x600000    //0x600000 for max 1080p RGB888 8bpc
#define FRAME_BUFFER_BASE_ADDR  	(DDR_BASEADDR + (0x10000000))

#define FRAME_BUFFER_1          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*1)
#define FRAME_BUFFER_2          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*2)
#define FRAME_BUFFER_3          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*3)
#define FRAME_BUFFER_4          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*4)
#define FRAME_BUFFER_5          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*5)
#define FRAME_BUFFER_6          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*6)
#define FRAME_BUFFER_7          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*7)
#define FRAME_BUFFER_8          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*8)
#define FRAME_BUFFER_9          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*9)
#define FRAME_BUFFER_10         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*10)
#define FRAME_BUFFER_11         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*11)
#define FRAME_BUFFER_12         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*12)
#define FRAME_BUFFER_13         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*13)
#define FRAME_BUFFER_14         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*14)
#define FRAME_BUFFER_15         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*15)

xdma_getImg::xdma_getImg(xdma_programe *pXdma, unsigned char *pRGB, pthread_mutex_t *pOptNotice)
{
    stateWorking = false;
    this->pRGB = pRGB;
    this->pXdma = pXdma;
    this->pOptNotice = pOptNotice;
    this->W_size = 1920;
    this->H_size = 1080;
    this->stride = 1080;
    IMG_RAM_POS[0] = FRAME_BUFFER_1;
    IMG_RAM_POS[1] = FRAME_BUFFER_2;
    IMG_RAM_POS[2] = FRAME_BUFFER_3;
    // pcie_c2h_event0.setstart(false);
    // pcie_c2h_event0.pXdma = this->pXdma;
    // pcie_c2h_event0.start();
    video_stream_switch(0,0);
    clear_display();
    start();
}

void xdma_getImg::run()
{
    // DWORD read_num = 3840*2160*3;
    // DWORD read_num = W_size*H_size*3;
    // DWORD read_num = 1920*1080*3;
    // DWORD read_num = 1920*720*3;
    DWORD read_num ;
    DWORD ret;
    int hold_rd;

    while(1)
    {
        if(stateWorking)
        {
            // if(pcie_c2h_event0.WriteOneFrameEnd >= 0)
            // {
            //     pthread_mutex_lock(pOptNotice);
            //     read_num = W_size*H_size*3;
            //     ret = pXdma->c2h_transfer(IMG_RAM_POS[pcie_c2h_event0.WriteOneFrameEnd],W_size,H_size,stride,pRGB);
            //     // ret = pXdma->read_pack(IMG_RAM_POS[pcie_c2h_event0.WriteOneFrameEnd],read_num,pRGB);
            //     if(read_num != ret)
            //     {
            //         qDebug("read one pack error %d",ret);
            //     }
            //     else
            //     {
            //         emit flushImg();
            //     }
            //     pcie_c2h_event0.WriteOneFrameEnd = -1;
            // }

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

            if(WriteOneFrameEnd >= 0)
            {
                pthread_mutex_lock(pOptNotice);
                read_num = W_size*H_size*3;
                ret = pXdma->c2h_transfer(IMG_RAM_POS[WriteOneFrameEnd],W_size,H_size,stride,pRGB);
                // ret = pXdma->read_pack(IMG_RAM_POS[WriteOneFrameEnd],read_num,pRGB);
                if(read_num != ret)
                {
                    qDebug("read one pack error %ld",ret);
                }
                else
                {
                    emit flushImg();
                }
                WriteOneFrameEnd = -1;
            }
        }
        else
        {
            usleep(100000);
        }

    }
}

void xdma_getImg::setstart(bool isRuning)
{
    stateWorking = isRuning;
    // pcie_c2h_event0.setstart(stateWorking);

    if(stateWorking)
    {
        clear_display();
        pXdma->vdma_start(W_size,H_size,stride);

    }
    else
    {
        pXdma->vdma_stop();
    }
}

void xdma_getImg::clear_display(void)
{
    unsigned char *p;
    p = (unsigned char *)malloc(W_size*H_size*3);
    memset(p, 0xff, W_size*H_size*3);
    //clear fpga ddr framedata
    pXdma->h2c_transfer(IMG_RAM_POS[0],W_size*H_size*3,p);
    pXdma->h2c_transfer(IMG_RAM_POS[1],W_size*H_size*3,p);
    pXdma->h2c_transfer(IMG_RAM_POS[2],W_size*H_size*3,p);
    free(p);
}

void xdma_getImg::video_stream_switch(unsigned char SiIndex, unsigned char MiIndex)
{
    pXdma->axis_switch(SiIndex,MiIndex);
}
