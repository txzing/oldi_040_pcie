#include "xdma_programe.h"

// #define MAX_BYTES_PER_TRANSFER 0x800000
#define MAX_BYTES_PER_TRANSFER 0x4Bf000



xdma_programe::xdma_programe()
{
    c2h0_fd = INVALID_HANDLE_VALUE;
    h2c0_fd = INVALID_HANDLE_VALUE;
    control_fd = INVALID_HANDLE_VALUE;
    event0_fd = INVALID_HANDLE_VALUE;
}

xdma_programe::~xdma_programe()
{
    if(c2h0_fd != INVALID_HANDLE_VALUE)
    {
        CloseHandle(c2h0_fd);
    }
    if(h2c0_fd != INVALID_HANDLE_VALUE)
    {
        CloseHandle(h2c0_fd);
    }
    if(control_fd != INVALID_HANDLE_VALUE)
    {
        CloseHandle(control_fd);
    }
    if(event0_fd != INVALID_HANDLE_VALUE)
    {
        CloseHandle(event0_fd);
    }
}

bool xdma_programe::getDevice()
{
    bool b = false;
    HDEVINFO device_info;
    GUID guid = GUID_DEVINTERFACE_XDMA;
    SP_DEVICE_INTERFACE_DATA device_interface;
    DWORD index;
    int len;
    char *xdma_path;

    //获取设备路径
    if(c2h0_fd != INVALID_HANDLE_VALUE)
    {
        CloseHandle(c2h0_fd);
        c2h0_fd = INVALID_HANDLE_VALUE;
    }
    if(h2c0_fd != INVALID_HANDLE_VALUE)
    {
        CloseHandle(h2c0_fd);
        h2c0_fd = INVALID_HANDLE_VALUE;
    }
    if(control_fd != INVALID_HANDLE_VALUE)
    {
        CloseHandle(control_fd);
        control_fd = INVALID_HANDLE_VALUE;
    }
    if(event0_fd != INVALID_HANDLE_VALUE)
    {
        CloseHandle(event0_fd);
        event0_fd = INVALID_HANDLE_VALUE;
    }

    device_info = SetupDiGetClassDevs((LPGUID)&guid, NULL, NULL, DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
    if (device_info != INVALID_HANDLE_VALUE)
    {
        device_interface.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);
        for (index = 0; SetupDiEnumDeviceInterfaces(device_info, NULL, &guid, index, &device_interface); ++index)
        {
            // get required buffer size
            ULONG detailLength = 0;
            if (!SetupDiGetDeviceInterfaceDetail(device_info, &device_interface, NULL, 0, &detailLength, NULL) && GetLastError() != ERROR_INSUFFICIENT_BUFFER)
            {
                break;
            }

            // allocate space for device interface detail
            PSP_DEVICE_INTERFACE_DETAIL_DATA dev_detail = (PSP_DEVICE_INTERFACE_DETAIL_DATA)HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, detailLength);
            if (!dev_detail)
            {
                break;
            }
            dev_detail->cbSize = sizeof(SP_DEVICE_INTERFACE_DETAIL_DATA);

            // get device interface detail
            if (!SetupDiGetDeviceInterfaceDetail(device_info, &device_interface, dev_detail, detailLength, NULL, NULL))
            {
                HeapFree(GetProcessHeap(), 0, dev_detail);
                break;
            }

            len = wcslen( dev_detail->DevicePath);
            xdma_path = (char *)malloc((len+40)*2);
            if(xdma_path)
            {
                memset(xdma_path, 0, (len+40)*2);
                memcpy(xdma_path, dev_detail->DevicePath, len*2);
                memcpy(xdma_path+len*2, XDMA_FILE_C2H_0, sizeof(XDMA_FILE_C2H_0));
                c2h0_fd = CreateFile((LPCWSTR)xdma_path, GENERIC_READ|GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

                memset(xdma_path, 0, (len+40)*2);
                memcpy(xdma_path, dev_detail->DevicePath, len*2);
                memcpy(xdma_path+len*2, XDMA_FILE_H2C_0, sizeof(XDMA_FILE_H2C_0));
                h2c0_fd = CreateFile((LPCWSTR)xdma_path, GENERIC_READ|GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

                memset(xdma_path, 0, (len+40)*2);
                memcpy(xdma_path, dev_detail->DevicePath, len*2);
                memcpy(xdma_path+len*2, XDMA_FILE_USER, sizeof(XDMA_FILE_USER));
                control_fd = CreateFile((LPCWSTR)xdma_path, GENERIC_READ|GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

                memset(xdma_path, 0, (len+40)*2);
                memcpy(xdma_path, dev_detail->DevicePath, len*2);
                memcpy(xdma_path+len*2, XDMA_FILE_EVENT_0, sizeof(XDMA_FILE_EVENT_0));
                event0_fd = CreateFile((LPCWSTR)xdma_path, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

                free(xdma_path);
                b = true;

                COMMTIMEOUTS CommTimeouts_c2h0_fd;
                COMMTIMEOUTS CommTimeouts_h2c0_fd;
                if( (c2h0_fd != INVALID_HANDLE_VALUE) && (h2c0_fd != INVALID_HANDLE_VALUE) && (control_fd != INVALID_HANDLE_VALUE) )
                {
                    CommTimeouts_c2h0_fd.ReadIntervalTimeout = 1000;
                    CommTimeouts_c2h0_fd.ReadTotalTimeoutMultiplier = 1000;
                    CommTimeouts_c2h0_fd.ReadTotalTimeoutConstant = 1000;
                    CommTimeouts_c2h0_fd.WriteTotalTimeoutMultiplier = 1000;
                    CommTimeouts_c2h0_fd.WriteTotalTimeoutConstant = 1000;
                    SetCommTimeouts(c2h0_fd, &CommTimeouts_c2h0_fd);

                    CommTimeouts_h2c0_fd.ReadIntervalTimeout = 1000;
                    CommTimeouts_h2c0_fd.ReadTotalTimeoutMultiplier = 1000;
                    CommTimeouts_h2c0_fd.ReadTotalTimeoutConstant = 1000;
                    CommTimeouts_h2c0_fd.WriteTotalTimeoutMultiplier = 1000;
                    CommTimeouts_h2c0_fd.WriteTotalTimeoutConstant = 1000;
                    SetCommTimeouts(h2c0_fd, &CommTimeouts_h2c0_fd);

                }
            }
            HeapFree(GetProcessHeap(), 0, dev_detail);
            break;
        }
        SetupDiDestroyDeviceInfoList(device_info);
    }
    return b;
}

long xdma_programe::read_device(HANDLE device, long offset, unsigned long size, char * rcv_content)
{
    DWORD count=0;

    if (INVALID_SET_FILE_POINTER == SetFilePointer(device, offset, NULL, FILE_BEGIN))
    {
        qDebug("Error setting file pointer, error code: %ld\n", GetLastError());
        return -1;
    }

    // read from device into allocated buffer
    if (!ReadFile(device, rcv_content, size, &count, NULL)) {
        qDebug("ReadFile from device failed with Win64 error code: %ld\n", GetLastError());
        return -1;
    }

    return count;
}

int xdma_programe::read_pack(long address, DWORD size, unsigned char *buffer)
{
    DWORD rd_size = 0;
    HANDLE device = c2h0_fd;

    if (INVALID_SET_FILE_POINTER == SetFilePointer(device, address, NULL, FILE_BEGIN))
    {
        qDebug("read_pack Error setting file pointer\n");
        return -1;
    }
    if (!ReadFile(device, (unsigned char *)(buffer), size, &rd_size, NULL))
    {
        qDebug("ReadFile faild, rd_size = %d\n",rd_size);
        return 0;
    }
    return rd_size;

}

int xdma_programe::c2h_transfer(long address, DWORD W_size, DWORD H_size, DWORD stride, unsigned char *buffer)
{
    DWORD rd_size = 0;
    HANDLE device = c2h0_fd;
    unsigned int size = W_size*H_size*3;
    unsigned int i;
#if 1
    unsigned int transfers;
    if (INVALID_SET_FILE_POINTER == SetFilePointer(device, address, NULL, FILE_BEGIN)) {
        fprintf(stderr, "Error setting file pointer, win32 error code: %ld\n", GetLastError());
        return -3;
    }
    transfers = (unsigned int)(size / MAX_BYTES_PER_TRANSFER);
    // qDebug("read_device");
    // qDebug("transfers = %d", transfers);
    for (i = 0; i<transfers; i++)
    {
        if (!ReadFile(device, (void *)(buffer + i*MAX_BYTES_PER_TRANSFER), (DWORD)MAX_BYTES_PER_TRANSFER, &rd_size, NULL))
        {
            qDebug("point1");
            return -1;
        }
        if (rd_size != MAX_BYTES_PER_TRANSFER)
        {
            qDebug("point2");
            return -2;
        }
        if (INVALID_SET_FILE_POINTER == SetFilePointer(device, (address + (i+1)*MAX_BYTES_PER_TRANSFER), NULL, FILE_BEGIN)) {
            fprintf(stderr, "Error setting file pointer, win32 error code: %ld\n", GetLastError());
            qDebug("point3");
            return -3;
        }
    }
    if (!ReadFile(device, (void *)(buffer + i*MAX_BYTES_PER_TRANSFER), (DWORD)(size - i*MAX_BYTES_PER_TRANSFER), &rd_size, NULL))
    {
        qDebug("point4");
        return -1;
    }
    if (rd_size != (size - i*MAX_BYTES_PER_TRANSFER))
    {
        return -2;
    }
#else
    for(i=0;i<H_size;i++)
    {
        if (INVALID_SET_FILE_POINTER == SetFilePointer(device, address + (i*stride*3), NULL, FILE_BEGIN)) {
            fprintf(stderr, "Error setting file pointer, win32 error code: %ld\n", GetLastError());
            return -3;
        }
        if (!ReadFile(device, (void *)(buffer + i*W_size*3), W_size*3, &rd_size, NULL))
        {
            qDebug("i = %d",i);
            return -1;
        }
        if (rd_size != W_size*3)
        {
            qDebug("i = %d",i);
            qDebug("rd_size == %d",rd_size);
            return -2;
        }
    }
#endif
    return size;
}

long xdma_programe::write_device(HANDLE device, long address, DWORD size, unsigned char *buffer)
{


    DWORD wr_size = 0;
    unsigned int i;
    unsigned int transfers;

    transfers = (unsigned int)(size / MAX_BYTES_PER_TRANSFER);

    if (INVALID_SET_FILE_POINTER == SetFilePointer(device, address, NULL, FILE_BEGIN))
    {
        qDebug("Error setting file pointer, error code: %ld\n", GetLastError());
        return -1;
    }


    for (i = 0; i<transfers; i++)
    {
        if (!WriteFile(device, (void *)(buffer + i*MAX_BYTES_PER_TRANSFER), (DWORD)MAX_BYTES_PER_TRANSFER, &wr_size, NULL))
        {
            qDebug("point1");
            return -1;
        }
        if (wr_size != MAX_BYTES_PER_TRANSFER)
        {
            qDebug("point2");
            return -2;
        }
        if (INVALID_SET_FILE_POINTER == SetFilePointer(device, (address + (i+1)*MAX_BYTES_PER_TRANSFER), NULL, FILE_BEGIN)) {
            qDebug("Error setting file pointer, win32 error code: %ld\n", GetLastError());
            qDebug("point3");
            return -3;
        }
    }
    if (!WriteFile(device, (void *)(buffer + i*MAX_BYTES_PER_TRANSFER), (DWORD)(size - i*MAX_BYTES_PER_TRANSFER), &wr_size, NULL))
    {
        qDebug("point4");
        return -1;
    }
    if (wr_size != (size - i*MAX_BYTES_PER_TRANSFER))
    {
        return -2;
    }

    return size;
}

//transfer data from Host PC to FPGA Card
long xdma_programe::h2c_transfer(long address, DWORD size, unsigned char *buffer)
{
    HANDLE device = h2c0_fd;
    return write_device(device, address, size, buffer);
}


unsigned int xdma_programe::Xil_In32(unsigned int reg_addr)
{
    DWORD size;
    LARGE_INTEGER addr;
    unsigned int value;

    memset(&addr, 0, sizeof(addr));
    addr.QuadPart = reg_addr;

    if ((int)INVALID_SET_FILE_POINTER == SetFilePointerEx(control_fd, addr, NULL, FILE_BEGIN))
    {
        return 0;
    }
    if (!ReadFile(control_fd, &value, sizeof(value), &size, NULL))
    {
        return 0;
    }
    return value;
}

int xdma_programe::Xil_Out32(unsigned int reg_addr, unsigned int value)
{
    DWORD size;
    LARGE_INTEGER addr;

    memset(&addr, 0, sizeof(addr));
    addr.QuadPart = reg_addr;

    if ((int)INVALID_SET_FILE_POINTER == SetFilePointerEx(control_fd, addr, NULL, FILE_BEGIN))
    {
        return -1;
    }
    if (!WriteFile(control_fd, &value, sizeof(value), &size, NULL))
    {
        return -1;
    }
    return 0;
}

int xdma_programe:: wait_event0(void)
{
    uint8_t val=0;
    read_device(event0_fd, 0, sizeof(uint8_t),(char *)&val);
    return val;
}


void xdma_programe::vdma_start(DWORD W_size, DWORD H_size, DWORD stride)
{
    unsigned int ret32;
    ret32 = Xil_In32(vdma_baseaddr + 0x30) | 0x00000001;
    Xil_Out32((vdma_baseaddr + 0x30),ret32);
    Xil_Out32((vdma_baseaddr + 0xA8), stride*3);
    Xil_Out32((vdma_baseaddr + 0xA4), W_size*3);
    Xil_Out32((vdma_baseaddr + 0xA0), H_size);
}


void xdma_programe::vdma_stop(void)
{
    unsigned int ret32;
    ret32 = Xil_In32(vdma_baseaddr + 0x30) & (~0x00000001);
    Xil_Out32((vdma_baseaddr + 0x30),ret32);
}

// Start parking mode on a certain frame
void xdma_programe::vdma_StartParking(int FrameIndex)
{
    unsigned int ret32;
    unsigned int FrmBits;
    FrmBits = FrameIndex << 8;

    FrmBits &= 0x00001F00;

    ret32 = Xil_In32(vdma_baseaddr + 0x28);
    ret32 &= ~0x00001F00;
    ret32 |= FrmBits;

    Xil_Out32((vdma_baseaddr + 0x28),ret32);

    ret32 = Xil_In32(vdma_baseaddr + 0x30) & ~0x00000002;
    Xil_Out32((vdma_baseaddr + 0x30),ret32);

}

void xdma_programe::axis_switch(unsigned char SiIndex, unsigned char MiIndex)
{
    unsigned int ret32;
    unsigned int axis_switch_baseaddr = 0x04A20000;

    Xil_Out32((axis_switch_baseaddr + 0x000), (Xil_In32((axis_switch_baseaddr + 0x000)) & (~0x02)));
    for (unsigned char Index = 0; Index <= MiIndex; Index++)
    {

        /* Calculate MI port address of which to be enabled */
        ret32 = 0x040 + 4 * Index;
        Xil_Out32((axis_switch_baseaddr + ret32),0x80000000);
    }

    ret32 = 0x040 + 4 * MiIndex;
    Xil_Out32((axis_switch_baseaddr + ret32),SiIndex);
    Xil_Out32((axis_switch_baseaddr + 0x000), (Xil_In32((axis_switch_baseaddr + 0x000)) | (0x02)));

}

void xdma_programe::axis_passthrouth_mon(unsigned int * W_size, unsigned int * H_size, unsigned int * fps)
{
    unsigned int ret32;
    unsigned int axis_passthrouth_mon_baseaddr = 0x04A10000;

    ret32 = Xil_In32(axis_passthrouth_mon_baseaddr + 0x0);
    *W_size = ret32;
    ret32 = Xil_In32(axis_passthrouth_mon_baseaddr + 0x4);
    *H_size = ret32;
    ret32 = Xil_In32(axis_passthrouth_mon_baseaddr + 0x8);
    *fps = ret32;

}
