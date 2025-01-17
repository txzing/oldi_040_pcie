/*
 * serdes.c
 *
 *  Created on: 2023年4月26日
 *      Author: fengke
 */
#include "../bsp.h"

#if defined (SER_CFG) || defined (DES_CFG)

#if defined (DES_CFG)
struct reginfo max9296_rgb888_gmsl2[] =
{
	{0x90, 0x0313, 0x00},// CSI output disabled
//	{0x90, 0x0001, 0x12},//11=Remote control channel disabled\3Gbs,default 02=Remote control channel Enabled\6Gbs,
//	{0x90, 0x0010, 0x21},// Link A is selected, reset link
//	{0x90, 0x0010, 0xA1},// Link A is selected, reset link
	{0x90, SEQUENCE_WAIT_MS, 0x80},//delay for a while

#if 1
//	{0x90, 0x0001, 0x01},// 3Gbps mode
//	{0x90, 0x0010, 0x21},// Link A is selected, reset link
//	{0x90, SEQUENCE_WAIT_MS, 0x80},//delay for a while

	{ 0x90, 0x0002, 0x13 }, // use pipeline X
	{ 0x90, 0x0050, 0x02 }, // pipeline X stream ID
	{ 0x90, 0x0051, 0x00 }, // pipeline Y stream ID
	{ 0x90, 0x0052, 0x01 }, // pipeline Z stream ID
	{ 0x90, 0x0053, 0x03 }, // pipeline U stream ID

	{0x90, 0x0330, 0x04},
	{0x90, 0x0333, 0x4e},
	{0x90, 0x0334, 0xe4},
	{0x90, 0x040a, 0x00},
	{0x90, 0x044a, 0xd0},
	{0x90, 0x048a, 0xd0},
	{0x90, 0x04ca, 0x00},
//	{0x90, 0x031d, 0x2a},
//	{0x90, 0x0320, 0x2a},
//	{0x90, 0x0323, 0x2a},
//	{0x90, 0x0326, 0x2a},
//	{0x90, 0x031d, 0x25},
//	{0x90, 0x0320, 0x25},
//	{0x90, 0x0323, 0x25},
//	{0x90, 0x0326, 0x25},
	{0x90, 0x031d, 0x0a},
	{0x90, 0x0320, 0x0a},
	{0x90, 0x0323, 0x0a},
	{0x90, 0x0326, 0x0a},

	{0x90, 0x040b, 0x07},
	{0x90, 0x040c, 0x00},
	{0x90, 0x042d, 0x15},
	{0x90, 0x040d, 0x24},
	{0x90, 0x040e, 0x24},
	{0x90, 0x040f, 0x00},
	{0x90, 0x0410, 0x00},
	{0x90, 0x0411, 0x01},
	{0x90, 0x0412, 0x01},

//	{0x90, 0x044b, 0x07},
//	{0x90, 0x044c, 0x00},
//	{0x90, 0x046d, 0x15},
//	{0x90, 0x044d, 0x24},
//	{0x90, 0x044e, 0x24},
//	{0x90, 0x044f, 0x00},
//	{0x90, 0x0490, 0x00},
//	{0x90, 0x0451, 0x01},
//	{0x90, 0x0452, 0x01},
//
//	{0x90, 0x048b, 0x07},
//	{0x90, 0x048c, 0x00},
//	{0x90, 0x04ad, 0x15},
//	{0x90, 0x048d, 0x24},
//	{0x90, 0x048e, 0x24},
//	{0x90, 0x048f, 0x00},
//	{0x90, 0x0490, 0x00},
//	{0x90, 0x0491, 0x01},
//	{0x90, 0x0492, 0x01},
//
//	{0x90, 0x04cb, 0x07},
//	{0x90, 0x04cc, 0x00},
//	{0x90, 0x04ed, 0x15},
//	{0x90, 0x04cd, 0x24},
//	{0x90, 0x04ce, 0x24},
//	{0x90, 0x04cf, 0x00},
//	{0x90, 0x04D0, 0x00},
//	{0x90, 0x04D1, 0x01},
//	{0x90, 0x04D2, 0x01},

	{0x90, 0x0332, 0xF0},
	{0x90, 0x0313, 0x02},
#endif

	{0x90, SEQUENCE_END, 0x00}
};




struct reginfo max96752_oldi[] =
{
	{0x54, SEQUENCE_WAIT_MS, 0x80},
#if 0
//	{0x94, 0x0001, 0x12}, // RX_RATE:6Gbps; Enable i2c1 pass-through
	{0x94, 0x0001, 0x02}, // RX_RATE:6Gbps; disable i2c1 pass-through
//	{0x94, 0x0002, 0x43}, // Video receive pipeline enable
	{0x94, 0x0002, 0x53}, // Video receive pipeline enable; Disable remote control channel
	{0x94, 0x0040, 0x26}, // I2C-to-I2C Slave Timeout Setting 32ms; Set for I2C standard-mode speed
//	{0x94, 0x0050, 0x00}, // Receive packets with this stream ID 0x00; No CRC on received packets
	{0x94, 0x0050, 0x01}, // Receive packets with this stream ID 0x00; No CRC on received packets
	{0x94, 0x0242, 0x10}, // ?
	{0x94, 0x0458, 0x28}, // Error channel target amplitude for ones
	{0x94, 0x0459, 0x68}, // Error channel target amplitude for zeros
	{0x94, 0x043e, 0xb3}, // Error channel phase secondary (odd); Error-channel phase secondary timing adjust enabled
	{0x94, 0x043f, 0x72}, // Error channel phase primary (even); Error-channel phase primary timing adjus disabled
	{0x94, 0x0558, 0x28}, // Error channel target amplitude for ones
	{0x94, 0x0559, 0x68}, // Error channel target amplitude for zeros
	{0x94, 0x053e, 0xb3}, // Error channel phase secondary (odd); Error-channel phase secondary timing adjust enabled
	{0x94, 0x053f, 0x72}, // Error channel phase primary (even); Error-channel phase primary timing adjus disabled
//	{0x94, 0x0002, 0x43}, // Video receive pipeline enable
	{0x94, 0x0002, 0x53}, // Video receive pipeline enable
	{0x94, 0x0140, 0x20}, // Audio receiver disabled; Do not invert WS; Do not invert SCK; Received audio in normal mode
//	{0x94, 0x01d2, 0x44}, // Selects OLDI Port A Lane 2 output from ACLK
//	{0x94, 0x01d4, 0x22}, // Selects OLDI Port A Clock Lane output from A2
	{0x94, 0x0206, 0x03}, // GPIO2: Disables GPIO output driver; GPIO Tx source enabled for GMSL2
	{0x94, 0x0207, 0x10}, // GPIO2: GPIO transmit ID 0x10; Open-drain; No Pullup
	{0x94, 0x0208, 0x10}, // GPIO2: GPIO receive ID 0x10;
	{0x94, 0x020c, 0x03}, // GPIO4: Output driver disabled
	{0x94, 0x020d, 0x11}, // GPIO4: This GPIO source enabled for GMSL2 transmission
	{0x94, 0x020e, 0x11}, // GPIO4: This GPIO source enabled for GMSL2 reception
	{0x94, 0x0010, 0x21}, // Link A is selected; Sleep mode disabled; Reset data path
	{0x94, 0x0002, 0x03}, // Video receive pipeline disabled
	{0x94, 0x01ce, 0x5e}, // OLDI: Falling Edge; Split with DE; Splitter enabled; Ports A and B swapped; Four lanes; VESA format; Port A
	{0x94, 0x01c8, 0x38}, // Maps incoming bit 0x18 to the outgoing bit position 24; Force bit to zero before inversion
	{0x94, 0x01c9, 0x39}, // Maps incoming bit 0x19 to the outgoing bit position 25; Force bit to zero before inversion
	{0x94, 0x01ca, 0x3a}, // Maps incoming bit 0x1A to the outgoing bit position 26; Force bit to zero before inversion
//	{0x94, 0x0002, 0x43}, // Video receive pipeline enable
	{0x94, 0x0d00, 0xf4}, // ?
//	{0x94, 0x0002, 0x43}, // Video receive pipeline enable
	{0x94, 0x0002, 0x53}, // Video receive pipeline enable
	{0x94, 0x0d00, 0xf5}, // ?
	{0x94, 0x01c8, 0x18}, // Maps incoming bit 0x18 to the outgoing bit position 24;
	{0x94, 0x01c9, 0x19}, // Maps incoming bit 0x19 to the outgoing bit position 25;
	{0x94, 0x01ca, 0x1a}, // Maps incoming bit 0x1A to the outgoing bit position 26;
	{0x94, 0x01cf, 0x19}, // Enables spread spectrum OLDI output clock; OLDI not duplicated; Output VSYNC from GPIO; LVDS output driver A and B powered up
	{0x94, 0x0d03, 0x83}, // config_spread_bit_ratio 1%;
#endif
#if 1
//	{0x54, 0x0050, 0x01}, // Receive packets with this stream ID; No CRC on received packets
//	{0x54, 0x0002, 0x03}, // Video receive pipeline disabled
	{0x54, 0x0002, 0x13}, // Video receive pipeline disabled; Disable remote control channel
	{0x54, 0x0140, 0x20}, // Audio receiver disabled; Do not invert WS; Do not invert SCK; Received audio in normal mode
	{0x54, 0x01ce, 0x5e}, // OLDI: Falling Edge; Split with DE; Splitter enabled; Ports A and B swapped; Four lanes; VESA format; Port A
//	{0x54, 0x01d2, 0x44}, // Selects OLDI Port A Lane 2 output from ACLK
//	{0x54, 0x01d4, 0x22}, // Selects OLDI Port A Clock Lane output from A2
	{0x54, 0x01d2, 0x22}, // Selects OLDI Port A Lane 2 output from ACLK
	{0x54, 0x01d4, 0x44}, // Selects OLDI Port A Clock Lane output from A2
//	{0x54, 0x0002, 0x43}, // Video receive pipeline enable
	{0x54, 0x0002, 0x53}, // Video receive pipeline enable; Disable remote control channel
//	{0x54, 0x0001, 0x12}, // RX_RATE:6Gbps; Enable i2c1 pass-through
	{0x54, 0x0001, 0x02}, // RX_RATE:6Gbps; disable i2c1 pass-through
	{0x54, 0x0212, 0x10},
	{0x54, 0x0221, 0x10},
	{0x54, 0x0224, 0x10},
	{0x54, 0x0227, 0x10},
	{0x54, 0x021e, 0x04},
	{0x54, 0x021f, 0x2b},
	{0x54, 0x0220, 0x0b},
	{0x54, 0x021b, 0x04},
	{0x54, 0x021c, 0x2d},
	{0x54, 0x021d, 0x0d},
	{0x54, 0x0215, 0x23},
	{0x54, 0x0216, 0x16},
	{0x54, 0x0217, 0x16},
	{0x54, 0x0218, 0x23},
	{0x54, 0x0219, 0x18},
	{0x54, 0x021a, 0x18},
	{0x54, 0x020c, 0x23},
	{0x54, 0x020d, 0x0e},
	{0x54, 0x020e, 0x0e},
#endif
	{0x54, SEQUENCE_END, 0x00},
};

#endif // DES_CFG

#if defined (SER_CFG)
struct reginfo max96717_rgb888_gmsl2[] =
{
//	{0x80, 0x0001, 0x08},// default 0x08, 6Gbps mode
//	{0x80, 0x0001, 0x14},// 3Gbps mode
//	{0x80, 0x0010, 0x21},// reset link and registers

	{0x80, SEQUENCE_WAIT_MS, 0x80},
	{0x80, 0x0331, 0x30},//default 0x30, 4lane
//	{0x80, 0x0318, 0x5E},//mem_dt1_selz
	{0x80, 0x0318, 0x64},//mem_dt1_selz

	{0x80, SEQUENCE_END, 0x00}
};
#endif // SER_CFG

int serdes_i2c_write_8(i2c_no i2c, u8 addr, u16 reg, u8 data)
{
	int ret;
	ret = xgpio_i2c_reg8_write(i2c, addr >> 1, reg, data, STRETCH_ON);
	return ret;
}


void serdes_i2c_write_array_8(i2c_no i2c, struct reginfo *regarray)
{
	int i = 0;

	while (regarray[i].reg != SEQUENCE_END)
	{
		if(regarray[i].reg == SEQUENCE_WAIT_MS)
		{
		      usleep((regarray[i].val)*1000);
		}
		else
		{
			serdes_i2c_write_8(i2c, regarray[i].addr, regarray[i].reg, regarray[i].val);
		}
		i++;
	}
}

int serdes_i2c_write_16(i2c_no i2c, u8 addr, u16 reg, u8 data)
{
	int ret;
	ret = xgpio_i2c_reg16_write(i2c, addr >> 1, reg, data, STRETCH_ON);
	return ret;
}


void serdes_i2c_write_array_16(i2c_no i2c, struct reginfo *regarray)
{
	int i = 0;

	while (regarray[i].reg != SEQUENCE_END)
	{
		if(regarray[i].reg == SEQUENCE_WAIT_MS)
		{
		      usleep((regarray[i].val)*1000);
		}
		else
		{
			serdes_i2c_write_16(i2c, regarray[i].addr, regarray[i].reg, regarray[i].val);
		}
		i++;
	}
}


#endif // SER_CFG || DES_CFG


/*
usage:
assume you have a xgpio_i2c heir, or you can modify to use xiic or emio_i2c

ref to follows
```
#if defined (SER_CFG) || defined (DES_CFG)
    // MAX9296 config
    u8 ret8=0;
#if defined (DES_CFG)
    Status = xgpio_i2c_reg16_read(I2C_NO_3, 0x90>>1, 0x0000, &ret8, STRETCH_ON);
    Status = xgpio_i2c_reg16_read(I2C_NO_3, 0x90>>1, 0x0001, &ret8, STRETCH_ON);
#if defined (SERDES_3G)
    Status = xgpio_i2c_reg16_write(I2C_NO_3, 0x90>>1, 0x0001, 0x01, STRETCH_ON); // 3Gbps
    Status = xgpio_i2c_reg16_write(I2C_NO_3, 0x90>>1, 0x0010, 0x21, STRETCH_ON); // reset link
#else
    Status = xgpio_i2c_reg16_write(I2C_NO_3, 0x90>>1, 0x0001, 0x02, STRETCH_ON); // 6Gbps
	Status = xgpio_i2c_reg16_write(I2C_NO_3, 0x90>>1, 0x0010, 0x21, STRETCH_ON); // reset link
#endif // SERDES_3G
    max929x_write_array(I2C_NO_3, max9296_rgb888_gmsl2);
#endif // DES_CFG
#if defined (SER_CFG)
    Status = xgpio_i2c_reg16_read(I2C_NO_3, 0x80>>1, 0x0000, &ret8, STRETCH_ON);
    Status = xgpio_i2c_reg16_read(I2C_NO_3, 0x80>>1, 0x0001, &ret8, STRETCH_ON);
#if defined (SERDES_3G)
    Status = xgpio_i2c_reg16_write(I2C_NO_3, 0x80>>1, 0x0001, 0x04, STRETCH_ON); // 3Gbps
    Status = xgpio_i2c_reg16_write(I2C_NO_3, 0x80>>1, 0x0010, 0x21, STRETCH_ON); // reset link
#else
    Status = xgpio_i2c_reg16_write(I2C_NO_3, 0x80>>1, 0x0001, 0x08, STRETCH_ON); // 6Gbps
    Status = xgpio_i2c_reg16_write(I2C_NO_3, 0x80>>1, 0x0010, 0x21, STRETCH_ON); // reset link
#endif // SERDES_3G
//    max929x_write_array(I2C_NO_3, max9295_rgb888_gmsl2);
    max929x_write_array(I2C_NO_3, max96717_rgb888_gmsl2);
#endif // SER_CFG
#if defined (DES_CFG)
    Status = xgpio_i2c_reg16_read(I2C_NO_3, 0x90>>1, 0x0000, &ret8, STRETCH_ON);
	Status = xgpio_i2c_reg16_read(I2C_NO_3, 0x90>>1, 0x0001, &ret8, STRETCH_ON);
#endif // DES_CFG
#if defined (SER_CFG)
    Status = xgpio_i2c_reg16_read(I2C_NO_3, 0x80>>1, 0x0000, &ret8, STRETCH_ON);
    Status = xgpio_i2c_reg16_read(I2C_NO_3, 0x80>>1, 0x0001, &ret8, STRETCH_ON);
#endif // SER_CFG
#endif // SER_CFG || DES_CFG
```
*/
