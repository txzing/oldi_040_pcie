#include "bsp.h"

#if defined (XPAR_AXI_LITE_REG_NUM_INSTANCES) && (XPAR_AXI_LITE_REG_0_DEVICE_ID == 0)
volatile u32 __HW_VER__;
#endif


int main()
{
	int Status ;
	cerrent_ch = 1;//default A
	timer_cnt = 0;

    init_platform(); // include interrupts setup

    bsp_printf("\r\n\r\n***************************\n\r");
    bsp_printf("test for OLDI_PCIE\r\n");
    bsp_printf("\r\n%s, UTC %s\r\n",__DATE__,__TIME__);
    bsp_printf(TXT_RED "\r\n__FILE__:%s, __LINE__:%d\r\n" TXT_RST,__FILE__, __LINE__);
#if defined (XPAR_AXI_LITE_REG_NUM_INSTANCES) && (XPAR_AXI_LITE_REG_0_DEVICE_ID == 0)
	__HW_VER__ = AXI_LITE_REG_mReadReg(XPAR_PROCESSOR_SUBSYSTEM_AXI_LITE_REG_0_S00_AXI_BASEADDR, AXI_LITE_REG_S00_AXI_SLV_REG0_OFFSET);
//	__HW_VER__ = AXI_LITE_REG_mReadReg(XPAR_AXI_LITE_REG_0_S00_AXI_BASEADDR, AXI_LITE_REG_S00_AXI_SLV_REG0_OFFSET);
	bsp_printf(TXT_GREEN "hardware ver = 0x%08x\n\r" TXT_RST, __HW_VER__);
#endif // XPAR_AXI_LITE_REG_NUM_INSTANCES
#ifdef SW_VER_BY_COMPILE_TIME
    __SW_VER__ = GetSoftWareVersion();
    bsp_printf("software ver = 0x%08x\n\r", __SW_VER__);
    bsp_printf("***************************\n\r");

#elif defined (__SW_VER__)
//    bsp_printf("software ver = 0x%08x\n\r", __SW_VER__);
    bsp_printf(TXT_GREEN "software ver = 0x%08x\n\r" TXT_RST, __SW_VER__);
    bsp_printf("***************************\n\r");
#endif // __SW_VER__ || SW_VER_BY_COMPILE_TIME

#if defined(XPAR_XGPIO_I2C_0_AXI_GPIO_0_DEVICE_ID)
    Status = xgpio_i2c_init();
    if (Status != XST_SUCCESS)
	{
    	bsp_printf(TXT_RED "\r\n__FILE__:%s, __LINE__:%d\r\n" TXT_RST,__FILE__, __LINE__);
		Xil_Assert(__FILE__, __LINE__);
		return XST_FAILURE ;
	}
#endif // XPAR_XGPIO_I2C_0_AXI_GPIO_0_DEVICE_ID

#if (XPAR_XGPIO_NUM_INSTANCES >= 2U)
    Status = xgpio_setup();
    if (Status != XST_SUCCESS)
	{
    	bsp_printf(TXT_RED "\r\n__FILE__:%s, __LINE__:%d\r\n" TXT_RST,__FILE__, __LINE__);
		Xil_Assert(__FILE__, __LINE__);
		return XST_FAILURE ;
	}
#endif

#if defined (XPAR_XAXIS_SWITCH_NUM_INSTANCES)
    Status = axis_switch_cfg();
    if (Status != XST_SUCCESS)
	{
    	bsp_printf(TXT_RED "\r\n__FILE__:%s, __LINE__:%d\r\n" TXT_RST,__FILE__, __LINE__);
		Xil_Assert(__FILE__, __LINE__);
		return XST_FAILURE ;
	}
#endif // XPAR_XAXIS_SWITCH_NUM_INSTANCES

#if defined (XPAR_XV_TPG_NUM_INSTANCES)
    Status = tpg_config();
    if (Status != XST_SUCCESS)
	{
    	bsp_printf(TXT_RED "\r\n__FILE__:%s, __LINE__:%d\r\n" TXT_RST,__FILE__, __LINE__);
		Xil_Assert(__FILE__, __LINE__);
		return XST_FAILURE ;
	}
#endif // XPAR_XV_TPG_NUM_INSTANCES


#if defined (XPAR_XAXIVDMA_NUM_INSTANCES)
    clear_display();
#endif // XPAR_XAXIVDMA_NUM_INSTANCES

#if defined (SER_CFG) || defined (DES_CFG)
		usleep(10*1000);
//		xgpio_i2c_reg8_write(I2C_NO_1, 0x30, 0x40, 0x2C, STRETCH_ON);

#endif // SER_CFG || DES_CFG

#if defined (UDP_UPDATE) || defined (TCP_UPDATE) || defined (TCP_COMMAND_SRV) || defined (UDP_COMMAND_SRV)
	lwip_common_init(&server_netif);
#endif // #if defined (UDP_UPDATE) || defined (TCP_UPDATE) || defined (TCP_COMMAND_SRV) || defined (UDP_COMMAND_SRV)

#if defined (INTC_DEVICE_ID) || defined (INTC)
	platform_enable_interrupts();
#endif //#if defined (INTC_DEVICE_ID) || defined (INTC)

	app_info();

    while(1)
    {
#if defined (UDP_UPDATE) || defined (TCP_UPDATE) || defined (TCP_COMMAND_SRV) || defined (UDP_COMMAND_SRV)
    	transfer_data(&server_netif);
#endif // #if defined (UDP_UPDATE) || defined (TCP_UPDATE) || defined (TCP_COMMAND_SRV) || defined (UDP_COMMAND_SRV)

    	uart_receive_process();

    }

	// never reached
    cleanup_platform();
    return 0;
}
