#include "bsp.h"

#define UARTLITE_BASEADDR XPAR_UARTLITE_0_BASEADDR

u32 ret32;
u8 ret8;
u8 UserInput;
u8 cerrent_ch;
u8 lock_status;
u8 reconfig_flag;
u8 clear_flag;
u8 wave_flag;

u8 key_flag = 0;

void app_info(void)
{
	xil_printf("----------------------\r\n");
	xil_printf("\r\n%s, UTC %s\r\n",__DATE__,__TIME__);
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
	xil_printf("-%s res: %dx%d -\r\n", info, Xil_In32(baseaddr + 0x0), Xil_In32(baseaddr + 0x4));
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
			video_resolution_print("vdma in",XPAR_MEMORY_SUBSYSTEM_AXIS_PASSTHROUGH_MON_0_S00_AXI_BASEADDR);
			xil_printf("------------------------\r\n");
		}
		else if((UserInput == 'k') || (UserInput == 'K'))
		{
			xil_printf("\r\n------------k_flag------------\r\n");
			key_flag = !key_flag;
		}

		else if((UserInput == '7'))
		{
			xil_printf("\r\n------------vdma_write_stop------------\r\n");
			vdma_write_stop(&Vdma0);
		}
		else if((UserInput == '8'))
		{
			xil_printf("\r\n------------vdma_write_start------------\r\n");
			vdma_write_start(&Vdma0);
		}

		else if((UserInput == 'c') || (UserInput == 'C'))
		{

			xil_printf("------------clear vdma start------------\r\n");
			clear_vdma_0();
		}
		else if((UserInput == 'f') || (UserInput == 'F'))
		{
			xil_printf("------------show max96752 status------------\r\n");
			ret8 = 0;
			xgpio_i2c_reg16_read(I2C_NO_1, 0x2A, 0x01d2, &ret8, STRETCH_ON);
			xil_printf("0x01d2 = %x\r\n",ret8);
			xgpio_i2c_reg16_read(I2C_NO_1, 0x2A, 0x01d4, &ret8, STRETCH_ON);
			xil_printf("0x01d4 = %x\r\n",ret8);
			xgpio_i2c_reg16_read(I2C_NO_1, 0x2A, 0x0003, &ret8, STRETCH_ON);
			xil_printf("0x0003 = %x\r\n",ret8);
			xgpio_i2c_reg16_read(I2C_NO_1, 0x2A, 0x0013, &ret8, STRETCH_ON);
			xil_printf("0x0013 = %x\r\n",ret8);
			xgpio_i2c_reg16_read(I2C_NO_1, 0x2A, 0x0108, &ret8, STRETCH_ON);
			xil_printf("0x0108 = %x\r\n",ret8);
			xgpio_i2c_reg16_read(I2C_NO_1, 0x2A, 0x0003, &ret8, STRETCH_ON);
			xil_printf("0x0003 = %x\r\n",ret8);
		}
		else if((UserInput == 'g') || (UserInput == 'G'))
		{
			xil_printf("------------config max96752------------\r\n");
			serdes_i2c_write_16(I2C_NO_1, 0x54, 0x0050, 0x01);
			serdes_i2c_write_array_16(I2C_NO_1, max96752_oldi);
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
				AxisSwitch(XPAR_AXIS_SWITCH_0_DEVICE_ID, &AxisSwitch0, 0, 0); //stream
				clear_vdma_0();
				xil_printf("------------switch to lvds_stream-----------\r\n");
			}
			else if(UserInput == '1')
			{
			    AxisSwitch(XPAR_AXIS_SWITCH_0_DEVICE_ID, &AxisSwitch0, 1, 0); //TPG
			    xil_printf("------------switch to TPG-----------\r\n");
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

void max96752_lock_detect(u8 ch)
{

	u8 reg_0x01d2 = 0;
	u8 reg_0x0003 = 0;
	u8 reg_0x0013 = 0;
	u8 reg_0x0108 = 0;
	ret8 = 0;
	xgpio_i2c_reg16_read(ch, 0x2A, 0x01d2, &ret8, STRETCH_ON);
	reg_0x01d2 = ret8;
	xgpio_i2c_reg16_read(ch, 0x2A, 0x0003, &ret8, STRETCH_ON);
	reg_0x0003 = ret8;
	xgpio_i2c_reg16_read(ch, 0x2A, 0x0013, &ret8, STRETCH_ON);
	reg_0x0013 = ret8;
	xgpio_i2c_reg16_read(ch, 0x2A, 0x0108, &ret8, STRETCH_ON);
	reg_0x0108 = ret8;


	if(reg_0x01d2 == 0x22 && reg_0x0003 == 0x31 && reg_0x0013 == 0xDA && reg_0x0108 == 0x62)
	{
		ret8 = 0;
		usleep(1*1000);
		xgpio_i2c_reg16_read(ch, 0x2A, 0x01d2, &ret8, STRETCH_ON);
		reg_0x01d2 = ret8;
		xgpio_i2c_reg16_read(ch, 0x2A, 0x0003, &ret8, STRETCH_ON);
		reg_0x0003 = ret8;
		xgpio_i2c_reg16_read(ch, 0x2A, 0x0013, &ret8, STRETCH_ON);
		reg_0x0013 = ret8;
		xgpio_i2c_reg16_read(ch, 0x2A, 0x0108, &ret8, STRETCH_ON);
		reg_0x0108 = ret8;
		if(reg_0x01d2 == 0x22 && reg_0x0003 == 0x31 && reg_0x0013 == 0xDA && reg_0x0108 == 0x62)
		{
//			xil_printf("\r\n lock_status \r\n");
			lock_status = 1;
		}
		else
		{
	//		xil_printf("\r\n no lock_status !!!\r\n");
			lock_status = 0;
		}
	}
	else
	{
//		xil_printf("\r\n no lock_status !!!\r\n");
		lock_status = 0;
	}
}

void display_fresh(void)
{
	if(timer_cnt >= 1)//200ms
	{
		timer_cnt = 0;
		max96752_lock_detect(I2C_NO_1);

		if(lock_status == 1)
		{
			clear_flag = 0;
			if(reconfig_flag == 0)
			{
				reconfig_flag = 1;
			}
			else
			{
//				reconfig_flag = 2;
			}

		}
		else
		{

			reconfig_flag = 0;
			if(clear_flag == 0)
			{
				clear_flag = 1;
			}
			else
			{
//				clear_flag = 2;
			}

		}

			if(reconfig_flag == 1)
			{
				serdes_i2c_write_16(I2C_NO_1, 0x54, 0x0050, 0x01);
				serdes_i2c_write_array_16(I2C_NO_1, max96752_oldi);
				reconfig_flag = 2;
			}


			if(clear_flag == 1)
			{
				clear_vdma_0();
				clear_flag = 2;
			}
	}

}


