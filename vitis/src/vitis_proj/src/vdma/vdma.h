#ifndef __VDMA_H__

//#include "xparameters.h"
#if defined (XPAR_XAXIVDMA_NUM_INSTANCES)
#define __VDMA_H__
#include "xaxivdma.h"

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 1U)
//#define CFG_VDMA_0_AFTER_CLEAR
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 1U
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 2U)
//#define CFG_VDMA_1_AFTER_CLEAR
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 2U
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 3U)
//#define CFG_VDMA_2_AFTER_CLEAR
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 3U
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 4U)
//#define CFG_VDMA_3_AFTER_CLEAR
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 4U
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 5U)
//#define CFG_VDMA_4_AFTER_CLEAR
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 5U
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 6U)
//#define CFG_VDMA_5_AFTER_CLEAR
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 6U
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 7U)
//#define CFG_VDMA_6_AFTER_CLEAR
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 7U
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 8U)
//#define CFG_VDMA_7_AFTER_CLEAR
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 8U

#if defined (XPAR_DDR_MEM_BASEADDR)
#define DDR_BASEADDR XPAR_DDR_MEM_BASEADDR
#else
#define DDR_BASEADDR 0x80000000	// if microblaze has extern ddr.
#endif

// reserve enough memory size for stack+heap+bss+data+text
#define RESERVE_SIZE				(0x10000000)
#define FRAME_BUFFER_BASE_ADDR  	(DDR_BASEADDR + RESERVE_SIZE)

// change these macros if needed

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 1U)
//#define VDMA_0_BPP					(2)	// byte per pixel
#define VDMA_0_BPP					(3)	// byte per pixel
//#if (XPAR_AXIVDMA_0_INCLUDE_S2MM == 1U)
#define VDMA_0_W_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_0_W_WIDTH				(1920U)
#define VDMA_0_W_STRIDE				(1920U)
#define VDMA_0_W_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_0_INCLUDE_S2MM == 1U
//#if (XPAR_AXIVDMA_0_INCLUDE_MM2S == 1U)
#define VDMA_0_R_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_0_R_WIDTH				(1920U)
#define VDMA_0_R_STRIDE				(1920U)
#define VDMA_0_R_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_0_INCLUDE_MM2S == 1U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 1U

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 2U)
#define VDMA_1_BPP					(3)	// byte per pixel
//#if (XPAR_AXIVDMA_1_INCLUDE_S2MM == 1U)
#define VDMA_1_W_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_1_W_WIDTH				(1920U)
#define VDMA_1_W_STRIDE				(1920U)
#define VDMA_1_W_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_1_INCLUDE_S2MM == 1U
//#if (XPAR_AXIVDMA_1_INCLUDE_MM2S == 1U)
#define VDMA_1_R_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_1_R_WIDTH				(1920U)
#define VDMA_1_R_STRIDE				(1920U)
#define VDMA_1_R_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_1_INCLUDE_MM2S == 1U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 2U

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 3U)
#define VDMA_2_BPP					(3)	// byte per pixel
//#if (XPAR_AXIVDMA_2_INCLUDE_S2MM == 1U)
#define VDMA_2_W_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_2_W_WIDTH				(1920U)
#define VDMA_2_W_STRIDE				(1920U)
#define VDMA_2_W_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_2_INCLUDE_S2MM == 1U
//#if (XPAR_AXIVDMA_2_INCLUDE_MM2S == 1U)
#define VDMA_2_R_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_2_R_WIDTH				(1920U)
#define VDMA_2_R_STRIDE				(1920U)
#define VDMA_2_R_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_2_INCLUDE_MM2S == 1U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 3U

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 4U)
#define VDMA_3_BPP					(3)	// byte per pixel
//#if (XPAR_AXIVDMA_3_INCLUDE_S2MM == 1U)
#define VDMA_3_W_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_3_W_WIDTH				(1920U)
#define VDMA_3_W_STRIDE				(1920U)
#define VDMA_3_W_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_3_INCLUDE_S2MM == 1U
//#if (XPAR_AXIVDMA_3_INCLUDE_MM2S == 1U)
#define VDMA_3_R_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_3_R_WIDTH				(1920U)
#define VDMA_3_R_STRIDE				(1920U)
#define VDMA_3_R_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_3_INCLUDE_MM2S == 1U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 4U

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 5U)
#define VDMA_4_BPP					(3)	// byte per pixel
//#if (XPAR_AXIVDMA_4_INCLUDE_S2MM == 1U)
#define VDMA_4_W_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_4_W_WIDTH				(1920U)
#define VDMA_4_W_STRIDE				(1920U)
#define VDMA_4_W_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_4_INCLUDE_S2MM == 1U
//#if (XPAR_AXIVDMA_4_INCLUDE_MM2S == 1U)
#define VDMA_4_R_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_4_R_WIDTH				(1920U)
#define VDMA_4_R_STRIDE				(1920U)
#define VDMA_4_R_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_4_INCLUDE_MM2S == 1U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 5U

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 6U)
#define VDMA_5_BPP					(3)	// byte per pixel
//#if (XPAR_AXIVDMA_5_INCLUDE_S2MM == 1U)
#define VDMA_5_W_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_5_W_WIDTH				(1920U)
#define VDMA_5_W_STRIDE				(1920U)
#define VDMA_5_W_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_5_INCLUDE_S2MM == 1U
//#if (XPAR_AXIVDMA_5_INCLUDE_MM2S == 1U)
#define VDMA_5_R_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_5_R_WIDTH				(1920U)
#define VDMA_5_R_STRIDE				(1920U)
#define VDMA_5_R_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_5_INCLUDE_MM2S == 1U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 6U

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 7U)
#define VDMA_6_BPP					(3)	// byte per pixel
//#if (XPAR_AXIVDMA_6_INCLUDE_S2MM == 1U)
#define VDMA_6_W_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_6_W_WIDTH				(1920U)
#define VDMA_6_W_STRIDE				(1920U)
#define VDMA_6_W_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_6_INCLUDE_S2MM == 1U
//#if (XPAR_AXIVDMA_6_INCLUDE_MM2S == 1U)
#define VDMA_6_R_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_6_R_WIDTH				(1920U)
#define VDMA_6_R_STRIDE				(1920U)
#define VDMA_6_R_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_6_INCLUDE_MM2S == 1U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 7U

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 8U)
#define VDMA_7_BPP					(3)	// byte per pixel
//#if (XPAR_AXIVDMA_7_INCLUDE_S2MM == 1U)
#define VDMA_7_W_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_7_W_WIDTH				(1920U)
#define VDMA_7_W_STRIDE				(1920U)
#define VDMA_7_W_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_7_INCLUDE_S2MM == 1U
//#if (XPAR_AXIVDMA_7_INCLUDE_MM2S == 1U)
#define VDMA_7_R_OFFSET				(0) // (y*w+x)*Bpp
#define VDMA_7_R_WIDTH				(1920U)
#define VDMA_7_R_STRIDE				(1920U)
#define VDMA_7_R_HEIGHTH			(1080U)
//#endif // XPAR_AXIVDMA_7_INCLUDE_MM2S == 1U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 8U


#define BUFFER_SIZE_4K_24PPC      	0x2000000    //0x2000000 for max 4KW RGB888 8bpc
#define BUFFER_SIZE_1080P_24PPC		0x600000    //0x600000 for max 1080p RGB888 8bpc


#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 1U)
#define BUFFER_BASE_VDMA_0			FRAME_BUFFER_BASE_ADDR
#define BUFFER_SIZE_VDMA_0			BUFFER_SIZE_4K_24PPC

#if (XPAR_AXI_VDMA_0_NUM_FSTORES >= 1U)
#define FRAME_BUFFER_0_0			BUFFER_BASE_VDMA_0 + BUFFER_SIZE_VDMA_0 * 0
#endif // XPAR_AXI_VDMA_0_NUM_FSTORES == 1U
#if (XPAR_AXI_VDMA_0_NUM_FSTORES >= 2U)
#define FRAME_BUFFER_0_1			BUFFER_BASE_VDMA_0 + BUFFER_SIZE_VDMA_0 * 1
#endif // XPAR_AXI_VDMA_0_NUM_FSTORES == 2U
#if (XPAR_AXI_VDMA_0_NUM_FSTORES >= 3U)
#define FRAME_BUFFER_0_2			BUFFER_BASE_VDMA_0 + BUFFER_SIZE_VDMA_0 * 2
#endif // XPAR_AXI_VDMA_0_NUM_FSTORES == 3U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 1U


#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 2U)
#define BUFFER_BASE_VDMA_1			FRAME_BUFFER_BASE_ADDR + BUFFER_SIZE_VDMA_0 * XPAR_AXI_VDMA_0_NUM_FSTORES
#define BUFFER_SIZE_VDMA_1			BUFFER_SIZE_4K_24PPC

#if (XPAR_AXI_VDMA_1_NUM_FSTORES >= 1U)
#define FRAME_BUFFER_1_0			BUFFER_BASE_VDMA_1 + BUFFER_SIZE_VDMA_1 * 0
#endif // XPAR_AXI_VDMA_1_NUM_FSTORES == 1U
#if (XPAR_AXI_VDMA_1_NUM_FSTORES >= 2U)
#define FRAME_BUFFER_1_1			BUFFER_BASE_VDMA_1 + BUFFER_SIZE_VDMA_1 * 1
#endif // XPAR_AXI_VDMA_1_NUM_FSTORES == 2U
#if (XPAR_AXI_VDMA_1_NUM_FSTORES >= 3U)
#define FRAME_BUFFER_1_2			BUFFER_BASE_VDMA_1 + BUFFER_SIZE_VDMA_1 * 2
#endif // XPAR_AXI_VDMA_1_NUM_FSTORES == 3U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 2U


#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 3U)
#define BUFFER_BASE_VDMA_2			FRAME_BUFFER_BASE_ADDR + \
										BUFFER_SIZE_VDMA_0 * XPAR_AXI_VDMA_0_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_1 * XPAR_AXI_VDMA_1_NUM_FSTORES
#define BUFFER_SIZE_VDMA_2			BUFFER_SIZE_1080P_24PPC

#if (XPAR_AXI_VDMA_2_NUM_FSTORES >= 1U)
#define FRAME_BUFFER_2_0			BUFFER_BASE_VDMA_2 + BUFFER_SIZE_VDMA_2 * 0
#endif // XPAR_AXI_VDMA_2_NUM_FSTORES == 1U
#if (XPAR_AXI_VDMA_2_NUM_FSTORES >= 2U)
#define FRAME_BUFFER_2_1			BUFFER_BASE_VDMA_2 + BUFFER_SIZE_VDMA_2 * 1
#endif // XPAR_AXI_VDMA_2_NUM_FSTORES == 2U
#if (XPAR_AXI_VDMA_2_NUM_FSTORES >= 3U)
#define FRAME_BUFFER_2_2			BUFFER_BASE_VDMA_2 + BUFFER_SIZE_VDMA_2 * 2
#endif // XPAR_AXI_VDMA_2_NUM_FSTORES == 3U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 3U


#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 4U)
#define BUFFER_BASE_VDMA_3			FRAME_BUFFER_BASE_ADDR + \
										BUFFER_SIZE_VDMA_0 * XPAR_AXI_VDMA_0_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_1 * XPAR_AXI_VDMA_1_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_2 * XPAR_AXI_VDMA_2_NUM_FSTORES
#define BUFFER_SIZE_VDMA_3			BUFFER_SIZE_1080P_24PPC

#if (XPAR_AXI_VDMA_3_NUM_FSTORES >= 1U)
#define FRAME_BUFFER_3_0			BUFFER_BASE_VDMA_3 + BUFFER_SIZE_VDMA_3 * 0
#endif // XPAR_AXI_VDMA_3_NUM_FSTORES == 1U
#if (XPAR_AXI_VDMA_3_NUM_FSTORES >= 2U)
#define FRAME_BUFFER_3_1			BUFFER_BASE_VDMA_3 + BUFFER_SIZE_VDMA_3 * 1
#endif // XPAR_AXI_VDMA_3_NUM_FSTORES == 2U
#if (XPAR_AXI_VDMA_3_NUM_FSTORES >= 3U)
#define FRAME_BUFFER_3_2			BUFFER_BASE_VDMA_3 + BUFFER_SIZE_VDMA_3 * 2
#endif // XPAR_AXI_VDMA_3_NUM_FSTORES == 3U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 4U


#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 5U)
#define BUFFER_BASE_VDMA_4			FRAME_BUFFER_BASE_ADDR + \
										BUFFER_SIZE_VDMA_0 * XPAR_AXI_VDMA_0_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_1 * XPAR_AXI_VDMA_1_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_2 * XPAR_AXI_VDMA_2_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_3 * XPAR_AXI_VDMA_3_NUM_FSTORES
#define BUFFER_SIZE_VDMA_4			BUFFER_SIZE_1080P_24PPC

#if (XPAR_AXI_VDMA_4_NUM_FSTORES >= 1U)
#define FRAME_BUFFER_4_0			BUFFER_BASE_VDMA_4 + BUFFER_SIZE_VDMA_4 * 0
#endif // XPAR_AXI_VDMA_4_NUM_FSTORES == 1U
#if (XPAR_AXI_VDMA_4_NUM_FSTORES >= 2U)
#define FRAME_BUFFER_4_1			BUFFER_BASE_VDMA_4 + BUFFER_SIZE_VDMA_4 * 1
#endif // XPAR_AXI_VDMA_4_NUM_FSTORES == 2U
#if (XPAR_AXI_VDMA_4_NUM_FSTORES >= 3U)
#define FRAME_BUFFER_4_2			BUFFER_BASE_VDMA_4 + BUFFER_SIZE_VDMA_4 * 2
#endif // XPAR_AXI_VDMA_4_NUM_FSTORES == 3U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 5U


#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 6U)
#define BUFFER_BASE_VDMA_5			FRAME_BUFFER_BASE_ADDR + \
										BUFFER_SIZE_VDMA_0 * XPAR_AXI_VDMA_0_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_1 * XPAR_AXI_VDMA_1_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_2 * XPAR_AXI_VDMA_2_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_3 * XPAR_AXI_VDMA_3_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_4 * XPAR_AXI_VDMA_4_NUM_FSTORES
#define BUFFER_SIZE_VDMA_5			BUFFER_SIZE_1080P_24PPC

#if (XPAR_AXI_VDMA_5_NUM_FSTORES >= 1U)
#define FRAME_BUFFER_5_0			BUFFER_BASE_VDMA_5 + BUFFER_SIZE_VDMA_5 * 0
#endif // XPAR_AXI_VDMA_5_NUM_FSTORES == 1U
#if (XPAR_AXI_VDMA_5_NUM_FSTORES >= 2U)
#define FRAME_BUFFER_5_1			BUFFER_BASE_VDMA_5 + BUFFER_SIZE_VDMA_5 * 1
#endif // XPAR_AXI_VDMA_5_NUM_FSTORES == 2U
#if (XPAR_AXI_VDMA_5_NUM_FSTORES >= 3U)
#define FRAME_BUFFER_5_2			BUFFER_BASE_VDMA_5 + BUFFER_SIZE_VDMA_5 * 2
#endif // XPAR_AXI_VDMA_5_NUM_FSTORES == 3U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 6U


#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 7U)
#define BUFFER_BASE_VDMA_6			FRAME_BUFFER_BASE_ADDR + \
										BUFFER_SIZE_VDMA_0 * XPAR_AXI_VDMA_0_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_1 * XPAR_AXI_VDMA_1_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_2 * XPAR_AXI_VDMA_2_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_3 * XPAR_AXI_VDMA_3_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_4 * XPAR_AXI_VDMA_4_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_5 * XPAR_AXI_VDMA_5_NUM_FSTORES
#define BUFFER_SIZE_VDMA_6			BUFFER_SIZE_1080P_24PPC

#if (XPAR_AXI_VDMA_6_NUM_FSTORES >= 1U)
#define FRAME_BUFFER_6_0			BUFFER_BASE_VDMA_6 + BUFFER_SIZE_VDMA_6 * 0
#endif // XPAR_AXI_VDMA_6_NUM_FSTORES == 1U
#if (XPAR_AXI_VDMA_6_NUM_FSTORES >= 2U)
#define FRAME_BUFFER_6_1			BUFFER_BASE_VDMA_6 + BUFFER_SIZE_VDMA_6 * 1
#endif // XPAR_AXI_VDMA_6_NUM_FSTORES == 2U
#if (XPAR_AXI_VDMA_6_NUM_FSTORES >= 3U)
#define FRAME_BUFFER_6_2			BUFFER_BASE_VDMA_6 + BUFFER_SIZE_VDMA_6 * 2
#endif // XPAR_AXI_VDMA_6_NUM_FSTORES == 3U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 7U


#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 8U)
#define BUFFER_BASE_VDMA_7			FRAME_BUFFER_BASE_ADDR + \
										BUFFER_SIZE_VDMA_0 * XPAR_AXI_VDMA_0_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_1 * XPAR_AXI_VDMA_1_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_2 * XPAR_AXI_VDMA_2_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_3 * XPAR_AXI_VDMA_3_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_4 * XPAR_AXI_VDMA_4_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_5 * XPAR_AXI_VDMA_5_NUM_FSTORES + \
										BUFFER_SIZE_VDMA_6 * XPAR_AXI_VDMA_6_NUM_FSTORES
#define BUFFER_SIZE_VDMA_7			BUFFER_SIZE_1080P_24PPC

#if (XPAR_AXI_VDMA_7_NUM_FSTORES >= 1U)
#define FRAME_BUFFER_7_0			BUFFER_BASE_VDMA_7 + BUFFER_SIZE_VDMA_7 * 0
#endif // XPAR_AXI_VDMA_7_NUM_FSTORES == 1U
#if (XPAR_AXI_VDMA_7_NUM_FSTORES >= 2U)
#define FRAME_BUFFER_7_1			BUFFER_BASE_VDMA_7 + BUFFER_SIZE_VDMA_7 * 1
#endif // XPAR_AXI_VDMA_7_NUM_FSTORES == 2U
#if (XPAR_AXI_VDMA_7_NUM_FSTORES >= 3U)
#define FRAME_BUFFER_7_2			BUFFER_BASE_VDMA_7 + BUFFER_SIZE_VDMA_7 * 2
#endif // XPAR_AXI_VDMA_7_NUM_FSTORES == 3U
#endif // XPAR_XAXIVDMA_NUM_INSTANCES == 8U

//#define FRAME_BUFFER_0          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*0)
//#define FRAME_BUFFER_1          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*1)
//#define FRAME_BUFFER_2          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*2)
//#define FRAME_BUFFER_3          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*3)
//#define FRAME_BUFFER_4          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*4)
//#define FRAME_BUFFER_5          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*5)
//#define FRAME_BUFFER_6          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*6)
//#define FRAME_BUFFER_7          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*7)
//#define FRAME_BUFFER_8          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*8)
//#define FRAME_BUFFER_9          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*9)
//#define FRAME_BUFFER_10         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*10)
//#define FRAME_BUFFER_11         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*11)
//#define FRAME_BUFFER_12         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*12)
//#define FRAME_BUFFER_13         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*13)
//#define FRAME_BUFFER_14         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*14)
//#define FRAME_BUFFER_15         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*15)
//#define FRAME_BUFFER_16         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*16)
//#define FRAME_BUFFER_17         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*17)
//#define FRAME_BUFFER_18         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*18)
//#define FRAME_BUFFER_19         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*19)
//#define FRAME_BUFFER_20         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*20)
//#define FRAME_BUFFER_21         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*21)
//#define FRAME_BUFFER_22         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*22)
//#define FRAME_BUFFER_23         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*23)

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 1U)
extern XAxiVdma Vdma0;
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 2U)
extern XAxiVdma Vdma1;
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 3U)
extern XAxiVdma Vdma2;
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 4U)
extern XAxiVdma Vdma3;
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 5U)
extern XAxiVdma Vdma4;
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 6U)
extern XAxiVdma Vdma5;
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 7U)
extern XAxiVdma Vdma6;
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 8U)
extern XAxiVdma Vdma7;
#endif

int vdma_init(XAxiVdma *InstancePtr, u16 DeviceID);
int vdma_read_start(XAxiVdma *InstancePtr);
void vdma_read_stop(XAxiVdma *InstancePtr);
int vdma_read_init
(
	XAxiVdma *InstancePtr,
	u16 DeviceID,
	u16 HoriSizeInput,
	u16 VertSizeInput,
	u16 Stride,
	UINTPTR FrameStoreStartAddr0,
	UINTPTR FrameStoreStartAddr1,
	UINTPTR FrameStoreStartAddr2
);
int vdma_write_start(XAxiVdma *InstancePtr);
void vdma_write_stop(XAxiVdma *InstancePtr);
int vdma_write_init
(
	XAxiVdma *InstancePtr,
	u16 DeviceID,
	u16 HoriSizeInput,
	u16 VertSizeInput,
	u16 Stride,
	UINTPTR FrameStoreStartAddr0,
	UINTPTR FrameStoreStartAddr1,
	UINTPTR FrameStoreStartAddr2
);

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 1U)
void vdma_config_m32_0(void);
void vdma_config_m64_0(void);

void clear_display_0(void);
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 2U)
void vdma_config_m32_1(void);
void vdma_config_m64_1(void);
void clear_display_1(void);
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 3U)
void vdma_config_m32_2(void);
void vdma_config_m64_2(void);
void clear_display_2(void);
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 4U)
void vdma_config_m32_3(void);
void vdma_config_m64_3(void);
void clear_display_3(void);
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 5U)
void vdma_config_m32_4(void);
void vdma_config_m64_4(void);
void clear_display_4(void);
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 6U)
void vdma_config_m32_5(void);
void vdma_config_m64_5(void);
void clear_display_5(void);
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 7U)
void vdma_config_m32_6(void);
void vdma_config_m64_6(void);
void clear_display_6(void);
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 8U)
void vdma_config_m32_7(void);
void vdma_config_m64_7(void);
void clear_display_7(void);
#endif

void vdma_reg_cfg
(
	XAxiVdma *InstancePtr,
	u32 bytePerPixels,
	s32 w_offset,	// offset (y*w+x)*Bpp
	s32 r_offset,
	u32 w_stride,
	u32 w_width,
	u32 w_height,
	u32 r_stride,
	u32 r_width,
	u32 r_height,
	UINTPTR *BufferAddr
);
int vdma_config(void);

void clear_display(void);
void vdma_config_direct(void);

#endif // XPAR_XAXIVDMA_NUM_INSTANCES

#endif // __VDMA_H__

