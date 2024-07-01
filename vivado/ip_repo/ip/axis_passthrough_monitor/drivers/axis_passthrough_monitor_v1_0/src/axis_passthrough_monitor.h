
#ifndef AXI_PASSTHROUTH_MONITOR_H
#define AXI_PASSTHROUTH_MONITOR_H


/****************** Include Files ********************/
#include "xil_types.h"
#include "xstatus.h"

#define S_AXI_PASSTHROUTH_MONITOR_REG0_OFFSET 0
#define S_AXI_PASSTHROUTH_MONITOR_REG1_OFFSET 4
#define S_AXI_PASSTHROUTH_MONITOR_REG2_OFFSET 8
#define S_AXI_PASSTHROUTH_MONITOR_REG3_OFFSET 12
#define S_AXI_PASSTHROUTH_MONITOR_REG4_OFFSET 16
#define S_AXI_PASSTHROUTH_MONITOR_REG5_OFFSET 20
#define S_AXI_PASSTHROUTH_MONITOR_REG6_OFFSET 24
#define S_AXI_PASSTHROUTH_MONITOR_REG7_OFFSET 28
#define S_AXI_PASSTHROUTH_MONITOR_REG8_OFFSET 32
#define S_AXI_PASSTHROUTH_MONITOR_REG9_OFFSET 36
#define S_AXI_PASSTHROUTH_MONITOR_REG10_OFFSET 40
#define S_AXI_PASSTHROUTH_MONITOR_REG11_OFFSET 44
#define S_AXI_PASSTHROUTH_MONITOR_REG12_OFFSET 48
#define S_AXI_PASSTHROUTH_MONITOR_REG13_OFFSET 52
#define S_AXI_PASSTHROUTH_MONITOR_REG14_OFFSET 56
#define S_AXI_PASSTHROUTH_MONITOR_REG15_OFFSET 60
#define S_AXI_PASSTHROUTH_MONITOR_REG16_OFFSET 64
#define S_AXI_PASSTHROUTH_MONITOR_REG17_OFFSET 68
#define S_AXI_PASSTHROUTH_MONITOR_REG18_OFFSET 72
#define S_AXI_PASSTHROUTH_MONITOR_REG19_OFFSET 76
#define S_AXI_PASSTHROUTH_MONITOR_REG20_OFFSET 80
#define S_AXI_PASSTHROUTH_MONITOR_REG21_OFFSET 84
#define S_AXI_PASSTHROUTH_MONITOR_REG22_OFFSET 88
#define S_AXI_PASSTHROUTH_MONITOR_REG23_OFFSET 92
#define S_AXI_PASSTHROUTH_MONITOR_REG24_OFFSET 96
#define S_AXI_PASSTHROUTH_MONITOR_REG25_OFFSET 100
#define S_AXI_PASSTHROUTH_MONITOR_REG26_OFFSET 104
#define S_AXI_PASSTHROUTH_MONITOR_REG27_OFFSET 108
#define S_AXI_PASSTHROUTH_MONITOR_REG28_OFFSET 112
#define S_AXI_PASSTHROUTH_MONITOR_REG29_OFFSET 116
#define S_AXI_PASSTHROUTH_MONITOR_REG30_OFFSET 120
#define S_AXI_PASSTHROUTH_MONITOR_REG31_OFFSET 124


/**************************** Type Definitions *****************************/
/**
 *
 * Write a value to a AXI_PASSTHROUTH_MONITOR_REG register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the AXI_PASSTHROUTH_MONITOR_REGdevice.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void AXI_PASSTHROUTH_MONITOR_REG_mWriteReg(u32 BaseAddress, unsigned RegOffset, u32 Data)
 *
 */
#define AXI_PASSTHROUTH_MONITOR_REG_mWriteReg(BaseAddress, RegOffset, Data) \
  	Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))

/**
 *
 * Read a value from a AXI_PASSTHROUTH_MONITOR_REG register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the AXI_PASSTHROUTH_MONITOR_REG device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	u32 AXI_PASSTHROUTH_MONITOR_REG_mReadReg(u32 BaseAddress, unsigned RegOffset)
 *
 */
#define AXI_PASSTHROUTH_MONITOR_REG_mReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))

/************************** Function Prototypes ****************************/
/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the AXI_PASSTHROUTH_MONITOR_REG instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus AXI_PASSTHROUTH_MONITOR_REG_Reg_SelfTest(void * baseaddr_p);

#endif // AXI_PASSTHROUTH_MONITOR_H
