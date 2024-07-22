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

#set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports qspi_flash_ss_io]
#set_property -dict {PACKAGE_PIN AA9 IOSTANDARD LVCMOS33} [get_ports qspi_flash_sck_io]
#set_property -dict {PACKAGE_PIN AC7 IOSTANDARD LVCMOS33} [get_ports qspi_flash_io0_io]
#set_property -dict {PACKAGE_PIN AB7 IOSTANDARD LVCMOS33} [get_ports qspi_flash_io1_io]
#set_property -dict {PACKAGE_PIN AA7 IOSTANDARD LVCMOS33} [get_ports qspi_flash_io2_io]
#set_property -dict {PACKAGE_PIN Y7 IOSTANDARD LVCMOS33} [get_ports qspi_flash_io3_io]


set_property -dict {PACKAGE_PIN H26 IOSTANDARD LVCMOS33} [get_ports uart_0_rxd]
set_property -dict {PACKAGE_PIN J26 IOSTANDARD LVCMOS33} [get_ports uart_0_txd]
set_property -dict {PACKAGE_PIN G27 IOSTANDARD LVCMOS33} [get_ports uart_1_rxd]
set_property -dict {PACKAGE_PIN H27 IOSTANDARD LVCMOS33} [get_ports uart_1_txd]


# EEPROM
## sda
set_property -dict {PACKAGE_PIN P26 IOSTANDARD LVCMOS33} [get_ports i2c_0_sda_io]
set_property UNAVAILABLE_DURING_CALIBRATION true [get_ports i2c_0_sda_io]
## scl
set_property -dict {PACKAGE_PIN R25 IOSTANDARD LVCMOS33} [get_ports i2c_0_scl_io]
## wp
set_property -dict {PACKAGE_PIN R26 IOSTANDARD LVCMOS33} [get_ports {gpio_tri_io[0]}]

# max96752
## sda
set_property -dict {PACKAGE_PIN AF34 IOSTANDARD LVCMOS18} [get_ports i2c_1_sda_io]
## scl
set_property -dict {PACKAGE_PIN AE33 IOSTANDARD LVCMOS18} [get_ports i2c_1_scl_io]

#-----------------------------------OLDI in--------------------

create_clock -period 20.000 [get_ports ch0_clkin0_p]
create_clock -period 20.000 [get_ports ch0_clkin1_p]

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

set_property LOC PCIE_3_1_X0Y0 [get_cells system_i/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_pcie3_uscale_top_inst/pcie3_uscale_wrapper_inst/PCIE_3_1_inst]
set_property PACKAGE_PIN K22 [get_ports pcie_resetn]
set_property IOSTANDARD LVCMOS33 [get_ports pcie_resetn]


# MGT locations

set_property LOC GTHE3_CHANNEL_X0Y7 [get_cells {system_i/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[1].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AC4 [get_ports {pcie_mgt_txp[0]}]
set_property LOC GTHE3_CHANNEL_X0Y6 [get_cells {system_i/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[1].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[2].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AE4 [get_ports {pcie_mgt_txp[1]}]
set_property LOC GTHE3_CHANNEL_X0Y5 [get_cells {system_i/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[1].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[1].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AG4 [get_ports {pcie_mgt_txp[2]}]
set_property LOC GTHE3_CHANNEL_X0Y4 [get_cells {system_i/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[1].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[0].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AH6 [get_ports {pcie_mgt_txp[3]}]
set_property LOC GTHE3_CHANNEL_X0Y3 [get_cells {system_i/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[0].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[3].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AK6 [get_ports {pcie_mgt_txp[4]}]
set_property LOC GTHE3_CHANNEL_X0Y2 [get_cells {system_i/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[0].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[2].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AL4 [get_ports {pcie_mgt_txp[5]}]
set_property LOC GTHE3_CHANNEL_X0Y1 [get_cells {system_i/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[0].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[1].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AM6 [get_ports {pcie_mgt_txp[6]}]
set_property LOC GTHE3_CHANNEL_X0Y0 [get_cells {system_i/xdma_0/inst/pcie3_ip_i/inst/system_xdma_0_0_pcie3_ip_gt_top_i/gt_wizard.gtwizard_top_i/system_xdma_0_0_pcie3_ip_gt_i/inst/gen_gtwizard_gthe3_top.system_xdma_0_0_pcie3_ip_gt_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[0].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[0].GTHE3_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN AN4 [get_ports {pcie_mgt_txp[7]}]

#set_property PACKAGE_PIN AH6 [get_ports {pcie_mgt_txp[3]}]
#set_property LOC GTPE2_CHANNEL_X0Y4 [get_cells {system_i/xdma_0/inst/system_xdma_0_0_pcie2_to_pcie3_wrapper_i/pcie2_ip_i/inst/inst/gt_top_i/pipe_wrapper_i/pipe_lane[3].gt_wrapper_i/gtp_channel.gtpe2_channel_i}]
#set_property PACKAGE_PIN AG4 [get_ports {pcie_mgt_txp[2]}]
#set_property LOC GTPE2_CHANNEL_X0Y5 [get_cells {system_i/xdma_0/inst/system_xdma_0_0_pcie2_to_pcie3_wrapper_i/pcie2_ip_i/inst/inst/gt_top_i/pipe_wrapper_i/pipe_lane[2].gt_wrapper_i/gtp_channel.gtpe2_channel_i}]
#set_property PACKAGE_PIN AE4 [get_ports {pcie_mgt_txp[1]}]
#set_property LOC GTPE2_CHANNEL_X0Y6 [get_cells {system_i/xdma_0/inst/system_xdma_0_0_pcie2_to_pcie3_wrapper_i/pcie2_ip_i/inst/inst/gt_top_i/pipe_wrapper_i/pipe_lane[1].gt_wrapper_i/gtp_channel.gtpe2_channel_i}]
#set_property PACKAGE_PIN AC4 [get_ports {pcie_mgt_txp[0]}]
#set_property LOC GTPE2_CHANNEL_X0Y7 [get_cells {system_i/xdma_0/inst/system_xdma_0_0_pcie2_to_pcie3_wrapper_i/pcie2_ip_i/inst/inst/gt_top_i/pipe_wrapper_i/pipe_lane[0].gt_wrapper_i/gtp_channel.gtpe2_channel_i}]


#set_property PACKAGE_PIN AH6 [get_ports {pcie_mgt_txp[3]}]
#set_property LOC GTHE2_CHANNEL_X0Y4 [get_cells {system_i/xdma_0/inst/system_xdma_0_0_pcie2_to_pcie3_wrapper_i/pcie2_ip_i/inst/inst/gt_top_i/pipe_wrapper_i/pipe_lane[3].gt_wrapper_i/gtp_channel.gtpe2_channel_i}]
#set_property PACKAGE_PIN AG4 [get_ports {pcie_mgt_txp[2]}]
#set_property LOC GTHE2_CHANNEL_X0Y5 [get_cells {system_i/xdma_0/inst/system_xdma_0_0_pcie2_to_pcie3_wrapper_i/pcie2_ip_i/inst/inst/gt_top_i/pipe_wrapper_i/pipe_lane[2].gt_wrapper_i/gtp_channel.gtpe2_channel_i}]
#set_property PACKAGE_PIN AE4 [get_ports {pcie_mgt_txp[1]}]
#set_property LOC GTHE2_CHANNEL_X0Y6 [get_cells {system_i/xdma_0/inst/system_xdma_0_0_pcie2_to_pcie3_wrapper_i/pcie2_ip_i/inst/inst/gt_top_i/pipe_wrapper_i/pipe_lane[1].gt_wrapper_i/gtp_channel.gtpe2_channel_i}]
#set_property PACKAGE_PIN AC4 [get_ports {pcie_mgt_txp[0]}]
#set_property LOC GTHE2_CHANNEL_X0Y7 [get_cells {system_i/xdma_0/inst/system_xdma_0_0_pcie2_to_pcie3_wrapper_i/pcie2_ip_i/inst/inst/gt_top_i/pipe_wrapper_i/pipe_lane[0].gt_wrapper_i/gtp_channel.gtpe2_channel_i}]