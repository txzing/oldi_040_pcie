/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "platform.h"
#ifndef __PPC__
#include "xil_printf.h"
#endif
#include "xstatus.h"
#include "xil_types.h"
#if defined (ARMR5) || (__aarch64__) || (__arm__)
#include "xscugic.h"
#else
#include "xintc.h"
#endif
#include "xil_exception.h"
#include "xil_cache.h"
#if defined (XPAR_XV_TPG_NUM_INSTANCES)
#include "xvidc.h"
#include "tpg/tpg.h"
#endif

#if defined (XPAR_XAXIS_SWITCH_NUM_INSTANCES)
#include "xaxis_switch.h"
#endif
#include "xaxivdma.h"
#include "sleep.h"
#include "bitmanip.h"
#include "trace_zzg_debug.h"

#include "xparameters.h"
#include "xuartlite_l.h"
#include "axis_passthrough_monitor.h"

#define VDMA_ID          		XPAR_AXIVDMA_0_DEVICE_ID

#if defined (__MICROBLAZE__)
	#define DDR_BASEADDR XPAR_MICROBLAZE_DCACHE_BASEADDR
//	#define DDR_BASEADDR 0x80000000
#else
	#define DDR_BASEADDR XPAR_DDR_MEM_BASEADDR
#endif

#define FRAME_BUFFER_BASE_ADDR  	(DDR_BASEADDR + (0x10000000))
//#define FRAME_BUFFER_BASE_ADDR  	(DDR_BASEADDR + (512 * 1024 * 1024))
//#define FRAME_BUFFER_BASE_ADDR	0x10000000
//#define FRAME_BUFFER_BASE_ADDR	0x81000000
//#define FRAME_BUFFER_SIZE		0x400000	//0x400000 for max 1080p YCbCr422 8bpc
//#define FRAME_BUFFER_SIZE		0x600000	//0x600000 for max 1080p RGB888 8bpc
#define FRAME_BUFFER_SIZE       0x2000000    //0x2000000 for max 4KW RGB888 8bpc
#define FRAME_BUFFER_1			FRAME_BUFFER_BASE_ADDR
#define FRAME_BUFFER_2			FRAME_BUFFER_BASE_ADDR + FRAME_BUFFER_SIZE
#define FRAME_BUFFER_3			FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE*2)

#define FRAME_BUFFER_BASE_ADDR1	FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE*3)
#define FRAME_BUFFER_4			FRAME_BUFFER_BASE_ADDR1
#define FRAME_BUFFER_5			FRAME_BUFFER_BASE_ADDR1 + FRAME_BUFFER_SIZE
#define FRAME_BUFFER_6			FRAME_BUFFER_BASE_ADDR1 + (FRAME_BUFFER_SIZE*2)


#if defined (XPAR_XV_TPG_NUM_INSTANCES)
XV_tpg tpg_inst0;
XV_tpg_Config *tpg_config0;
u32 bckgndId0=XTPG_BKGND_COLOR_BARS;
XVidC_ColorFormat colorFmtIn0 = XVIDC_CSF_RGB;
//XVidC_ColorFormat colorFmtOut0 = XVIDC_CSF_RGB;
#endif
#if (XPAR_XAXIS_SWITCH_NUM_INSTANCES >= 1U)
XAxis_Switch AxisSwitch0;
XAxis_Switch AxisSwitch1;
#endif

void clear_display(void)
{
	u32 bytePerPixels = 3;
	u32 line = 0;
	u32 column = 0;

	line = 1920;
	column = 1080;

//	line = 3840;
//	column = 2160;

	Xil_DCacheDisable();
    memset(FRAME_BUFFER_1,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_2,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_3,0xff,line*column*bytePerPixels);//background
	Xil_DCacheEnable();
}

void vdma0_config_32(void)
{
    /* Start of VDMA Configuration */
    u32 bytePerPixels = 3;

    int offset0 = 0; // (y*w+x)*Bpp
    int offset1 = 0; // (y*w+x)*Bpp


    u32 stride0 = 1920;
    u32 width0 = 1920;
    u32 height0 = 1080;
    u32 stride1 = 1920;  // crop keeps write Stride
    u32 width1 = 1920;
    u32 height1 = 1080;


    /* Configure the Write interface (S2MM)*/
    // S2MM Control Register
    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0x30, 0x8B);
    //S2MM Start Address 1
    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0xAC, FRAME_BUFFER_1 + offset0);
    //S2MM Start Address 2
    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0xB0, FRAME_BUFFER_2 + offset0);
    //S2MM Start Address 3
    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0xB4, FRAME_BUFFER_3 + offset0);
    //S2MM Frame delay / Stride register
    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0xA8, stride0*bytePerPixels);
    // S2MM HSIZE register
    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0xA4, width0*bytePerPixels);
    // S2MM VSIZE register
    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0xA0, height0);

    /* Configure the Read interface (MM2S)*/
    // MM2S Control Register
//    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0x00, 0x8B);
//    // MM2S Start Address 1
//    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0x5C, FRAME_BUFFER_1 + offset1);
//    // MM2S Start Address 2
//    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0x60, FRAME_BUFFER_2 + offset1);
//    // MM2S Start Address 3
//    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0x64, FRAME_BUFFER_3 + offset1);
//    // MM2S Frame delay / Stride register
//    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0x58, stride1*bytePerPixels);
//    // MM2S HSIZE register
//    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0x54, width1*bytePerPixels);
//    // MM2S VSIZE register
//    Xil_Out32(XPAR_AXIVDMA_0_BASEADDR + 0x50, height1);

    xil_printf("VDMA_0 started!\r\n");
    /* End of VDMA Configuration */
}


#if defined (XPAR_XV_TPG_NUM_INSTANCES)
void tpg_config()
{
    u32 Status;

    // tpg0
    xil_printf("TPG0 Initializing\n\r");

    Status = XV_tpg_Initialize(&tpg_inst0, XPAR_XV_TPG_0_DEVICE_ID);
    if(Status!= XST_SUCCESS)
    {
        xil_printf("TPG0 configuration failed\r\n");
//      return(XST_FAILURE);
    }

    tpg_cfg(&tpg_inst0, 1080, 1920, colorFmtIn0, bckgndId0);
//	tpg_cfg(&tpg_inst0, 1440, 2560, colorFmtIn0, bckgndId0);
//	tpg_cfg(&tpg_inst0, 2160, 3840, colorFmtIn0, bckgndId0);

    //Configure the moving box of the TPG0
    tpg_box(&tpg_inst0, 50, 1);

    //Start the TPG0
    XV_tpg_EnableAutoRestart(&tpg_inst0);
    XV_tpg_Start(&tpg_inst0);
    xil_printf("TPG0 started!\r\n");
}
#endif

#if defined (XPAR_XAXIS_SWITCH_NUM_INSTANCES)
int AxisSwitch(u16 DeviceId, XAxis_Switch * pAxisSwitch, u8 SiIndex, u8 MiIndex)
{
    XAxis_Switch_Config *Config;
    int Status;

    u8 num = XPAR_AXIS_SWITCH_0_DEVICE_ID;

    /* Initialize the AXI4-Stream Switch driver so that it's ready to
     * use look up configuration in the config table, then
     * initialize it.
     */
    Config = XAxisScr_LookupConfig(DeviceId);
    if (NULL == Config) {
        return XST_FAILURE;
    }

    Status = XAxisScr_CfgInitialize(pAxisSwitch, Config,
                        Config->BaseAddress);
    if (Status != XST_SUCCESS) {
    	xil_printf("AXI4-Stream initialization failed.\r\n");
        return XST_FAILURE;
    }

    /* Disable register update */
    XAxisScr_RegUpdateDisable(pAxisSwitch);

    /* Disable all MI ports */
    XAxisScr_MiPortDisableAll(pAxisSwitch);

    /* Source SI[1] to MI[0] */
    XAxisScr_MiPortEnable(pAxisSwitch, MiIndex, SiIndex);

    /* Enable register update */
    XAxisScr_RegUpdateEnable(pAxisSwitch);

    /* Check for MI port enable */
    Status = XAxisScr_IsMiPortEnabled(pAxisSwitch, MiIndex, SiIndex);
    if (Status) {
    	xil_printf("Switch %d: MI[%d] is sourced from SI[%d].\r\n", num, MiIndex, SiIndex);
    }

    return XST_SUCCESS;
}

int axis_switch_cfg0(void)
{
    int Status;

    Status = AxisSwitch(XPAR_AXIS_SWITCH_0_DEVICE_ID, &AxisSwitch0, 0, 0);
    if (Status != XST_SUCCESS)
	{
//		Xil_Assert(__FILE__, __LINE__);
		return XST_FAILURE ;
	}
    xil_printf("\r\nvideo channel 0 start\r\n");
}

int axis_switch_cfg1(void)
{
    int Status;

    Status = AxisSwitch(XPAR_AXIS_SWITCH_0_DEVICE_ID, &AxisSwitch0, 1, 0);
    if (Status != XST_SUCCESS)
	{
//		Xil_Assert(__FILE__, __LINE__);
		return XST_FAILURE ;
	}
    xil_printf("\r\nvideo channel 1 start\r\n");
}

#endif


void video_resolution_print(char *info,u32 baseaddr)
{
	xil_printf("-%s freq: %d -\r\n", info, AXI_LITE_REG_mReadReg(baseaddr, AXI_LITE_REG_S00_AXI_SLV_REG2_OFFSET));
	xil_printf("-%s res: %dx%d -\r\n", info, AXI_LITE_REG_mReadReg(baseaddr, AXI_LITE_REG_S00_AXI_SLV_REG0_OFFSET),\
											 AXI_LITE_REG_mReadReg(baseaddr, AXI_LITE_REG_S00_AXI_SLV_REG1_OFFSET));
}


void uart_receive_process(void)
{

	if (!XUartLite_IsReceiveEmpty(XPAR_UARTLITE_0_BASEADDR))
	{
		// Read data from uart
		u8 Data;
		Data = XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR);

		if((Data == 'd') || (Data == 'D'))
		{

			xil_printf("\r\n!!!!!!!!!!!!!!!!!!!!!!!!\r\n");

			xil_printf("------------------------\r\n");
			video_resolution_print("oldi in",XPAR_OLDI_IN_AXIS_PASSTHROUGH_MON_0_S00_AXI_BASEADDR);
			xil_printf("------------------------\r\n");

			xil_printf("------------------------\r\n");
			video_resolution_print("video in",XPAR_MEMORY_SUBSYSTEM_AXIS_PASSTHROUGH_MON_0_S00_AXI_BASEADDR);
			xil_printf("------------------------\r\n");
		}
		if((Data == 's') || (Data == 'S'))
		{

			xil_printf("\r\nNow switch video source begin\r\n");

			Data = XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR);

			if(Data == '0')
			{

				axis_switch_cfg0();

			}
			else if(Data == '1')
			{
				axis_switch_cfg1();

			}
			else
			{
				xil_printf("\r input data error \n!!!!!!!!!!!!!");
			}
		}
		if((Data == 'c') || (Data == 'C'))
		{
			clear_display();
			xil_printf(" \r\nclear_display done!!!!!!!!!!!!!");
		}
		if((Data == 'm') || (Data == 'M'))
		{
			xil_printf("\r\n********************************\r\n");
			xil_printf("test for KU040\r\n");
		    xil_printf("\r\n%s,%s\r\n",__DATE__,__TIME__);
			xil_printf("\r\n********************************\r\n");
		}

	}
}


int main()
{

    init_platform();

	xil_printf("\r\n********************************\r\n");
	xil_printf("test for KU040\r\n");
    xil_printf("\r\n%s,%s\r\n",__DATE__,__TIME__);
	xil_printf("\r\n********************************\r\n");

#if defined (XPAR_XAXIS_SWITCH_NUM_INSTANCES)
    axis_switch_cfg1();
#endif
#if defined (XPAR_XV_TPG_NUM_INSTANCES)
    tpg_config();
#endif


    clear_display();
    vdma0_config_32();

	while(1)
	{

		uart_receive_process();

	}

    cleanup_platform();
    return 0;
}
