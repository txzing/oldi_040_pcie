#include "bsp.h"

#define UARTLITE_BASEADDR XPAR_PROCESSOR_SUBSYSTEM_AXI_UARTLITE_0_BASEADDR

u32 ret32;
u8 ret8;
u8 UserInput;
u8 cerrent_ch;
u8 i2c_device_addr_984;
u8 fake_984_i2c_addr;
u8 lock_984;
u8 lock_988;
u8 clear_flag;
u8 reconfig_flag_984;
u8 wave_flag;


u8 fresh_cnt = 0;
u8 state_cnt = 0;

void app_info(void)
{

	xil_printf("\r\nstart\r\n");
	xil_printf("\r\n");
	xil_printf("----------------------\r\n");
	xil_printf("----------------------\r\n");
	print("input :\n\r");
	xil_printf("d - detect info\r\n");
	xil_printf("c - clear screen\r\n");
#ifdef XPAR_XAXIS_SWITCH_NUM_INSTANCES
	xil_printf("s - switch video source\r\n");
#endif
	xil_printf("----------------------\r\n");
	xil_printf("\r\n");
}

void video_resolution_print(char *info,u32 baseaddr)
{
	xil_printf("-%s freq: %d -\r\n", info, Xil_In32(baseaddr + 0x8));
	xil_printf("-%s res: %dx%d -\r\n", info, Xil_In32(baseaddr + 0x8), Xil_In32(baseaddr + 0x4));
}

void uart_receive_process(void)
{
	if (!XUartLite_IsReceiveEmpty(UARTLITE_BASEADDR))
	{
		// Read data from uart
		UserInput = XUartLite_RecvByte(UARTLITE_BASEADDR);
		if((UserInput == 'm') || (UserInput == 'M'))
		{

			app_info();
		}
		else if((UserInput == 'd') || (UserInput == 'D'))
		{

			xil_printf("\r\n!!!!!!!!!!!!!!!!!!!!!!!!\r\n");
			xil_printf("------------------------\r\n");
			video_resolution_print("oldi video in",XPAR_OLDI_IN_AXIS_PASSTHROUGH_MON_0_S00_AXI_BASEADDR);
			video_resolution_print("vdma in",XPAR_AXIS_PASSTHROUGH_MON_0_S00_AXI_BASEADDR);
			xil_printf("------------------------\r\n");
		}
		else if((UserInput == 'c') || (UserInput == 'C'))
		{

			xil_printf("------------clear vdma start------------\r\n");
			clear_vdma_0();
		}
#if 1
		else if((UserInput == 's') || (UserInput == 'S'))
		{
			xil_printf("switch video source\r\n");
			xil_printf("0 - tpg\r\n");
			xil_printf("1 - lvds_stream\r\n");

			UserInput = XUartLite_RecvByte(UARTLITE_BASEADDR);

			xil_printf("------------------------\r\n");
			if(UserInput == '0')
			{
			    AxisSwitch(XPAR_AXIS_SWITCH_0_DEVICE_ID, &AxisSwitch0, 1, 0); //TPG
			    xil_printf("------------switch to TPG-----------\r\n");
			}
			else if(UserInput == '1')
			{
				AxisSwitch(XPAR_AXIS_SWITCH_0_DEVICE_ID, &AxisSwitch0, 0, 0); //stream
				clear_vdma_0();
				xil_printf("------------switch to lvds_stream-----------\r\n");
			}
			else
			{
				xil_printf("\r input data error \n!!!!!!!!!!!!!");
			}

			xil_printf("------------------------\r\n");
		}
#endif
/****************************************************************************/
/****************************************************************************/

	}
}

