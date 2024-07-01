#ifndef __BSP_H__
#define __BSP_H__

//这里引入标准库,按需要打开
#include <stdio.h>
#include <string.h>
//#include <stdlib.h>
//#include <stdint.h>
//#include <stddef.h>
//#include <malloc.h>
//#include <assert.h>
//#include <ctype.h>

/*
 * PLATFORM_ZYNQ or PLATFORM_ZYNQMP defined in xparameters.h
#if defined (__arm__) && !defined (ARMR5)
#define PLATFORM_ZYNQ
#endif
#if defined (ARMR5) || (__aarch64__) || (ARMA53_32)
#define PLATFORM_ZYNQMP
#endif
 */

//引入xilinx定义的通用头文件
#include "xparameters.h"
#if defined (PLATFORM_ZYNQMP) || defined (PLATFORM_ZYNQ)
#include "xparameters_ps.h"	// defines XPAR values
#endif // PLATFORM_ZYNQMP || PLATFORM_ZYNQ
#include "xil_types.h"
#include "xil_assert.h"
#include "xil_cache.h"
#include "xstatus.h"
#include "sleep.h"

//自定义通用头文件
#include "config.h"
#include "dbg_trace.h"
#include "bitmanip.h"
#if defined (SW_VER_BY_COMPILE_TIME)
#include "version/version.h"
#else
#include "version.h"
#endif // SW_VER_BY_COMPILE_TIME

//直接引入的外设库头文件

//简单串口打印，不支持浮点数
#ifndef __PPC__ // znyq zynqmp mb都可以用，排除PPC架构
#include "xil_printf.h"
#endif // __PPC__

//下面是串口非打印所需
//#if defined (XPAR_XUARTLITE_NUM_INSTANCES)	// 一般用 uart lite，znyq zynqmp mb都可以用
//#include "xuartlite_l.h"
////#elif defined (ARMR5) || defined (__aarch64__) || defined (__arm__)	// zynqmp 有 r5 核， a53 核， znyq有 a9 核
//#elif defined (XPAR_XUARTPS_NUM_INSTANCES)  // 如果没有 uart lite，再检查是否有 ps uart
//#include "xuartps.h"
//#endif
#if defined (XPAR_XUARTLITE_NUM_INSTANCES)	// 一般用 uart lite，znyq zynqmp mb都可以用
#include "xuartlite_l.h"
#endif // XPAR_XUARTLITE_NUM_INSTANCESs
#if defined (XPAR_XUARTPS_NUM_INSTANCES)  // ps uart
#include "xuartps.h"
#endif // XPAR_XUARTPS_NUM_INSTANCES

// 一般都会设置hw的版本号
#ifdef XPAR_AXI_LITE_REG_NUM_INSTANCES
#include "AXI_LITE_REG.h"
#endif // XPAR_AXI_LITE_REG_NUM_INSTANCES

// axis stream 监测
#ifdef XPAR_AXI_PASSTHROUGH_MONITOR_NUM_INSTANCES
#include "axis_passthrough_monitor.h"
#endif // XPAR_AXI_PASSTHROUGH_MONITOR_NUM_INSTANCES

#include "lwip_servers/lwip_common.h"
#include "lwip_servers/udp_cmd.h"
#include "lwip_servers/tcp_cmd.h"
// IAP methods
// udp remote update
#include "lwip_servers/udp_update.h"
// tcp remote update
#include "lwip_servers/tcp_update.h"


// 中断发生器
//#if defined (__MICROBLAZE__)
//#include "xintc.h"
//#else
//#include "xscugic.h"
//#endif

//#if defined (ARMR5) || defined (__aarch64__) || defined (__arm__)
//#include "xscugic.h"
//#include "xil_exception.h"
//#else
//#include "xintc.h"
//#include "xil_exception.h"
//#endif

#if defined (XPAR_XSCUGIC_NUM_INSTANCES)
#include "xscugic.h"
#include "xil_exception.h"
#define INTC				XScuGic
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#define INTC_HANDLER		XScuGic_InterruptHandler
#define INTC_CONNECT		XScuGic_Connect
#define INTC_CONNECT_ENABLE	XScuGic_Enable
#define INTC_BASE_ADDR		XPAR_SCUGIC_0_CPU_BASEADDR
#define INTC_DIST_BASE_ADDR	XPAR_SCUGIC_0_DIST_BASEADDR
extern INTC InterruptController;	/* Instance of the Interrupt Controller */
#elif defined (XPAR_XINTC_NUM_INSTANCES)
#include "xintc.h"
#include "xil_exception.h"
#define INTC				XIntc
#define INTC_DEVICE_ID		XPAR_INTC_0_DEVICE_ID
#define INTC_HANDLER		XIntc_InterruptHandler
#define INTC_CONNECT		XIntc_Connect
#define INTC_CONNECT_ENABLE	XIntc_Enable
#define INTC_BASE_ADDR		XPAR_INTC_0_BASEADDR
extern INTC InterruptController;	/* Instance of the Interrupt Controller */
#endif

#include "platform.h"

#if defined (ARMR5) || (__aarch64__) || (__arm__) || (__PPC__)
	#include "xtime_l.h"
#endif

// 自定义外设库头文件
#include "xgpio_i2c/xgpio_i2c.h"
#include "ps_gpio/ps_gpio.h"
#include "clk_wiz/clk_wiz.h"
#include "vtc/vtc.h"
#include "tpg/tpg.h"
#include "xswitch/xswitch.h"
#include "csi_rx/csi_rx.h"
#include "csi_tx/csi_tx.h"
#include "vdma/vdma.h"
#include "ps_i2c/ps_i2c.h"
#include "x_i2c/x_i2c.h"
#include "emio_i2c/emio_i2c.h"
#include "eeprom/eeprom.h"
#include "vpss/vpss.h"
#include "demosaic/demosaic.h"
#include "gamma_lut/gamma_lut.h"
#include "sil9136/sil9136.h"
#include "ads7128/ads7128.h"
#include "it6801/it6801.h"
#include "qspi_flash/qspi_flash.h"
#include "rs485/rs485.h"
#include "axi_timer/axi_timer.h"
#include "uartlite_fifo/uartlite_fifo.h"

#if defined (MODBUS_RTU_SLAVE)
#if !defined (__RS485_H__)
#error "No rs485 heir in design"
#endif
#include "modbus_slave/modbus_slave.h"
#endif // MODBUS_RTU_SLAVE

// 自定义数据头文件
#include "serdes/serdes.h"

#endif // __BSP_H__