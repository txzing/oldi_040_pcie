#include "../bsp.h"

#ifdef XPAR_XAXIVDMA_NUM_INSTANCES

#if defined (__MICROBLAZE__)
	#define DDR_BASEADDR XPAR_MICROBLAZE_DCACHE_BASEADDR
//	#define DDR_BASEADDR 0x80000000
#else
	#define DDR_BASEADDR XPAR_DDR_MEM_BASEADDR
#endif

#define FRAME_BUFFER_BASE_ADDR  	(DDR_BASEADDR + (0x10000000))

#define FRAME_BUFFER_SIZE0      0x2000000    //0x2000000 for max 4KW RGB888 8bpc
//#define FRAME_BUFFER_SIZE1      0x600000    //0x600000 for max 1080p RGB888 8bpc

#define FRAME_BUFFER_1          FRAME_BUFFER_BASE_ADDR
#define FRAME_BUFFER_2          FRAME_BUFFER_BASE_ADDR + FRAME_BUFFER_SIZE0
#define FRAME_BUFFER_3          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*2)
#define FRAME_BUFFER_4          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*3)
#define FRAME_BUFFER_5          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*4)
#define FRAME_BUFFER_6          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*5)
#define FRAME_BUFFER_7          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*6)
#define FRAME_BUFFER_8          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*7)
#define FRAME_BUFFER_9          FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*8)
#define FRAME_BUFFER_10         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*9)
#define FRAME_BUFFER_11         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*10)
#define FRAME_BUFFER_12         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*11)
#define FRAME_BUFFER_13         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*12)
#define FRAME_BUFFER_14         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*13)
#define FRAME_BUFFER_15         FRAME_BUFFER_BASE_ADDR + (FRAME_BUFFER_SIZE0*14)
extern u8 current_ch;

XAxiVdma Vdma0;
//XAxiVdma Vdma1;
//XAxiVdma Vdma2;

u32 vdma_init(u16 DeviceID,XAxiVdma *Vdma)
{
	XAxiVdma_Config *Config;
	int Status;

	Config = XAxiVdma_LookupConfig(DeviceID);
	if (NULL == Config) {
		xil_printf("XAxiVdma_LookupConfig failure\r\n");
		return XST_FAILURE;
	}

	Status = XAxiVdma_CfgInitialize(Vdma, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		xil_printf("XAxiVdma_CfgInitialize failure\r\n");
		return XST_FAILURE;
	}
}

u32 vdma_version(XAxiVdma *Vdma) {
	return XAxiVdma_GetVersion(Vdma);
}

int vdma_read_start(XAxiVdma *Vdma) {
	int Status;

	// MM2S Startup
	Status = XAxiVdma_DmaStart(Vdma, XAXIVDMA_READ);
	if (Status != XST_SUCCESS)
	{
	   xil_printf("Start read transfer failed %d\n\r", Status);
	   return XST_FAILURE;
	}

	return XST_SUCCESS;
}


int vdma_read_stop(XAxiVdma *Vdma) {
	XAxiVdma_DmaStop(Vdma, XAXIVDMA_READ);
	return XST_SUCCESS;
}


int vdma_read_init(short DeviceID,short HoriSizeInput,short VertSizeInput,short Stride,unsigned int FrameStoreStartAddr)
{
	XAxiVdma Vdma;
	XAxiVdma_Config *Config;
	XAxiVdma_DmaSetup ReadCfg;
	int Status;


	Config = XAxiVdma_LookupConfig(DeviceID);
	if (NULL == Config) {
		xil_printf("XAxiVdma_LookupConfig failure\r\n");
		return XST_FAILURE;
	}

	Status = XAxiVdma_CfgInitialize(&Vdma, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		xil_printf("XAxiVdma_CfgInitialize failure\r\n");
		return XST_FAILURE;
	}

	

	ReadCfg.EnableCircularBuf = 1;
	ReadCfg.EnableFrameCounter = 0;
	ReadCfg.FixedFrameStoreAddr = 0;

	ReadCfg.EnableSync = 1;
	ReadCfg.PointNum = 1;

	ReadCfg.FrameDelay = 0;

	ReadCfg.VertSizeInput = VertSizeInput;
	ReadCfg.HoriSizeInput = HoriSizeInput;
	ReadCfg.Stride = Stride;

	Status = XAxiVdma_DmaConfig(&Vdma, XAXIVDMA_READ, &ReadCfg);
	if (Status != XST_SUCCESS) {
			xdbg_printf(XDBG_DEBUG_ERROR,
				"Read channel config failed %d\r\n", Status);

			return XST_FAILURE;
	}


	ReadCfg.FrameStoreStartAddr[0] = FrameStoreStartAddr;

	Status = XAxiVdma_DmaSetBufferAddr(&Vdma, XAXIVDMA_READ, ReadCfg.FrameStoreStartAddr);
	if (Status != XST_SUCCESS) {
			xdbg_printf(XDBG_DEBUG_ERROR,"Read channel set buffer address failed %d\r\n", Status);
			return XST_FAILURE;
	}


	Status = vdma_read_start(&Vdma);
	if (Status != XST_SUCCESS) {
		   xil_printf("error starting VDMA..!");
		   return Status;
	}
	return XST_SUCCESS;

}


int vdma_write_start(XAxiVdma *Vdma) {
	int Status;

	// MM2S Startup
	Status = XAxiVdma_DmaStart(Vdma, XAXIVDMA_WRITE);
	if (Status != XST_SUCCESS)
	{
	   xil_printf("Start write transfer failed %d\n\r", Status);
	   return XST_FAILURE;
	}

	return XST_SUCCESS;
}


int vdma_write_stop(XAxiVdma *Vdma) {
	XAxiVdma_DmaStop(Vdma, XAXIVDMA_WRITE);
	return XST_SUCCESS;
}


int vdma_write_init(short DeviceID,short HoriSizeInput,short VertSizeInput,short Stride,unsigned int FrameStoreStartAddr)
{
	XAxiVdma Vdma;
	XAxiVdma_Config *Config;
	XAxiVdma_DmaSetup WriteCfg;
	int Status;


	Config = XAxiVdma_LookupConfig(DeviceID);
	if (NULL == Config) {
		xil_printf("XAxiVdma_LookupConfig failure\r\n");
		return XST_FAILURE;
	}

	Status = XAxiVdma_CfgInitialize(&Vdma, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		xil_printf("XAxiVdma_CfgInitialize failure\r\n");
		return XST_FAILURE;
	}

	

	WriteCfg.EnableCircularBuf = 0;
	WriteCfg.EnableFrameCounter = 0;
	WriteCfg.FixedFrameStoreAddr = 0;

	WriteCfg.EnableSync = 1;
	WriteCfg.PointNum = 1;

	WriteCfg.FrameDelay = 0;

	WriteCfg.VertSizeInput = VertSizeInput;
	WriteCfg.HoriSizeInput = HoriSizeInput;
	WriteCfg.Stride = Stride;

	Status = XAxiVdma_DmaConfig(&Vdma, XAXIVDMA_WRITE, &WriteCfg);
	if (Status != XST_SUCCESS) {
			xdbg_printf(XDBG_DEBUG_ERROR,
				"Read channel config failed %d\r\n", Status);

			return XST_FAILURE;
	}


	WriteCfg.FrameStoreStartAddr[0] = FrameStoreStartAddr;

	Status = XAxiVdma_DmaSetBufferAddr(&Vdma, XAXIVDMA_WRITE, WriteCfg.FrameStoreStartAddr);
	if (Status != XST_SUCCESS) {
			xdbg_printf(XDBG_DEBUG_ERROR,"Write channel set buffer address failed %d\r\n", Status);
			return XST_FAILURE;
	}


	Status = vdma_write_start(&Vdma);
	if (Status != XST_SUCCESS) {
		   xil_printf("error starting VDMA..!");
		   return Status;
	}
	return XST_SUCCESS;

}

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 1U)
void vdma_config_0(void)
{
	 /* Start of VDMA Configuration */
	u32 bytePerPixels = 3;
	u32 VDMA_BASE_ADDR = XPAR_AXIVDMA_0_BASEADDR;
	int offset0 = 0; // (y*w+x)*Bpp
	int offset1 = 0; // (y*w+x)*Bpp
	u32 stride0 = 0;
	u32 width0 = 0;
	u32 height0 = 0;
	u32 stride1 = 0;  // crop keeps write Stride
	u32 width1 = 0;
	u32 height1 = 0;

#if (defined R1080P60)
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 1920;
	width0 = 1920;
	height0 = 1080;
	stride1 = 1920;  // crop keeps write Stride
	width1 = 1920;
	height1 = 1080;
#elif (defined R4K30W)
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 3840;
	width0 = 3840;
	height0 = 2160;
	stride1 = 3840;  // crop keeps write Stride
	width1 = 3840;
	height1 = 2160;
#else
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 3840;
	width0 = 3840;
	height0 = 2160;
	stride1 = 3840;  // crop keeps write Stride
	width1 = 3840;
	height1 = 2160;
#endif


#if 1
    /* Configure the Write interface (S2MM)*/
    // S2MM Control Register
    Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8B);
    //S2MM Start Address 1
    Xil_Out32(VDMA_BASE_ADDR + 0xAC, FRAME_BUFFER_1 + offset0);
    //S2MM Start Address 2
    Xil_Out32(VDMA_BASE_ADDR + 0xB0, FRAME_BUFFER_2 + offset0);
    //S2MM Start Address 3
    Xil_Out32(VDMA_BASE_ADDR + 0xB4, FRAME_BUFFER_3 + offset0);
    //S2MM Frame delay / Stride register
    Xil_Out32(VDMA_BASE_ADDR + 0xA8, stride0*bytePerPixels);
    // S2MM HSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0xA4, width0*bytePerPixels);
    // S2MM VSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0xA0, height0);

//    /* Configure the Read interface (MM2S)*/
//    // MM2S Control Register
//    Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8B);
//    // MM2S Start Address 1
//    Xil_Out32(VDMA_BASE_ADDR + 0x5C, FRAME_BUFFER_1 + offset1);
//    // MM2S Start Address 2
//    Xil_Out32(VDMA_BASE_ADDR + 0x60, FRAME_BUFFER_2 + offset1);
//    // MM2S Start Address 3
//    Xil_Out32(VDMA_BASE_ADDR + 0x64, FRAME_BUFFER_3 + offset1);
//    // MM2S Frame delay / Stride register
//    Xil_Out32(VDMA_BASE_ADDR + 0x58, stride1*bytePerPixels);
//    // MM2S HSIZE register
//    Xil_Out32(VDMA_BASE_ADDR + 0x54, width1*bytePerPixels);
//    // MM2S VSIZE register
//    Xil_Out32(VDMA_BASE_ADDR + 0x50, height1);


    /* End of VDMA Configuration */

#else
    /* Configure the Write interface (S2MM)*/
	// S2MM Control Register
	Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8B);
	//S2MM Start Address 1
	Xil_Out32(VDMA_BASE_ADDR + 0xAC, FRAME_BUFFER_1 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xB0, 0);
	//S2MM Start Address 2
	Xil_Out32(VDMA_BASE_ADDR + 0xB4, FRAME_BUFFER_2 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xB8, 0);
	//S2MM Start Address 3
	Xil_Out32(VDMA_BASE_ADDR + 0xBC, FRAME_BUFFER_3 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xC0, 0);
	//S2MM Frame delay / Stride register
	Xil_Out32(VDMA_BASE_ADDR + 0xA8, stride0*bytePerPixels);
	// S2MM HSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0xA4, width0*bytePerPixels);
	// S2MM VSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0xA0, height0);

	/* Configure the Read interface (MM2S)*/
	// MM2S Control Register
	Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8B);
	// MM2S Start Address 1
	Xil_Out32(VDMA_BASE_ADDR + 0x5C, FRAME_BUFFER_1 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x60, 0);
	// MM2S Start Address 2
	Xil_Out32(VDMA_BASE_ADDR + 0x64, FRAME_BUFFER_2 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x68, 0);
	// MM2S Start Address 3
	Xil_Out32(VDMA_BASE_ADDR + 0x6C, FRAME_BUFFER_3 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x70, 0);
	// MM2S Frame delay / Stride register
	Xil_Out32(VDMA_BASE_ADDR + 0x58, stride1*bytePerPixels);
	// MM2S HSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0x54, width1*bytePerPixels);
	// MM2S VSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0x50, height1);


	/* End of VDMA Configuration */

#endif

    xil_printf("VDMA_0 started!\r\n");
}
#endif

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 2U)
void vdma_config_1(void)
{
	 /* Start of VDMA Configuration */
	u32 bytePerPixels = 3;
	u32 VDMA_BASE_ADDR = XPAR_AXIVDMA_1_BASEADDR;
	int offset0 = 0; // (y*w+x)*Bpp
	int offset1 = 0; // (y*w+x)*Bpp
	u32 stride0 = 0;
	u32 width0 = 0;
	u32 height0 = 0;
	u32 stride1 = 0;  // crop keeps write Stride
	u32 width1 = 0;
	u32 height1 = 0;

#if (defined R1080P60)
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 1920;
	width0 = 1920;
	height0 = 1080;
	stride1 = 1920;  // crop keeps write Stride
	width1 = 1920;
	height1 = 1080;
#elif (defined R4K30W)
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 3840;
	width0 = 3840;
	height0 = 2160;
	stride1 = 3840;  // crop keeps write Stride
	width1 = 3840;
	height1 = 2160;
#else
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 3840;
	width0 = 3840;
	height0 = 2160;
	stride1 = 3840;  // crop keeps write Stride
	width1 = 3840;
	height1 = 2160;
#endif


#if 1
    /* Configure the Write interface (S2MM)*/
    // S2MM Control Register
    Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8B);
    //S2MM Start Address 1
    Xil_Out32(VDMA_BASE_ADDR + 0xAC, FRAME_BUFFER_4 + offset0);
    //S2MM Start Address 2
    Xil_Out32(VDMA_BASE_ADDR + 0xB0, FRAME_BUFFER_5 + offset0);
    //S2MM Start Address 3
    Xil_Out32(VDMA_BASE_ADDR + 0xB4, FRAME_BUFFER_6 + offset0);
    //S2MM Frame delay / Stride register
    Xil_Out32(VDMA_BASE_ADDR + 0xA8, stride0*bytePerPixels);
    // S2MM HSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0xA4, width0*bytePerPixels);
    // S2MM VSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0xA0, height0);

    /* Configure the Read interface (MM2S)*/
    // MM2S Control Register
    Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8B);
    // MM2S Start Address 1
    Xil_Out32(VDMA_BASE_ADDR + 0x5C, FRAME_BUFFER_4 + offset1);
    // MM2S Start Address 2
    Xil_Out32(VDMA_BASE_ADDR + 0x60, FRAME_BUFFER_5 + offset1);
    // MM2S Start Address 3
    Xil_Out32(VDMA_BASE_ADDR + 0x64, FRAME_BUFFER_6 + offset1);
    // MM2S Frame delay / Stride register
    Xil_Out32(VDMA_BASE_ADDR + 0x58, stride1*bytePerPixels);
    // MM2S HSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0x54, width1*bytePerPixels);
    // MM2S VSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0x50, height1);


    /* End of VDMA Configuration */

#else
    /* Configure the Write interface (S2MM)*/
	// S2MM Control Register
	Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8B);
	//S2MM Start Address 1
	Xil_Out32(VDMA_BASE_ADDR + 0xAC, FRAME_BUFFER_4 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xB0, 0);
	//S2MM Start Address 2
	Xil_Out32(VDMA_BASE_ADDR + 0xB4, FRAME_BUFFER_5 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xB8, 0);
	//S2MM Start Address 3
	Xil_Out32(VDMA_BASE_ADDR + 0xBC, FRAME_BUFFER_6 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xC0, 0);
	//S2MM Frame delay / Stride register
	Xil_Out32(VDMA_BASE_ADDR + 0xA8, stride0*bytePerPixels);
	// S2MM HSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0xA4, width0*bytePerPixels);
	// S2MM VSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0xA0, height0);

	/* Configure the Read interface (MM2S)*/
	// MM2S Control Register
	Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8B);
	// MM2S Start Address 1
	Xil_Out32(VDMA_BASE_ADDR + 0x5C, FRAME_BUFFER_4 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x60, 0);
	// MM2S Start Address 2
	Xil_Out32(VDMA_BASE_ADDR + 0x64, FRAME_BUFFER_5 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x68, 0);
	// MM2S Start Address 3
	Xil_Out32(VDMA_BASE_ADDR + 0x6C, FRAME_BUFFER_6 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x70, 0);
	// MM2S Frame delay / Stride register
	Xil_Out32(VDMA_BASE_ADDR + 0x58, stride1*bytePerPixels);
	// MM2S HSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0x54, width1*bytePerPixels);
	// MM2S VSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0x50, height1);


	/* End of VDMA Configuration */

#endif
	xil_printf("VDMA_1 started!\r\n");
}
#endif

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 3U)
void vdma_config_2(void)
{
	 /* Start of VDMA Configuration */
	u32 bytePerPixels = 3;
	u32 VDMA_BASE_ADDR = VDMA_BASE_ADDR;
	int offset0 = 0; // (y*w+x)*Bpp
	int offset1 = 0; // (y*w+x)*Bpp
	u32 stride0 = 0;
	u32 width0 = 0;
	u32 height0 = 0;
	u32 stride1 = 0;  // crop keeps write Stride
	u32 width1 = 0;
	u32 height1 = 0;

#if (defined R1080P60)
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 1920;
	width0 = 1920;
	height0 = 1080;
	stride1 = 1920;  // crop keeps write Stride
	width1 = 1920;
	height1 = 1080;
#elif (defined R4K30W)
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 3840;
	width0 = 3840;
	height0 = 2160;
	stride1 = 3840;  // crop keeps write Stride
	width1 = 3840;
	height1 = 2160;
#else
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 3840;
	width0 = 3840;
	height0 = 2160;
	stride1 = 3840;  // crop keeps write Stride
	width1 = 3840;
	height1 = 2160;
#endif


#if 0
    /* Configure the Write interface (S2MM)*/
    // S2MM Control Register
    Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8B);
    //S2MM Start Address 1
    Xil_Out32(VDMA_BASE_ADDR + 0xAC, FRAME_BUFFER_7 + offset0);
    //S2MM Start Address 2
    Xil_Out32(VDMA_BASE_ADDR + 0xB0, FRAME_BUFFER_8 + offset0);
    //S2MM Start Address 3
    Xil_Out32(VDMA_BASE_ADDR + 0xB4, FRAME_BUFFER_9 + offset0);
    //S2MM Frame delay / Stride register
    Xil_Out32(VDMA_BASE_ADDR + 0xA8, stride0*bytePerPixels);
    // S2MM HSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0xA4, width0*bytePerPixels);
    // S2MM VSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0xA0, height0);

    /* Configure the Read interface (MM2S)*/
    // MM2S Control Register
    Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8B);
    // MM2S Start Address 1
    Xil_Out32(VDMA_BASE_ADDR + 0x5C, FRAME_BUFFER_7 + offset1);
    // MM2S Start Address 2
    Xil_Out32(VDMA_BASE_ADDR + 0x60, FRAME_BUFFER_8 + offset1);
    // MM2S Start Address 3
    Xil_Out32(VDMA_BASE_ADDR + 0x64, FRAME_BUFFER_9 + offset1);
    // MM2S Frame delay / Stride register
    Xil_Out32(VDMA_BASE_ADDR + 0x58, stride1*bytePerPixels);
    // MM2S HSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0x54, width1*bytePerPixels);
    // MM2S VSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0x50, height1);


    /* End of VDMA Configuration */

#else
    /* Configure the Write interface (S2MM)*/
	// S2MM Control Register
	Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8B);
	//S2MM Start Address 1
	Xil_Out32(VDMA_BASE_ADDR + 0xAC, FRAME_BUFFER_7 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xB0, 0);
	//S2MM Start Address 2
	Xil_Out32(VDMA_BASE_ADDR + 0xB4, FRAME_BUFFER_8 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xB8, 0);
	//S2MM Start Address 3
	Xil_Out32(VDMA_BASE_ADDR + 0xBC, FRAME_BUFFER_9 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xC0, 0);
	//S2MM Frame delay / Stride register
	Xil_Out32(VDMA_BASE_ADDR + 0xA8, stride0*bytePerPixels);
	// S2MM HSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0xA4, width0*bytePerPixels);
	// S2MM VSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0xA0, height0);

	/* Configure the Read interface (MM2S)*/
	// MM2S Control Register
	Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8B);
	// MM2S Start Address 1
	Xil_Out32(VDMA_BASE_ADDR + 0x5C, FRAME_BUFFER_7 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x60, 0);
	// MM2S Start Address 2
	Xil_Out32(VDMA_BASE_ADDR + 0x64, FRAME_BUFFER_8 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x68, 0);
	// MM2S Start Address 3
	Xil_Out32(VDMA_BASE_ADDR + 0x6C, FRAME_BUFFER_9 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x70, 0);
	// MM2S Frame delay / Stride register
	Xil_Out32(VDMA_BASE_ADDR + 0x58, stride1*bytePerPixels);
	// MM2S HSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0x54, width1*bytePerPixels);
	// MM2S VSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0x50, height1);


	/* End of VDMA Configuration */

#endif
	xil_printf("VDMA_2 started!\r\n");
}
#endif

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 4U)
void vdma_config_3(void)
{
	 /* Start of VDMA Configuration */
	u32 bytePerPixels = 3;
	u32 VDMA_BASE_ADDR = VDMA_BASE_ADDR;
	int offset0 = 0; // (y*w+x)*Bpp
	int offset1 = 0; // (y*w+x)*Bpp
	u32 stride0 = 0;
	u32 width0 = 0;
	u32 height0 = 0;
	u32 stride1 = 0;  // crop keeps write Stride
	u32 width1 = 0;
	u32 height1 = 0;

#if (defined R1080P60)
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 1920;
	width0 = 1920;
	height0 = 1080;
	stride1 = 1920;  // crop keeps write Stride
	width1 = 1920;
	height1 = 1080;
#elif (defined R4K30W)
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 3840;
	width0 = 3840;
	height0 = 2160;
	stride1 = 3840;  // crop keeps write Stride
	width1 = 3840;
	height1 = 2160;
#else
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 3840;
	width0 = 3840;
	height0 = 2160;
	stride1 = 3840;  // crop keeps write Stride
	width1 = 3840;
	height1 = 2160;
#endif


#if 0
    /* Configure the Write interface (S2MM)*/
    // S2MM Control Register
    Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8B);
    //S2MM Start Address 1
    Xil_Out32(VDMA_BASE_ADDR + 0xAC, FRAME_BUFFER_10 + offset0);
    //S2MM Start Address 2
    Xil_Out32(VDMA_BASE_ADDR + 0xB0, FRAME_BUFFER_11 + offset0);
    //S2MM Start Address 3
    Xil_Out32(VDMA_BASE_ADDR + 0xB4, FRAME_BUFFER_12 + offset0);
    //S2MM Frame delay / Stride register
    Xil_Out32(VDMA_BASE_ADDR + 0xA8, stride0*bytePerPixels);
    // S2MM HSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0xA4, width0*bytePerPixels);
    // S2MM VSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0xA0, height0);

    /* Configure the Read interface (MM2S)*/
    // MM2S Control Register
    Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8B);
    // MM2S Start Address 1
    Xil_Out32(VDMA_BASE_ADDR + 0x5C, FRAME_BUFFER_10 + offset1);
    // MM2S Start Address 2
    Xil_Out32(VDMA_BASE_ADDR + 0x60, FRAME_BUFFER_11 + offset1);
    // MM2S Start Address 3
    Xil_Out32(VDMA_BASE_ADDR + 0x64, FRAME_BUFFER_12 + offset1);
    // MM2S Frame delay / Stride register
    Xil_Out32(VDMA_BASE_ADDR + 0x58, stride1*bytePerPixels);
    // MM2S HSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0x54, width1*bytePerPixels);
    // MM2S VSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0x50, height1);


    /* End of VDMA Configuration */

#else
    /* Configure the Write interface (S2MM)*/
	// S2MM Control Register
	Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8B);
	//S2MM Start Address 1
	Xil_Out32(VDMA_BASE_ADDR + 0xAC, FRAME_BUFFER_10 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xB0, 0);
	//S2MM Start Address 2
	Xil_Out32(VDMA_BASE_ADDR + 0xB4, FRAME_BUFFER_11 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xB8, 0);
	//S2MM Start Address 3
	Xil_Out32(VDMA_BASE_ADDR + 0xBC, FRAME_BUFFER_12 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xC0, 0);
	//S2MM Frame delay / Stride register
	Xil_Out32(VDMA_BASE_ADDR + 0xA8, stride0*bytePerPixels);
	// S2MM HSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0xA4, width0*bytePerPixels);
	// S2MM VSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0xA0, height0);

	/* Configure the Read interface (MM2S)*/
	// MM2S Control Register
	Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8B);
	// MM2S Start Address 1
	Xil_Out32(VDMA_BASE_ADDR + 0x5C, FRAME_BUFFER_10 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x60, 0);
	// MM2S Start Address 2
	Xil_Out32(VDMA_BASE_ADDR + 0x64, FRAME_BUFFER_11 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x68, 0);
	// MM2S Start Address 3
	Xil_Out32(VDMA_BASE_ADDR + 0x6C, FRAME_BUFFER_12 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x70, 0);
	// MM2S Frame delay / Stride register
	Xil_Out32(VDMA_BASE_ADDR + 0x58, stride1*bytePerPixels);
	// MM2S HSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0x54, width1*bytePerPixels);
	// MM2S VSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0x50, height1);


	/* End of VDMA Configuration */

#endif
	xil_printf("VDMA_3 started!\r\n");
}
#endif

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 5U)
void vdma_config_4(void)
{
	 /* Start of VDMA Configuration */
	u32 bytePerPixels = 3;
	u32 VDMA_BASE_ADDR = XPAR_AXI_VDMA_4_BASEADDR;
	int offset0 = 0; // (y*w+x)*Bpp
	int offset1 = 0; // (y*w+x)*Bpp
	u32 stride0 = 0;
	u32 width0 = 0;
	u32 height0 = 0;
	u32 stride1 = 0;  // crop keeps write Stride
	u32 width1 = 0;
	u32 height1 = 0;

#if (defined R1080P60)
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 1920;
	width0 = 1920;
	height0 = 1080;
	stride1 = 1920;  // crop keeps write Stride
	width1 = 1920;
	height1 = 1080;
#elif (defined R4K30W)
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 3840;
	width0 = 3840;
	height0 = 2160;
	stride1 = 3840;  // crop keeps write Stride
	width1 = 3840;
	height1 = 2160;
#else
	offset0 = 0; // (y*w+x)*Bpp
	offset1 = 0; // (y*w+x)*Bpp
	stride0 = 3840;
	width0 = 3840;
	height0 = 2160;
	stride1 = 3840;  // crop keeps write Stride
	width1 = 3840;
	height1 = 2160;
#endif


#if 1
    /* Configure the Write interface (S2MM)*/
    // S2MM Control Register
    Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8B);
    //S2MM Start Address 1
    Xil_Out32(VDMA_BASE_ADDR + 0xAC, FRAME_BUFFER_13 + offset0);
    //S2MM Start Address 2
    Xil_Out32(VDMA_BASE_ADDR + 0xB0, FRAME_BUFFER_14 + offset0);
    //S2MM Start Address 3
    Xil_Out32(VDMA_BASE_ADDR + 0xB4, FRAME_BUFFER_15 + offset0);
    //S2MM Frame delay / Stride register
    Xil_Out32(VDMA_BASE_ADDR + 0xA8, stride0*bytePerPixels);
    // S2MM HSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0xA4, width0*bytePerPixels);
    // S2MM VSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0xA0, height0);

    /* Configure the Read interface (MM2S)*/
    // MM2S Control Register
    Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8B);
    // MM2S Start Address 1
    Xil_Out32(VDMA_BASE_ADDR + 0x5C, FRAME_BUFFER_13 + offset1);
    // MM2S Start Address 2
    Xil_Out32(VDMA_BASE_ADDR + 0x60, FRAME_BUFFER_14 + offset1);
    // MM2S Start Address 3
    Xil_Out32(VDMA_BASE_ADDR + 0x64, FRAME_BUFFER_15 + offset1);
    // MM2S Frame delay / Stride register
    Xil_Out32(VDMA_BASE_ADDR + 0x58, stride1*bytePerPixels);
    // MM2S HSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0x54, width1*bytePerPixels);
    // MM2S VSIZE register
    Xil_Out32(VDMA_BASE_ADDR + 0x50, height1);


    /* End of VDMA Configuration */

#else
    /* Configure the Write interface (S2MM)*/
	// S2MM Control Register
	Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8B);
	//S2MM Start Address 1
	Xil_Out32(VDMA_BASE_ADDR + 0xAC, FRAME_BUFFER_13 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xB0, 0);
	//S2MM Start Address 2
	Xil_Out32(VDMA_BASE_ADDR + 0xB4, FRAME_BUFFER_14 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xB8, 0);
	//S2MM Start Address 3
	Xil_Out32(VDMA_BASE_ADDR + 0xBC, FRAME_BUFFER_15 + offset0);
	Xil_Out32(VDMA_BASE_ADDR + 0xC0, 0);
	//S2MM Frame delay / Stride register
	Xil_Out32(VDMA_BASE_ADDR + 0xA8, stride0*bytePerPixels);
	// S2MM HSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0xA4, width0*bytePerPixels);
	// S2MM VSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0xA0, height0);

	/* Configure the Read interface (MM2S)*/
	// MM2S Control Register
	Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8B);
	// MM2S Start Address 1
	Xil_Out32(VDMA_BASE_ADDR + 0x5C, FRAME_BUFFER_13 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x60, 0);
	// MM2S Start Address 2
	Xil_Out32(VDMA_BASE_ADDR + 0x64, FRAME_BUFFER_14 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x68, 0);
	// MM2S Start Address 3
	Xil_Out32(VDMA_BASE_ADDR + 0x6C, FRAME_BUFFER_15 + offset1);
	Xil_Out32(VDMA_BASE_ADDR + 0x70, 0);
	// MM2S Frame delay / Stride register
	Xil_Out32(VDMA_BASE_ADDR + 0x58, stride1*bytePerPixels);
	// MM2S HSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0x54, width1*bytePerPixels);
	// MM2S VSIZE register
	Xil_Out32(VDMA_BASE_ADDR + 0x50, height1);


	/* End of VDMA Configuration */

#endif
	xil_printf("VDMA_4 started!\r\n");
}
#endif



void vdma_config(void)
{
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 1U)
	vdma_config_0();
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 2U)
	vdma_config_1();
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 3U)
	vdma_config_2();
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 4U)
	vdma_config_3();
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 5U)
	vdma_config_4();
#endif
}

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 1U)
void clear_vdma_0(void)
{
	u32 bytePerPixels = 3;
	u32 VDMA_BASE_ADDR = XPAR_AXIVDMA_0_BASEADDR;
	u32 line = 0;
	u32 column = 0;

#if (defined R1080P60)
	line = 1920;
	column = 1080;
#elif (defined R4K30W)
	line = 3840;
	column = 2160;
#else
	line = 3840;
	column = 2160;
#endif

    Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8A);//stop mm2s
	Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8A);//stop s2mm

	Xil_DCacheDisable();
    memset(FRAME_BUFFER_1,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_2,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_3,0xff,line*column*bytePerPixels);//background
	Xil_DCacheEnable();

	xil_printf("clear vdma_0 Done\n\r");
	vdma_config_0();
}
#endif

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 2U)
void clear_vdma_1(void)
{
	u32 bytePerPixels = 3;
	u32 VDMA_BASE_ADDR = XPAR_AXIVDMA_1_BASEADDR;
	u32 line = 0;
	u32 column = 0;

#if (defined R1080P60)
	line = 1920;
	column = 1080;
#elif (defined R4K30W)
	line = 3840;
	column = 2160;
#else
	line = 3840;
	column = 2160;
#endif

    Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8A);//stop mm2s
	Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8A);//stop s2mm

	Xil_DCacheDisable();
    memset(FRAME_BUFFER_4,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_5,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_6,0xff,line*column*bytePerPixels);//background
	Xil_DCacheEnable();

	xil_printf("clear vdma_1 Done\n\r");
	vdma_config_1();
}
#endif

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 3U)
void clear_vdma_2(void)
{
	u32 bytePerPixels = 3;
	u32 VDMA_BASE_ADDR = VDMA_BASE_ADDR;
	u32 line = 0;
	u32 column = 0;

#if (defined R1080P60)
	line = 1920;
	column = 1080;
#elif (defined R4K30W)
	line = 3840;
	column = 2160;
#else
	line = 1920;
	column = 1280;
#endif

    Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8A);//stop mm2s
	Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8A);//stop s2mm

	Xil_DCacheDisable();
    memset(FRAME_BUFFER_7,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_8,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_9,0xff,line*column*bytePerPixels);//background
	Xil_DCacheEnable();

	xil_printf("clear vdma_2 Done\n\r");
//	vdma_config_2();

}
#endif

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 4U)
void clear_vdma_3(void)
{
	u32 bytePerPixels = 3;
	u32 VDMA_BASE_ADDR = VDMA_BASE_ADDR;
	u32 line = 0;
	u32 column = 0;

#if (defined R1080P60)
	line = 1920;
	column = 1080;
#elif (defined R4K30W)
	line = 3840;
	column = 2160;
#else
	line = 1920;
	column = 1280;
#endif

	u32 i=0,j=0;
    UINTPTR Addr1=FRAME_BUFFER_1,Addr2=FRAME_BUFFER_2,Addr3=FRAME_BUFFER_3;
    UINTPTR Addr4=FRAME_BUFFER_4,Addr5=FRAME_BUFFER_5,Addr6=FRAME_BUFFER_6;
    UINTPTR Addr7=FRAME_BUFFER_7,Addr8=FRAME_BUFFER_8,Addr9=FRAME_BUFFER_9;
    UINTPTR Addr10=FRAME_BUFFER_10,Addr11=FRAME_BUFFER_11,Addr12=FRAME_BUFFER_12;

    Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8A);//stop mm2s
	Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8A);//stop s2mm

	Xil_DCacheDisable();

#if 0
	for(i=0; i < column; i++)
	{
		for(j=0; j < line*bytePerPixels/8; j++)
		{
			Xil_Out64(Addr10, 0xFFFFFFFFFFFFFFFF);
			Xil_Out64(Addr11, 0xFFFFFFFFFFFFFFFF);
			Xil_Out64(Addr12, 0xFFFFFFFFFFFFFFFF);

			Addr10+=8;
			Addr11+=8;
			Addr12+=8;

		}
	}
#else
    memset(FRAME_BUFFER_10,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_11,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_12,0xff,line*column*bytePerPixels);//background

#endif
    Xil_DCacheEnable();
    xil_printf("clear vdma_3 Done\n\r");
}
#endif

#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 5U)
void clear_vdma_4(void)
{
	u32 bytePerPixels = 3;
	u32 VDMA_BASE_ADDR = XPAR_AXIVDMA_4_BASEADDR;
	u32 line = 0;
	u32 column = 0;

#if (defined R1080P60)
	line = 1920;
	column = 1080;
#elif (defined R4K30W)
	line = 3840;
	column = 2160;
#else
	line = 1920;
	column = 1280;
#endif

	u32 i=0,j=0;
    UINTPTR Addr1=FRAME_BUFFER_1,Addr2=FRAME_BUFFER_2,Addr3=FRAME_BUFFER_3;
    UINTPTR Addr4=FRAME_BUFFER_4,Addr5=FRAME_BUFFER_5,Addr6=FRAME_BUFFER_6;
    UINTPTR Addr7=FRAME_BUFFER_7,Addr8=FRAME_BUFFER_8,Addr9=FRAME_BUFFER_9;
    UINTPTR Addr10=FRAME_BUFFER_10,Addr11=FRAME_BUFFER_11,Addr12=FRAME_BUFFER_12;
    UINTPTR Addr13=FRAME_BUFFER_13,Addr14=FRAME_BUFFER_14,Addr15=FRAME_BUFFER_15;

    Xil_Out32(VDMA_BASE_ADDR + 0x00, 0x8A);//stop mm2s
	Xil_Out32(VDMA_BASE_ADDR + 0x30, 0x8A);//stop s2mm

	Xil_DCacheDisable();

#if 0
	for(i=0; i < column; i++)
	{
		for(j=0; j < line*bytePerPixels/8; j++)
		{
			Xil_Out64(Addr10, 0xFFFFFFFFFFFFFFFF);
			Xil_Out64(Addr11, 0xFFFFFFFFFFFFFFFF);
			Xil_Out64(Addr12, 0xFFFFFFFFFFFFFFFF);

			Addr10+=8;
			Addr11+=8;
			Addr12+=8;

		}
	}
#else
    memset(FRAME_BUFFER_13,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_14,0xff,line*column*bytePerPixels);//background
    memset(FRAME_BUFFER_15,0xff,line*column*bytePerPixels);//background

#endif
    Xil_DCacheEnable();
    xil_printf("clear vdma_4 Done\n\r");
}

#endif

void clear_display(void)
{
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 1U)
	clear_vdma_0();
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 2U)
	clear_vdma_1();
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 3U)
	clear_vdma_2();
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 4U)
	clear_vdma_3();
#endif
#if (XPAR_XAXIVDMA_NUM_INSTANCES >= 5U)
	clear_vdma_4();
#endif

	xil_printf("clear Done\n\r");

}

#endif
