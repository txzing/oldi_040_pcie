set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS true [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE Yes [current_design]
set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

create_clock -period 5.000 [get_ports sys_clk_p]
set_property -dict {PACKAGE_PIN AK17 IOSTANDARD DIFF_SSTL12} [get_ports sys_clk_p]

#set_property -dict {PACKAGE_PIN U7   IOSTANDARD LVCMOS33} [get_ports {qspi_flash_ss_io[0]}]
#set_property -dict {PACKAGE_PIN AC7  IOSTANDARD LVCMOS33} [get_ports {qspi_flash_io0_io}]
#set_property -dict {PACKAGE_PIN AB7  IOSTANDARD LVCMOS33} [get_ports {qspi_flash_io1_io}]
#set_property -dict {PACKAGE_PIN AA7  IOSTANDARD LVCMOS33} [get_ports {qspi_flash_io2_io}]
#set_property -dict {PACKAGE_PIN Y7   IOSTANDARD LVCMOS33} [get_ports {qspi_flash_io3_io}]

#rs232
set_property -dict {PACKAGE_PIN H26 IOSTANDARD LVCMOS33} [get_ports uart_0_rxd]
set_property -dict {PACKAGE_PIN J26 IOSTANDARD LVCMOS33} [get_ports uart_0_txd]
set_property -dict {PACKAGE_PIN G27 IOSTANDARD LVCMOS33} [get_ports uart_1_rxd]
set_property -dict {PACKAGE_PIN H27 IOSTANDARD LVCMOS33} [get_ports uart_1_txd]


##rs485
#set_property -dict {PACKAGE_PIN H27 IOSTANDARD LVCMOS33} [get_ports uart_1_rxd]
#set_property -dict {PACKAGE_PIN J26 IOSTANDARD LVCMOS33} [get_ports uart_1_txd]
##485 en
#set_property -dict {PACKAGE_PIN H26 IOSTANDARD LVCMOS33} [get_ports uart_1_txen]


## sda
set_property -dict {PACKAGE_PIN AF34 IOSTANDARD LVCMOS18} [get_ports i2c_0_sda_io]
## scl
set_property -dict {PACKAGE_PIN AE33 IOSTANDARD LVCMOS18} [get_ports i2c_0_scl_io]

## EEPROM
### sda
#set_property -dict {PACKAGE_PIN P26 IOSTANDARD LVCMOS33} [get_ports i2c_0_sda_io]
#set_property UNAVAILABLE_DURING_CALIBRATION true [get_ports i2c_0_sda_io]
### scl
#set_property -dict {PACKAGE_PIN R25 IOSTANDARD LVCMOS33} [get_ports i2c_0_scl_io]
### wp
#set_property -dict {PACKAGE_PIN R26 IOSTANDARD LVCMOS33} [get_ports {gpio_tri_io[0]}]
## 984_1_PDB(U12)
#set_property -dict {PACKAGE_PIN W34 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[1]}]
## 984_1_INTB_IN
#set_property -dict {PACKAGE_PIN V33 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[2]}]
## 984_F1_GPIO0
#set_property -dict {PACKAGE_PIN V34 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[3]}]
## 984_F1_GPIO4
#set_property -dict {PACKAGE_PIN U34 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[4]}]
## 984_2_PDB
#set_property -dict {PACKAGE_PIN W30 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[5]}]
## 984_2_INTB_IN
#set_property -dict {PACKAGE_PIN Y30 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[6]}]
## 984_F2_GPIO0
#set_property -dict {PACKAGE_PIN AB29 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[7]}]
## 984_F2_GPIO4
#set_property -dict {PACKAGE_PIN AA29 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[8]}]

## 988_1_PDB
#set_property -dict {PACKAGE_PIN AB31 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[9]}]
## 988_1_INTB_IN
#set_property -dict {PACKAGE_PIN Y33 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[10]}]
## 988_F1_GPIO4
#set_property -dict {PACKAGE_PIN W33 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[11]}]
## 988_1_DE
#set_property -dict {PACKAGE_PIN AB30 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[12]}]
## 988_1_HS
#set_property -dict {PACKAGE_PIN AD33 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[13]}]
## 988_1_VS
#set_property -dict {PACKAGE_PIN AC33 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[14]}]

## 988_2_PDB
#set_property -dict {PACKAGE_PIN AG32 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[15]}]
## 988_2_INTB_IN
#set_property -dict {PACKAGE_PIN AD30 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[16]}]
## 988_F2_GPIO4
#set_property -dict {PACKAGE_PIN AD31 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[17]}]
## 988_2_DE
#set_property -dict {PACKAGE_PIN AG31 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[18]}]
## 988_2_HS
#set_property -dict {PACKAGE_PIN AG29 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[19]}]
## 988_2_VS
#set_property -dict {PACKAGE_PIN AF29 IOSTANDARD LVCMOS18} [get_ports {gpio_tri_io[20]}]

## 141_PWD
#set_property -dict {PACKAGE_PIN K25 IOSTANDARD LVCMOS33} [get_ports {gpio_tri_io[21]}]

### PL_LOCK_LED
##set_property -dict {PACKAGE_PIN G27 IOSTANDARD LVCMOS33} [get_ports c0_init_calib_complete]


#-----------------------------------DDR4--------------------

set_property PACKAGE_PIN AG21 [get_ports {C0_DDR4_dqs_t[0]}]
set_property PACKAGE_PIN AH21 [get_ports {C0_DDR4_dqs_c[0]}]
set_property PACKAGE_PIN AH24 [get_ports {C0_DDR4_dqs_t[1]}]
set_property PACKAGE_PIN AJ25 [get_ports {C0_DDR4_dqs_c[1]}]
set_property PACKAGE_PIN AJ20 [get_ports {C0_DDR4_dqs_t[2]}]
set_property PACKAGE_PIN AK20 [get_ports {C0_DDR4_dqs_c[2]}]
set_property PACKAGE_PIN AP20 [get_ports {C0_DDR4_dqs_t[3]}]
set_property PACKAGE_PIN AP21 [get_ports {C0_DDR4_dqs_c[3]}]
#set_property PACKAGE_PIN AL27 [get_ports {C0_DDR4_dqs_t[4]}]
#set_property PACKAGE_PIN AL28 [get_ports {C0_DDR4_dqs_c[4]}]
#set_property PACKAGE_PIN AN29 [get_ports {C0_DDR4_dqs_t[5]}]
#set_property PACKAGE_PIN AP30 [get_ports {C0_DDR4_dqs_c[5]}]
#set_property PACKAGE_PIN AH33 [get_ports {C0_DDR4_dqs_t[6]}]
#set_property PACKAGE_PIN AJ33 [get_ports {C0_DDR4_dqs_c[6]}]
#set_property PACKAGE_PIN AN34 [get_ports {C0_DDR4_dqs_t[7]}]
#set_property PACKAGE_PIN AP34 [get_ports {C0_DDR4_dqs_c[7]}]

set_property PACKAGE_PIN AD21 [get_ports {C0_DDR4_dm_n[0]}]
set_property PACKAGE_PIN AE25 [get_ports {C0_DDR4_dm_n[1]}]
set_property PACKAGE_PIN AJ21 [get_ports {C0_DDR4_dm_n[2]}]
set_property PACKAGE_PIN AM21 [get_ports {C0_DDR4_dm_n[3]}]
#set_property PACKAGE_PIN AH26 [get_ports {C0_DDR4_dm_n[4]}]
#set_property PACKAGE_PIN AN26 [get_ports {C0_DDR4_dm_n[5]}]
#set_property PACKAGE_PIN AJ29 [get_ports {C0_DDR4_dm_n[6]}]
#set_property PACKAGE_PIN AL32 [get_ports {C0_DDR4_dm_n[7]}]


set_property PACKAGE_PIN AE20 [get_ports {C0_DDR4_dq[0]}]
set_property PACKAGE_PIN AG20 [get_ports {C0_DDR4_dq[1]}]
set_property PACKAGE_PIN AF20 [get_ports {C0_DDR4_dq[2]}]
set_property PACKAGE_PIN AE22 [get_ports {C0_DDR4_dq[3]}]
set_property PACKAGE_PIN AD20 [get_ports {C0_DDR4_dq[4]}]
set_property PACKAGE_PIN AG22 [get_ports {C0_DDR4_dq[5]}]
set_property PACKAGE_PIN AF22 [get_ports {C0_DDR4_dq[6]}]
set_property PACKAGE_PIN AE23 [get_ports {C0_DDR4_dq[7]}]
set_property PACKAGE_PIN AJ24 [get_ports {C0_DDR4_dq[8]}]
set_property PACKAGE_PIN AG24 [get_ports {C0_DDR4_dq[9]}]
set_property PACKAGE_PIN AJ23 [get_ports {C0_DDR4_dq[10]}]
set_property PACKAGE_PIN AF23 [get_ports {C0_DDR4_dq[11]}]
set_property PACKAGE_PIN AH23 [get_ports {C0_DDR4_dq[12]}]
set_property PACKAGE_PIN AF24 [get_ports {C0_DDR4_dq[13]}]
set_property PACKAGE_PIN AH22 [get_ports {C0_DDR4_dq[14]}]
set_property PACKAGE_PIN AG25 [get_ports {C0_DDR4_dq[15]}]
set_property PACKAGE_PIN AK22 [get_ports {C0_DDR4_dq[16]}]
set_property PACKAGE_PIN AL22 [get_ports {C0_DDR4_dq[17]}]
set_property PACKAGE_PIN AM20 [get_ports {C0_DDR4_dq[18]}]
set_property PACKAGE_PIN AL23 [get_ports {C0_DDR4_dq[19]}]
set_property PACKAGE_PIN AK23 [get_ports {C0_DDR4_dq[20]}]
set_property PACKAGE_PIN AL25 [get_ports {C0_DDR4_dq[21]}]
set_property PACKAGE_PIN AL20 [get_ports {C0_DDR4_dq[22]}]
set_property PACKAGE_PIN AL24 [get_ports {C0_DDR4_dq[23]}]
set_property PACKAGE_PIN AM24 [get_ports {C0_DDR4_dq[24]}]
set_property PACKAGE_PIN AN23 [get_ports {C0_DDR4_dq[25]}]
set_property PACKAGE_PIN AN24 [get_ports {C0_DDR4_dq[26]}]
set_property PACKAGE_PIN AP23 [get_ports {C0_DDR4_dq[27]}]
set_property PACKAGE_PIN AP25 [get_ports {C0_DDR4_dq[28]}]
set_property PACKAGE_PIN AN22 [get_ports {C0_DDR4_dq[29]}]
set_property PACKAGE_PIN AP24 [get_ports {C0_DDR4_dq[30]}]
set_property PACKAGE_PIN AM22 [get_ports {C0_DDR4_dq[31]}]

#set_property PACKAGE_PIN AM26 [get_ports {C0_DDR4_dq[32]}]
#set_property PACKAGE_PIN AJ28 [get_ports {C0_DDR4_dq[33]}]
#set_property PACKAGE_PIN AM27 [get_ports {C0_DDR4_dq[34]}]
#set_property PACKAGE_PIN AK28 [get_ports {C0_DDR4_dq[35]}]
#set_property PACKAGE_PIN AH27 [get_ports {C0_DDR4_dq[36]}]
#set_property PACKAGE_PIN AH28 [get_ports {C0_DDR4_dq[37]}]
#set_property PACKAGE_PIN AK26 [get_ports {C0_DDR4_dq[38]}]
#set_property PACKAGE_PIN AK27 [get_ports {C0_DDR4_dq[39]}]
#set_property PACKAGE_PIN AN28 [get_ports {C0_DDR4_dq[40]}]
#set_property PACKAGE_PIN AM30 [get_ports {C0_DDR4_dq[41]}]
#set_property PACKAGE_PIN AP28 [get_ports {C0_DDR4_dq[42]}]
#set_property PACKAGE_PIN AM29 [get_ports {C0_DDR4_dq[43]}]
#set_property PACKAGE_PIN AN27 [get_ports {C0_DDR4_dq[44]}]
#set_property PACKAGE_PIN AL30 [get_ports {C0_DDR4_dq[45]}]
#set_property PACKAGE_PIN AL29 [get_ports {C0_DDR4_dq[46]}]
#set_property PACKAGE_PIN AP29 [get_ports {C0_DDR4_dq[47]}]
#set_property PACKAGE_PIN AK31 [get_ports {C0_DDR4_dq[48]}]
#set_property PACKAGE_PIN AH34 [get_ports {C0_DDR4_dq[49]}]
#set_property PACKAGE_PIN AK32 [get_ports {C0_DDR4_dq[50]}]
#set_property PACKAGE_PIN AJ31 [get_ports {C0_DDR4_dq[51]}]
#set_property PACKAGE_PIN AJ30 [get_ports {C0_DDR4_dq[52]}]
#set_property PACKAGE_PIN AH31 [get_ports {C0_DDR4_dq[53]}]
#set_property PACKAGE_PIN AJ34 [get_ports {C0_DDR4_dq[54]}]
#set_property PACKAGE_PIN AH32 [get_ports {C0_DDR4_dq[55]}]
#set_property PACKAGE_PIN AN31 [get_ports {C0_DDR4_dq[56]}]
#set_property PACKAGE_PIN AL34 [get_ports {C0_DDR4_dq[57]}]
#set_property PACKAGE_PIN AN32 [get_ports {C0_DDR4_dq[58]}]
#set_property PACKAGE_PIN AN33 [get_ports {C0_DDR4_dq[59]}]
#set_property PACKAGE_PIN AM32 [get_ports {C0_DDR4_dq[60]}]
#set_property PACKAGE_PIN AM34 [get_ports {C0_DDR4_dq[61]}]
#set_property PACKAGE_PIN AP31 [get_ports {C0_DDR4_dq[62]}]
#set_property PACKAGE_PIN AP33 [get_ports {C0_DDR4_dq[63]}]


set_property PACKAGE_PIN AG14 [get_ports {C0_DDR4_adr[0]}]
set_property PACKAGE_PIN AF17 [get_ports {C0_DDR4_adr[1]}]
set_property PACKAGE_PIN AF15 [get_ports {C0_DDR4_adr[2]}]
set_property PACKAGE_PIN AJ14 [get_ports {C0_DDR4_adr[3]}]
set_property PACKAGE_PIN AD18 [get_ports {C0_DDR4_adr[4]}]
set_property PACKAGE_PIN AG17 [get_ports {C0_DDR4_adr[5]}]
set_property PACKAGE_PIN AE17 [get_ports {C0_DDR4_adr[6]}]
set_property PACKAGE_PIN AK18 [get_ports {C0_DDR4_adr[7]}]
set_property PACKAGE_PIN AD16 [get_ports {C0_DDR4_adr[8]}]
set_property PACKAGE_PIN AH18 [get_ports {C0_DDR4_adr[9]}]
set_property PACKAGE_PIN AD19 [get_ports {C0_DDR4_adr[10]}]
set_property PACKAGE_PIN AD15 [get_ports {C0_DDR4_adr[11]}]
set_property PACKAGE_PIN AH16 [get_ports {C0_DDR4_adr[12]}]
set_property PACKAGE_PIN AL17 [get_ports {C0_DDR4_adr[13]}]
set_property PACKAGE_PIN AL15 [get_ports {C0_DDR4_adr[14]}]
set_property PACKAGE_PIN AL19 [get_ports {C0_DDR4_adr[15]}]
set_property PACKAGE_PIN AM19 [get_ports {C0_DDR4_adr[16]}]
set_property PACKAGE_PIN AG15 [get_ports {C0_DDR4_ba[0]}]
set_property PACKAGE_PIN AL18 [get_ports {C0_DDR4_ba[1]}]

set_property PACKAGE_PIN AJ15 [get_ports {C0_DDR4_bg[0]}]
set_property PACKAGE_PIN AG19 [get_ports {C0_DDR4_odt[0]}]
set_property PACKAGE_PIN AJ16 [get_ports {C0_DDR4_cke[0]}]
set_property PACKAGE_PIN AE16 [get_ports {C0_DDR4_ck_t[0]}]
set_property PACKAGE_PIN AE15 [get_ports {C0_DDR4_ck_c[0]}]

set_property PACKAGE_PIN AG16 [get_ports C0_DDR4_reset_n]
set_property PACKAGE_PIN AF18 [get_ports C0_DDR4_act_n]
set_property PACKAGE_PIN AE18 [get_ports {C0_DDR4_cs_n[0]}]


#RGMII
set_property -dict {PACKAGE_PIN M26 IOSTANDARD LVCMOS33} [get_ports phy_reset_out]

set_property -dict {PACKAGE_PIN T27 IOSTANDARD LVCMOS33} [get_ports {rgmii_rd[3]}]
set_property -dict {PACKAGE_PIN R27 IOSTANDARD LVCMOS33} [get_ports {rgmii_rd[2]}]
set_property -dict {PACKAGE_PIN P23 IOSTANDARD LVCMOS33} [get_ports {rgmii_rd[1]}]
set_property -dict {PACKAGE_PIN R23 IOSTANDARD LVCMOS33} [get_ports {rgmii_rd[0]}]
set_property -dict {PACKAGE_PIN T24 IOSTANDARD LVCMOS33} [get_ports rgmii_rx_ctl]
set_property -dict {PACKAGE_PIN P24 IOSTANDARD LVCMOS33} [get_ports rgmii_rxc]

set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS33} [get_ports {rgmii_td[3]}]
set_property -dict {PACKAGE_PIN N21 IOSTANDARD LVCMOS33} [get_ports {rgmii_td[2]}]
set_property -dict {PACKAGE_PIN M24 IOSTANDARD LVCMOS33} [get_ports {rgmii_td[1]}]
set_property -dict {PACKAGE_PIN P25 IOSTANDARD LVCMOS33} [get_ports {rgmii_td[0]}]
set_property -dict {PACKAGE_PIN M25 IOSTANDARD LVCMOS33} [get_ports rgmii_tx_ctl]
set_property -dict {PACKAGE_PIN N24 IOSTANDARD LVCMOS33} [get_ports rgmii_txc]

set_property -dict {PACKAGE_PIN L23 IOSTANDARD LVCMOS33} [get_ports mdio_mdc]
set_property -dict {PACKAGE_PIN L24 IOSTANDARD LVCMOS33} [get_ports mdio_mdio_io]


#-----------------------------------OLDI in--------------------

create_clock -period 20 [get_ports ch0_clkin0_p]
create_clock -period 20 [get_ports ch0_clkin1_p]

set_property IOSTANDARD LVDS_25 [get_ports ch0_clkin0_p]
set_property DIFF_TERM_ADV TERM_100 [get_ports ch0_clkin0_p]
set_property PACKAGE_PIN AG11 [get_ports ch0_clkin0_p]
set_property PACKAGE_PIN AH11 [get_ports ch0_clkin0_n]
set_property IOSTANDARD LVDS_25 [get_ports ch0_clkin0_n]
set_property DIFF_TERM_ADV TERM_100 [get_ports ch0_clkin0_n]

set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain0_p[0]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain0_p[0]}]
set_property PACKAGE_PIN AH13 [get_ports {ch0_datain0_p[0]}]
set_property PACKAGE_PIN AJ13 [get_ports {ch0_datain0_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain0_n[0]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain0_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain0_p[1]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain0_p[1]}]
set_property PACKAGE_PIN AK13 [get_ports {ch0_datain0_p[1]}]
set_property PACKAGE_PIN AL13 [get_ports {ch0_datain0_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain0_n[1]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain0_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain0_p[2]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain0_p[2]}]
set_property PACKAGE_PIN AK12 [get_ports {ch0_datain0_p[2]}]
set_property PACKAGE_PIN AL12 [get_ports {ch0_datain0_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain0_n[2]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain0_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain0_p[3]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain0_p[3]}]
set_property PACKAGE_PIN AM12 [get_ports {ch0_datain0_p[3]}]
set_property PACKAGE_PIN AN12 [get_ports {ch0_datain0_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain0_n[3]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain0_n[3]}]

set_property DIFF_TERM_ADV TERM_100 [get_ports ch0_clkin1_p]
set_property IOSTANDARD LVDS_25 [get_ports ch0_clkin1_p]
set_property PACKAGE_PIN AG12 [get_ports ch0_clkin1_p]
set_property PACKAGE_PIN AH12 [get_ports ch0_clkin1_n]
set_property IOSTANDARD LVDS_25 [get_ports ch0_clkin1_n]
set_property DIFF_TERM_ADV TERM_100 [get_ports ch0_clkin1_n]

set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain1_p[0]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain1_p[0]}]
set_property PACKAGE_PIN AE13 [get_ports {ch0_datain1_p[0]}]
set_property PACKAGE_PIN AF13 [get_ports {ch0_datain1_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain1_n[0]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain1_n[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain1_p[1]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain1_p[1]}]
set_property PACKAGE_PIN AE12 [get_ports {ch0_datain1_p[1]}]
set_property PACKAGE_PIN AF12 [get_ports {ch0_datain1_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain1_n[1]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain1_n[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain1_p[2]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain1_p[2]}]
set_property PACKAGE_PIN AM11 [get_ports {ch0_datain1_p[2]}]
set_property PACKAGE_PIN AN11 [get_ports {ch0_datain1_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain1_n[2]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain1_n[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain1_p[3]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain1_p[3]}]
set_property PACKAGE_PIN AP11 [get_ports {ch0_datain1_p[3]}]
set_property PACKAGE_PIN AP10 [get_ports {ch0_datain1_n[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {ch0_datain1_n[3]}]
set_property DIFF_TERM_ADV TERM_100 [get_ports {ch0_datain1_n[3]}]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets system_i/oldi_in/lvds4x2_1to7_0/inst/rx_inst/iob_clk_in/O]
set_property LOC PLLE3_ADV_X1Y1 [get_cells system_i/oldi_in/lvds4x2_1to7_0/inst/rx_inst/rx_clkgen/rx_plle2_adv_inst]
set_property LOC BITSLICE_CONTROL_X1Y3 [get_cells system_i/oldi_in/lvds4x2_1to7_0/inst/icontrol]
#set_property IODELAY_GROUP IO_DLY0 [get_cells {system_i/oldi_in/lvds4x2_1to7_0/inst/icontrol}]
#set_property IODELAY_GROUP IO_DLY0 [get_cells {system_i/oldi_in/lvds4x2_1to7_0/inst/rx_inst/rxc_delay/idelay_cs}]
#set_property IODELAY_GROUP IO_DLY0 [get_cells {system_i/oldi_in/lvds4x2_1to7_0/inst/rx_inst/rxc_delay/idelay_cm}]
#set_property IODELAY_GROUP IO_DLY0 [get_cells {system_i/oldi_in/lvds4x2_1to7_0/inst/rx_inst/loop0[*].rxn/rxd[*].sipo/idelay_cm}]


#-----------------------------------PCIE--------------------
create_clock -period 10.000 -name pcie_sys_clk -waveform {0.000 5.000} [get_ports {pcie_sys_clk_clk_p[0]}]
set_property PACKAGE_PIN AB6 [get_ports {pcie_sys_clk_clk_p[0]}]

set_property LOC PCIE_3_1_X0Y0 [get_cells system_i/pcie_hier_0/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_pcie3_uscale_top_inst/pcie3_uscale_wrapper_inst/PCIE_3_1_inst]
set_property PACKAGE_PIN K22 [get_ports pcie_resetn]
set_property IOSTANDARD LVCMOS33 [get_ports pcie_resetn]


# MGT locations

set_property LOC GTHE3_CHANNEL_X0Y7 [get_cells {system_i/pcie_hier_0/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[1].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AC4 [get_ports {pcie_mgt_txp[0]}]
set_property LOC GTHE3_CHANNEL_X0Y6 [get_cells {system_i/pcie_hier_0/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[1].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[2].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AE4 [get_ports {pcie_mgt_txp[1]}]
set_property LOC GTHE3_CHANNEL_X0Y5 [get_cells {system_i/pcie_hier_0/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[1].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[1].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AG4 [get_ports {pcie_mgt_txp[2]}]
set_property LOC GTHE3_CHANNEL_X0Y4 [get_cells {system_i/pcie_hier_0/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[1].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[0].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AH6 [get_ports {pcie_mgt_txp[3]}]
set_property LOC GTHE3_CHANNEL_X0Y3 [get_cells {system_i/pcie_hier_0/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[0].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AK6 [get_ports {pcie_mgt_txp[4]}]
set_property LOC GTHE3_CHANNEL_X0Y2 [get_cells {system_i/pcie_hier_0/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[0].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[2].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AL4 [get_ports {pcie_mgt_txp[5]}]
set_property LOC GTHE3_CHANNEL_X0Y1 [get_cells {system_i/pcie_hier_0/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[0].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[1].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AM6 [get_ports {pcie_mgt_txp[6]}]
set_property LOC GTHE3_CHANNEL_X0Y0 [get_cells {system_i/pcie_hier_0/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[0].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[0].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AN4 [get_ports {pcie_mgt_txp[7]}]



