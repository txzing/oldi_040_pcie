#ifndef XDMA_PROGRAME_H
#define XDMA_PROGRAME_H

#include <pthread.h>
#include <sys/time.h>
#include <QtWidgets>

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <strsafe.h>

#include <Windows.h>
#include <SetupAPI.h>
#include <INITGUID.H>
#include <WinIoCtl.h>

#include "xdma_public.h"

class xdma_programe
{
public:
    xdma_programe();
    ~xdma_programe();
    bool getDevice(void);
    int read_pack(long address, DWORD size, unsigned char *buffer);
    int c2h_transfer(long address, DWORD W_size, DWORD H_size, DWORD stride, unsigned char *buffer);
    long read_device(HANDLE device, long offset, unsigned long size, char * rcv_content);

    long h2c_transfer(long address, DWORD size, unsigned char *buffer);
    long write_device(HANDLE device, long address, DWORD size, unsigned char *buffer);

    unsigned int Xil_In32(unsigned int reg_addr);
    int Xil_Out32(unsigned int reg_addr, unsigned int value);
    int wait_event0(void);

    void vdma_start(DWORD W_size, DWORD H_size, DWORD stride);
    void vdma_stop(void);
    void vdma_StartParking(int FrameIndex);
    void axis_switch(unsigned char SiIndex, unsigned char MiIndex);
    void axis_passthrouth_mon(unsigned int * W_size, unsigned int * H_size, unsigned int * fps);

private:
    HANDLE c2h0_fd;
    HANDLE h2c0_fd;
    HANDLE control_fd;
    HANDLE event0_fd;

    unsigned int vdma_baseaddr = 0x04A00000;
};

#endif // XDMA_PROGRAME_H
