
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcku040-ffva1156-2-i
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:axi_vdma:6.3\
xilinx.com:user:axis_passthrough_monitor:1.0\
xilinx.com:ip:axis_switch:1.1\
xilinx.com:ip:ddr4:2.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:v_tpg:8.0\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:axi_ethernet:7.2\
xilinx.com:ip:axi_timer:2.0\
xilinx.com:ip:clk_wiz:6.0\
user.org:user:lvds4x2_1to7:1.0\
xilinx.com:ip:v_vid_in_axi4s:4.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:system_ila:1.1\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:xdma:4.1\
xilinx.com:user:AXI_LITE_REG:1.0\
xilinx.com:ip:axi_iic:2.0\
xilinx.com:ip:axi_quad_spi:3.2\
xilinx.com:ip:axi_uartlite:2.0\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:lmb_v10:3.0\
xilinx.com:ip:blk_mem_gen:8.4\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 LMB_M

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 LMB_M1


  # Create pins
  create_bd_pin -dir I -type rst LMB_Rst
  create_bd_pin -dir I -type clk clk_100m

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [ list \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_DLMB [get_bd_intf_pins LMB_M] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ILMB [get_bd_intf_pins LMB_M1] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins LMB_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins clk_100m] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: processor_subsystem
proc create_hier_cell_processor_subsystem { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_processor_subsystem() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M09_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M10_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M11_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M12_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_DC

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_IC

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S01_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 eth_m_axi_dma

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 eth_m_axi_tmr

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 eth_m_axi_xeth

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_1


  # Create pins
  create_bd_pin -dir I -type rst LMB_reset
  create_bd_pin -dir I -type clk M12_ACLK
  create_bd_pin -dir I -type rst M12_ARESETN
  create_bd_pin -dir I -type clk S01_ACLK
  create_bd_pin -dir I -type rst S01_ARESETN
  create_bd_pin -dir I -from 31 -to 0 VERSION
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 0 -to 0 ethernet_dma_mm2s_irq
  create_bd_pin -dir I -from 0 -to 0 ethernet_dma_s2mm_irq
  create_bd_pin -dir I -from 0 -to 0 ethernet_irq
  create_bd_pin -dir I -from 0 -to 0 ethernet_mac_irq
  create_bd_pin -dir I -from 0 -to 0 ethernet_tmr_irq
  create_bd_pin -dir O -type rst mb_debug_sys_rst
  create_bd_pin -dir I -type rst mb_reset

  # Create instance: AXI_LITE_REG_0, and set properties
  set AXI_LITE_REG_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:AXI_LITE_REG:1.0 AXI_LITE_REG_0 ]

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_0 ]

  # Create instance: axi_quad_spi_0, and set properties
  set axi_quad_spi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0 ]
  set_property -dict [ list \
   CONFIG.C_FIFO_DEPTH {256} \
   CONFIG.C_SCK_RATIO {2} \
   CONFIG.C_SPI_MEMORY {2} \
   CONFIG.C_SPI_MODE {2} \
   CONFIG.C_USE_STARTUP {1} \
   CONFIG.C_USE_STARTUP_INT {1} \
 ] $axi_quad_spi_0

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
   CONFIG.C_BAUDRATE {115200} \
   CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $axi_uartlite_0

  # Create instance: axi_uartlite_1, and set properties
  set axi_uartlite_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_1 ]
  set_property -dict [ list \
   CONFIG.C_BAUDRATE {115200} \
   CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $axi_uartlite_1

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_SIZE {32} \
   CONFIG.C_M_AXI_ADDR_WIDTH {32} \
   CONFIG.C_USE_UART {0} \
 ] $mdm_1

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {17} \
   CONFIG.C_CACHE_BYTE_SIZE {16384} \
   CONFIG.C_DCACHE_ADDR_TAG {17} \
   CONFIG.C_DCACHE_BYTE_SIZE {16384} \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_I_LMB {1} \
   CONFIG.C_USE_BARREL {1} \
   CONFIG.C_USE_DCACHE {1} \
   CONFIG.C_USE_HW_MUL {1} \
   CONFIG.C_USE_ICACHE {1} \
   CONFIG.C_USE_MSR_INSTR {1} \
   CONFIG.C_USE_PCMP_INSTR {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
   CONFIG.C_HAS_FAST {1} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {13} \
   CONFIG.NUM_SI {2} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory $hier_obj microblaze_0_local_memory

  # Create instance: microblaze_0_xlconcat, and set properties
  set microblaze_0_xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 microblaze_0_xlconcat ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {9} \
 ] $microblaze_0_xlconcat

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI_DC] [get_bd_intf_pins microblaze_0/M_AXI_DC]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins eth_m_axi_dma] [get_bd_intf_pins microblaze_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins S01_AXI] [get_bd_intf_pins microblaze_0_axi_periph/S01_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins uart_1] [get_bd_intf_pins axi_uartlite_1/UART]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins M_AXI_IC] [get_bd_intf_pins microblaze_0/M_AXI_IC]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins eth_m_axi_tmr] [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins i2c_0] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net Conn19 [get_bd_intf_pins uart_0] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net interconnect_MBDEBUG_0 [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_DLMB [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ILMB [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/LMB_M1]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_intc_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins axi_uartlite_1/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins axi_iic_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins AXI_LITE_REG_0/S00_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins axi_quad_spi_0/AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M06_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M07_AXI [get_bd_intf_pins eth_m_axi_xeth] [get_bd_intf_pins microblaze_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M09_AXI [get_bd_intf_pins M09_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M09_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M10_AXI [get_bd_intf_pins M10_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M10_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M11_AXI [get_bd_intf_pins M11_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M11_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M12_AXI [get_bd_intf_pins M12_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M12_AXI]

  # Create port connections
  connect_bd_net -net In4_1 [get_bd_pins ethernet_tmr_irq] [get_bd_pins microblaze_0_xlconcat/In4]
  connect_bd_net -net LMB_Rst_1 [get_bd_pins LMB_reset] [get_bd_pins microblaze_0_local_memory/LMB_Rst]
  connect_bd_net -net M12_ACLK_1 [get_bd_pins M12_ACLK] [get_bd_pins microblaze_0_axi_periph/M12_ACLK]
  connect_bd_net -net M12_ARESETN_1 [get_bd_pins M12_ARESETN] [get_bd_pins microblaze_0_axi_periph/M12_ARESETN]
  connect_bd_net -net Reset_1 [get_bd_pins mb_reset] [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst]
  connect_bd_net -net S01_ACLK_1 [get_bd_pins S01_ACLK] [get_bd_pins microblaze_0_axi_periph/S01_ACLK]
  connect_bd_net -net S01_ARESETN_1 [get_bd_pins S01_ARESETN] [get_bd_pins microblaze_0_axi_periph/S01_ARESETN]
  connect_bd_net -net VERSION_1 [get_bd_pins VERSION] [get_bd_pins AXI_LITE_REG_0/VERSION]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins axi_iic_0/iic2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In3]
  connect_bd_net -net axi_quad_spi_0_ip2intc_irpt [get_bd_pins axi_quad_spi_0/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In0]
  connect_bd_net -net axi_uartlite_0_interrupt [get_bd_pins axi_uartlite_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In1]
  connect_bd_net -net axi_uartlite_1_interrupt [get_bd_pins axi_uartlite_1/interrupt] [get_bd_pins microblaze_0_xlconcat/In2]
  connect_bd_net -net ethernet_dma_mm2s_irq_1 [get_bd_pins ethernet_dma_mm2s_irq] [get_bd_pins microblaze_0_xlconcat/In7]
  connect_bd_net -net ethernet_dma_s2mm_irq_1 [get_bd_pins ethernet_dma_s2mm_irq] [get_bd_pins microblaze_0_xlconcat/In8]
  connect_bd_net -net ethernet_irq_1 [get_bd_pins ethernet_irq] [get_bd_pins microblaze_0_xlconcat/In5]
  connect_bd_net -net ethernet_mac_irq_1 [get_bd_pins ethernet_mac_irq] [get_bd_pins microblaze_0_xlconcat/In6]
  connect_bd_net -net mdm_1_Debug_SYS_Rst [get_bd_pins mb_debug_sys_rst] [get_bd_pins mdm_1/Debug_SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins aclk] [get_bd_pins AXI_LITE_REG_0/s00_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_quad_spi_0/ext_spi_clk] [get_bd_pins axi_quad_spi_0/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins axi_uartlite_1/s_axi_aclk] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/M06_ACLK] [get_bd_pins microblaze_0_axi_periph/M07_ACLK] [get_bd_pins microblaze_0_axi_periph/M08_ACLK] [get_bd_pins microblaze_0_axi_periph/M09_ACLK] [get_bd_pins microblaze_0_axi_periph/M10_ACLK] [get_bd_pins microblaze_0_axi_periph/M11_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/clk_100m]
  connect_bd_net -net microblaze_0_xlconcat_dout [get_bd_pins microblaze_0_axi_intc/intr] [get_bd_pins microblaze_0_xlconcat/dout]
  connect_bd_net -net rst_system_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins AXI_LITE_REG_0/s00_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_quad_spi_0/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins axi_uartlite_1/s_axi_aresetn] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/M06_ARESETN] [get_bd_pins microblaze_0_axi_periph/M07_ARESETN] [get_bd_pins microblaze_0_axi_periph/M08_ARESETN] [get_bd_pins microblaze_0_axi_periph/M09_ARESETN] [get_bd_pins microblaze_0_axi_periph/M10_ARESETN] [get_bd_pins microblaze_0_axi_periph/M11_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pcie_hier_0
proc create_hier_cell_pcie_hier_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pcie_hier_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_LITE

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_mgt

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_sys_clk


  # Create pins
  create_bd_pin -dir O -type clk axi_aclk
  create_bd_pin -dir O -type rst axi_aresetn
  create_bd_pin -dir I -type rst pcie_resetn
  create_bd_pin -dir I -from 0 -to 0 usr_irq_req

  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0 ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {23.5} \
   CONFIG.C_DATA_DEPTH {4096} \
   CONFIG.C_MON_TYPE {INTERFACE} \
   CONFIG.C_NUM_MONITOR_SLOTS {1} \
   CONFIG.C_SLOT_0_APC_EN {0} \
   CONFIG.C_SLOT_0_AXI_AR_SEL_DATA {1} \
   CONFIG.C_SLOT_0_AXI_AR_SEL_TRIG {1} \
   CONFIG.C_SLOT_0_AXI_AW_SEL_DATA {1} \
   CONFIG.C_SLOT_0_AXI_AW_SEL_TRIG {1} \
   CONFIG.C_SLOT_0_AXI_B_SEL_DATA {1} \
   CONFIG.C_SLOT_0_AXI_B_SEL_TRIG {1} \
   CONFIG.C_SLOT_0_AXI_R_SEL_DATA {1} \
   CONFIG.C_SLOT_0_AXI_R_SEL_TRIG {1} \
   CONFIG.C_SLOT_0_AXI_W_SEL_DATA {1} \
   CONFIG.C_SLOT_0_AXI_W_SEL_TRIG {1} \
   CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:aximm_rtl:1.0} \
 ] $system_ila_0

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_0 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf_0

  # Create instance: xdma_0, and set properties
  set xdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 xdma_0 ]
  set_property -dict [ list \
   CONFIG.PF0_DEVICE_ID_mqdma {9028} \
   CONFIG.PF2_DEVICE_ID_mqdma {9028} \
   CONFIG.PF3_DEVICE_ID_mqdma {9028} \
   CONFIG.axi_data_width {256_bit} \
   CONFIG.axilite_master_en {true} \
   CONFIG.axilite_master_scale {Gigabytes} \
   CONFIG.axilite_master_size {1} \
   CONFIG.axisten_freq {125} \
   CONFIG.cfg_mgmt_if {false} \
   CONFIG.coreclk_freq {250} \
   CONFIG.disable_gt_loc {false} \
   CONFIG.en_ext_ch_gt_drp {false} \
   CONFIG.en_gt_selection {true} \
   CONFIG.enable_auto_rxeq {True} \
   CONFIG.mode_selection {Basic} \
   CONFIG.pciebar2axibar_axil_master {0x40000000} \
   CONFIG.pf0_Use_Class_Code_Lookup_Assistant {true} \
   CONFIG.pf0_base_class_menu {Memory_controller} \
   CONFIG.pf0_class_code {058000} \
   CONFIG.pf0_class_code_base {05} \
   CONFIG.pf0_class_code_interface {00} \
   CONFIG.pf0_class_code_sub {80} \
   CONFIG.pf0_device_id {8028} \
   CONFIG.pf0_interrupt_pin {NONE} \
   CONFIG.pf0_msix_cap_pba_bir {BAR_1} \
   CONFIG.pf0_msix_cap_table_bir {BAR_1} \
   CONFIG.pf0_sub_class_interface_menu {Other_memory_controller} \
   CONFIG.pl_link_cap_max_link_speed {5.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X8} \
   CONFIG.plltype {QPLL1} \
   CONFIG.xdma_rnum_chnl {4} \
   CONFIG.xdma_wnum_chnl {4} \
 ] $xdma_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins pcie_sys_clk] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M_AXI_LITE] [get_bd_intf_pins xdma_0/M_AXI_LITE]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins pcie_mgt] [get_bd_intf_pins xdma_0/pcie_mgt]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins M_AXI] [get_bd_intf_pins xdma_0/M_AXI]
  connect_bd_intf_net -intf_net [get_bd_intf_nets Conn4] [get_bd_intf_pins M_AXI] [get_bd_intf_pins system_ila_0/SLOT_0_AXI]

  # Create port connections
  connect_bd_net -net pcie_resetn_1 [get_bd_pins pcie_resetn] [get_bd_pins xdma_0/sys_rst_n]
  connect_bd_net -net usr_irq_req_1 [get_bd_pins usr_irq_req] [get_bd_pins xdma_0/usr_irq_req]
  connect_bd_net -net util_ds_buf_0_IBUF_DS_ODIV2 [get_bd_pins util_ds_buf_0/IBUF_DS_ODIV2] [get_bd_pins xdma_0/sys_clk]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins util_ds_buf_0/IBUF_OUT] [get_bd_pins xdma_0/sys_clk_gt]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_pins axi_aclk] [get_bd_pins system_ila_0/clk] [get_bd_pins xdma_0/axi_aclk]
  connect_bd_net -net xdma_0_axi_aresetn [get_bd_pins axi_aresetn] [get_bd_pins system_ila_0/resetn] [get_bd_pins xdma_0/axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: oldi_in
proc create_hier_cell_oldi_in { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_oldi_in() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 video_out


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I axis_enable
  create_bd_pin -dir I ch0_clkin0_n
  create_bd_pin -dir I ch0_clkin0_p
  create_bd_pin -dir I ch0_clkin1_n
  create_bd_pin -dir I ch0_clkin1_p
  create_bd_pin -dir I -from 3 -to 0 ch0_datain0_n
  create_bd_pin -dir I -from 3 -to 0 ch0_datain0_p
  create_bd_pin -dir I -from 3 -to 0 ch0_datain1_n
  create_bd_pin -dir I -from 3 -to 0 ch0_datain1_p
  create_bd_pin -dir I -type rst reset

  # Create instance: lvds4x2_1to7_0, and set properties
  set lvds4x2_1to7_0 [ create_bd_cell -type ip -vlnv user.org:user:lvds4x2_1to7:1.0 lvds4x2_1to7_0 ]
  set_property -dict [ list \
   CONFIG.CLKIN_PERIOD {20} \
 ] $lvds4x2_1to7_0

  # Create instance: v_vid_in_axi4s_0, and set properties
  set v_vid_in_axi4s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:4.0 v_vid_in_axi4s_0 ]
  set_property -dict [ list \
   CONFIG.C_HAS_ASYNC_CLK {1} \
   CONFIG.C_PIXELS_PER_CLOCK {2} \
 ] $v_vid_in_axi4s_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins video_out] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]

  # Create port connections
  connect_bd_net -net VCC_dout [get_bd_pins axis_enable] [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce]
  connect_bd_net -net clkin1_n_0_1 [get_bd_pins ch0_clkin0_n] [get_bd_pins lvds4x2_1to7_0/clkin1_n]
  connect_bd_net -net clkin1_p_0_1 [get_bd_pins ch0_clkin0_p] [get_bd_pins lvds4x2_1to7_0/clkin1_p]
  connect_bd_net -net clkin2_n_0_1 [get_bd_pins ch0_clkin1_n] [get_bd_pins lvds4x2_1to7_0/clkin2_n]
  connect_bd_net -net clkin2_p_0_1 [get_bd_pins ch0_clkin1_p] [get_bd_pins lvds4x2_1to7_0/clkin2_p]
  connect_bd_net -net clock_and_memory_subsystem_c0_ddr4_ui_clk [get_bd_pins aclk] [get_bd_pins lvds4x2_1to7_0/refclk] [get_bd_pins v_vid_in_axi4s_0/aclk]
  connect_bd_net -net clock_and_memory_subsystem_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins v_vid_in_axi4s_0/aresetn]
  connect_bd_net -net clock_and_memory_subsystem_peripheral_reset [get_bd_pins reset] [get_bd_pins lvds4x2_1to7_0/reset]
  connect_bd_net -net datain1_n_0_1 [get_bd_pins ch0_datain0_n] [get_bd_pins lvds4x2_1to7_0/datain1_n]
  connect_bd_net -net datain1_p_0_1 [get_bd_pins ch0_datain0_p] [get_bd_pins lvds4x2_1to7_0/datain1_p]
  connect_bd_net -net datain2_n_0_1 [get_bd_pins ch0_datain1_n] [get_bd_pins lvds4x2_1to7_0/datain2_n]
  connect_bd_net -net datain2_p_0_1 [get_bd_pins ch0_datain1_p] [get_bd_pins lvds4x2_1to7_0/datain2_p]
  connect_bd_net -net lvds4x2_1to7_0_de0 [get_bd_pins lvds4x2_1to7_0/de0] [get_bd_pins v_vid_in_axi4s_0/vid_active_video]
  connect_bd_net -net lvds4x2_1to7_0_dout0 [get_bd_pins lvds4x2_1to7_0/dout0] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net lvds4x2_1to7_0_dout1 [get_bd_pins lvds4x2_1to7_0/dout1] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net lvds4x2_1to7_0_hs0 [get_bd_pins lvds4x2_1to7_0/hs0] [get_bd_pins v_vid_in_axi4s_0/vid_hsync]
  connect_bd_net -net lvds4x2_1to7_0_px_clk [get_bd_pins lvds4x2_1to7_0/px_clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net lvds4x2_1to7_0_vs0 [get_bd_pins lvds4x2_1to7_0/vs0] [get_bd_pins v_vid_in_axi4s_0/vid_vsync]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins v_vid_in_axi4s_0/vid_data] [get_bd_pins xlconcat_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: ethernet_subsystem
proc create_hier_cell_ethernet_subsystem { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_ethernet_subsystem() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM2S

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_SG

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 eth_s_axi_dma

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 eth_s_axi_tmr

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 eth_s_axi_xeth

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -type clk clk_wiz_clk_in
  create_bd_pin -dir I -type rst clk_wiz_resetn
  create_bd_pin -dir O -type intr ethernet_irq
  create_bd_pin -dir O -type intr mac_irq
  create_bd_pin -dir O -type intr mm2s_irq
  create_bd_pin -dir O -from 0 -to 0 -type rst phy_reset_out
  create_bd_pin -dir O -type intr s2mm_irq
  create_bd_pin -dir O -type intr tmr_irq

  # Create instance: axi_dma_0, and set properties
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s_dre {1} \
   CONFIG.c_include_s2mm_dre {1} \
   CONFIG.c_sg_length_width {16} \
   CONFIG.c_sg_use_stsapp_length {1} \
 ] $axi_dma_0

  # Create instance: axi_ethernet_0, and set properties
  set axi_ethernet_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernet:7.2 axi_ethernet_0 ]
  set_property -dict [ list \
   CONFIG.PHY_TYPE {RGMII} \
   CONFIG.RXCSUM {Full} \
   CONFIG.RXMEM {32k} \
   CONFIG.TXCSUM {Full} \
   CONFIG.TXMEM {32k} \
   CONFIG.axisclkrate {200.0} \
 ] $axi_ethernet_0

  # Create instance: axi_timer_0, and set properties
  set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]
  set_property -dict [ list \
   CONFIG.enable_timer2 {0} \
 ] $axi_timer_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKOUT1_JITTER {125.247} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125.000} \
   CONFIG.CLKOUT2_JITTER {104.542} \
   CONFIG.CLKOUT2_PHASE_ERROR {98.575} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {333.000} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {8.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {3} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.RESET_PORT {resetn} \
   CONFIG.RESET_TYPE {ACTIVE_LOW} \
 ] $clk_wiz_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins eth_s_axi_tmr] [get_bd_intf_pins axi_timer_0/S_AXI]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_CNTRL [get_bd_intf_pins axi_dma_0/M_AXIS_CNTRL] [get_bd_intf_pins axi_ethernet_0/s_axis_txc]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axi_ethernet_0/s_axis_txd]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins M_AXI_MM2S] [get_bd_intf_pins axi_dma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_S2MM [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins axi_dma_0/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_SG [get_bd_intf_pins M_AXI_SG] [get_bd_intf_pins axi_dma_0/M_AXI_SG]
  connect_bd_intf_net -intf_net axi_ethernet_0_m_axis_rxd [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM] [get_bd_intf_pins axi_ethernet_0/m_axis_rxd]
  connect_bd_intf_net -intf_net axi_ethernet_0_m_axis_rxs [get_bd_intf_pins axi_dma_0/S_AXIS_STS] [get_bd_intf_pins axi_ethernet_0/m_axis_rxs]
  connect_bd_intf_net -intf_net axi_ethernet_0_mdio [get_bd_intf_pins mdio] [get_bd_intf_pins axi_ethernet_0/mdio]
  connect_bd_intf_net -intf_net axi_ethernet_0_rgmii [get_bd_intf_pins rgmii] [get_bd_intf_pins axi_ethernet_0/rgmii]
  connect_bd_intf_net -intf_net eth_s_axi_dma [get_bd_intf_pins eth_s_axi_dma] [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net eth_s_axi_xeth [get_bd_intf_pins eth_s_axi_xeth] [get_bd_intf_pins axi_ethernet_0/s_axi]

  # Create port connections
  connect_bd_net -net aclk [get_bd_pins aclk] [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] [get_bd_pins axi_dma_0/m_axi_sg_aclk] [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins axi_ethernet_0/axis_clk] [get_bd_pins axi_ethernet_0/s_axi_lite_clk] [get_bd_pins axi_timer_0/s_axi_aclk]
  connect_bd_net -net aresetn [get_bd_pins aresetn] [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins axi_ethernet_0/s_axi_lite_resetn] [get_bd_pins axi_timer_0/s_axi_aresetn]
  connect_bd_net -net axi_dma_0_mm2s_cntrl_reset_out_n [get_bd_pins axi_dma_0/mm2s_cntrl_reset_out_n] [get_bd_pins axi_ethernet_0/axi_txc_arstn]
  connect_bd_net -net axi_dma_0_mm2s_introut [get_bd_pins mm2s_irq] [get_bd_pins axi_dma_0/mm2s_introut]
  connect_bd_net -net axi_dma_0_mm2s_prmry_reset_out_n [get_bd_pins axi_dma_0/mm2s_prmry_reset_out_n] [get_bd_pins axi_ethernet_0/axi_txd_arstn]
  connect_bd_net -net axi_dma_0_s2mm_introut [get_bd_pins s2mm_irq] [get_bd_pins axi_dma_0/s2mm_introut]
  connect_bd_net -net axi_dma_0_s2mm_prmry_reset_out_n [get_bd_pins axi_dma_0/s2mm_prmry_reset_out_n] [get_bd_pins axi_ethernet_0/axi_rxd_arstn]
  connect_bd_net -net axi_dma_0_s2mm_sts_reset_out_n [get_bd_pins axi_dma_0/s2mm_sts_reset_out_n] [get_bd_pins axi_ethernet_0/axi_rxs_arstn]
  connect_bd_net -net axi_ethernet_0_interrupt [get_bd_pins ethernet_irq] [get_bd_pins axi_ethernet_0/interrupt]
  connect_bd_net -net axi_ethernet_0_mac_irq [get_bd_pins mac_irq] [get_bd_pins axi_ethernet_0/mac_irq]
  connect_bd_net -net axi_ethernet_0_phy_rst_n [get_bd_pins phy_reset_out] [get_bd_pins axi_ethernet_0/phy_rst_n]
  connect_bd_net -net axi_timer_0_interrupt [get_bd_pins tmr_irq] [get_bd_pins axi_timer_0/interrupt]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins axi_ethernet_0/gtx_clk] [get_bd_pins clk_wiz_0/clk_out1]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins axi_ethernet_0/ref_clk] [get_bd_pins clk_wiz_0/clk_out2]
  connect_bd_net -net clk_wiz_clk_in [get_bd_pins clk_wiz_clk_in] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net clk_wiz_resetn [get_bd_pins clk_wiz_resetn] [get_bd_pins clk_wiz_0/resetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: clock_and_memory_subsystem
proc create_hier_cell_clock_and_memory_subsystem { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_clock_and_memory_subsystem() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 AXIS_video_in

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 C0_DDR4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S01_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S02_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S03_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S04_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S05_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTRL

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_clk


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 -type rst LMB_reset
  create_bd_pin -dir I -type clk S05_ACLK
  create_bd_pin -dir I -type rst S05_ARESETN
  create_bd_pin -dir O -type clk aclk_100m
  create_bd_pin -dir O -from 0 -to 0 -type rst aresetn_100m
  create_bd_pin -dir O -from 0 -to 0 -type rst aresetn_300m
  create_bd_pin -dir O -type clk c0_ddr4_ui_clk
  create_bd_pin -dir O c0_init_calib_complete
  create_bd_pin -dir I dcm_locked
  create_bd_pin -dir I -type rst ext_reset_in
  create_bd_pin -dir I -type rst mb_debug_sys_rst
  create_bd_pin -dir O -type rst mb_reset
  create_bd_pin -dir O -from 0 -to 0 -type rst reset_300m
  create_bd_pin -dir I -type rst sys_rst

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
   CONFIG.M00_HAS_DATA_FIFO {2} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {7} \
   CONFIG.S00_HAS_DATA_FIFO {2} \
   CONFIG.S01_HAS_DATA_FIFO {2} \
   CONFIG.S02_HAS_DATA_FIFO {2} \
   CONFIG.S03_HAS_DATA_FIFO {2} \
   CONFIG.S05_HAS_DATA_FIFO {2} \
   CONFIG.S06_HAS_DATA_FIFO {2} \
   CONFIG.S07_HAS_DATA_FIFO {2} \
   CONFIG.STRATEGY {2} \
   CONFIG.XBAR_DATA_WIDTH {512} \
 ] $axi_interconnect_0

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_0 ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s {0} \
   CONFIG.c_m_axis_mm2s_tdata_width {32} \
   CONFIG.c_mm2s_genlock_mode {0} \
   CONFIG.c_mm2s_max_burst_length {8} \
   CONFIG.c_s2mm_max_burst_length {64} \
 ] $axi_vdma_0

  # Create instance: axis_passthrough_mon_0, and set properties
  set axis_passthrough_mon_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:axis_passthrough_monitor:1.0 axis_passthrough_mon_0 ]
  set_property -dict [ list \
   CONFIG.AXIS_WIDTH {48} \
   CONFIG.TKEEP_WIDTH {1} \
   CONFIG.TSTRB_WIDTH {1} \
 ] $axis_passthrough_mon_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ROUTING_MODE {1} \
 ] $axis_switch_0

  # Create instance: ddr4_0, and set properties
  set ddr4_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_0 ]
  set_property -dict [ list \
   CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {100} \
   CONFIG.ADDN_UI_CLKOUT2_FREQ_HZ {None} \
   CONFIG.ADDN_UI_CLKOUT3_FREQ_HZ {None} \
   CONFIG.C0.BANK_GROUP_WIDTH {1} \
   CONFIG.C0.DDR4_AxiAddressWidth {31} \
   CONFIG.C0.DDR4_AxiDataWidth {256} \
   CONFIG.C0.DDR4_CasLatency {18} \
   CONFIG.C0.DDR4_DataWidth {32} \
   CONFIG.C0.DDR4_InputClockPeriod {4998} \
   CONFIG.C0.DDR4_MemoryPart {MT40A512M16HA-083E} \
   CONFIG.C0.DDR4_isCustom {false} \
   CONFIG.System_Clock {Differential} \
 ] $ddr4_0

  # Create instance: rst_mig_ui_300M, and set properties
  set rst_mig_ui_300M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_mig_ui_300M ]
  set_property -dict [ list \
   CONFIG.C_AUX_RST_WIDTH {1} \
   CONFIG.C_EXT_RST_WIDTH {1} \
 ] $rst_mig_ui_300M

  # Create instance: rst_system_aclk, and set properties
  set rst_system_aclk [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_system_aclk ]
  set_property -dict [ list \
   CONFIG.C_AUX_RST_WIDTH {1} \
   CONFIG.C_EXT_RST_WIDTH {1} \
 ] $rst_system_aclk

  # Create instance: v_tpg_0, and set properties
  set v_tpg_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg:8.0 v_tpg_0 ]
  set_property -dict [ list \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_tpg_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S05_AXI] [get_bd_intf_pins axi_interconnect_0/S05_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins AXIS_video_in] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net M_AXI_DC_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net M_AXI_IC_1 [get_bd_intf_pins S01_AXI] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net S04_AXI_1 [get_bd_intf_pins S02_AXI] [get_bd_intf_pins axi_interconnect_0/S02_AXI]
  connect_bd_intf_net -intf_net S05_AXI_1 [get_bd_intf_pins S03_AXI] [get_bd_intf_pins axi_interconnect_0/S03_AXI]
  connect_bd_intf_net -intf_net S06_AXI_1 [get_bd_intf_pins S04_AXI] [get_bd_intf_pins axi_interconnect_0/S04_AXI]
  connect_bd_intf_net -intf_net S_AXI_CTRL_1 [get_bd_intf_pins S_AXI_CTRL] [get_bd_intf_pins axis_switch_0/S_AXI_CTRL]
  connect_bd_intf_net -intf_net S_AXI_LITE_1 [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins axi_vdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins ddr4_0/C0_DDR4_S_AXI]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_S2MM [get_bd_intf_pins axi_interconnect_0/S06_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axis_passthrough_mon_0_m_axis [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM] [get_bd_intf_pins axis_passthrough_mon_0/m_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_passthrough_mon_0/s_axis] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net ddr4_0_C0_DDR4 [get_bd_intf_pins C0_DDR4] [get_bd_intf_pins ddr4_0/C0_DDR4]
  connect_bd_intf_net -intf_net s_axi_CTRL1_1 [get_bd_intf_pins s_axi_CTRL1] [get_bd_intf_pins v_tpg_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net s_axi_lite1_1 [get_bd_intf_pins s_axi_lite1] [get_bd_intf_pins axis_passthrough_mon_0/s_axi_lite]
  connect_bd_intf_net -intf_net sys_1 [get_bd_intf_pins sys_clk] [get_bd_intf_pins ddr4_0/C0_SYS_CLK]
  connect_bd_intf_net -intf_net v_tpg_0_m_axis_video [get_bd_intf_pins axis_switch_0/S01_AXIS] [get_bd_intf_pins v_tpg_0/m_axis_video]

  # Create port connections
  connect_bd_net -net S05_ACLK_1 [get_bd_pins S05_ACLK] [get_bd_pins axi_interconnect_0/S05_ACLK]
  connect_bd_net -net S05_ARESETN_1 [get_bd_pins S05_ARESETN] [get_bd_pins axi_interconnect_0/S05_ARESETN]
  connect_bd_net -net dcm_locked_1 [get_bd_pins dcm_locked] [get_bd_pins rst_system_aclk/dcm_locked]
  connect_bd_net -net ddr4_0_addn_ui_clkout1 [get_bd_pins aclk_100m] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_interconnect_0/S02_ACLK] [get_bd_pins axi_interconnect_0/S03_ACLK] [get_bd_pins axi_interconnect_0/S04_ACLK] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axis_passthrough_mon_0/s_axi_lite_aclk] [get_bd_pins axis_switch_0/s_axi_ctrl_aclk] [get_bd_pins ddr4_0/addn_ui_clkout1] [get_bd_pins rst_system_aclk/slowest_sync_clk]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk_sync_rst [get_bd_pins ddr4_0/c0_ddr4_ui_clk_sync_rst] [get_bd_pins rst_mig_ui_300M/ext_reset_in] [get_bd_pins rst_system_aclk/aux_reset_in]
  connect_bd_net -net ddr4_0_c0_init_calib_complete [get_bd_pins c0_init_calib_complete] [get_bd_pins ddr4_0/c0_init_calib_complete]
  connect_bd_net -net ext_reset_in_1 [get_bd_pins ext_reset_in] [get_bd_pins rst_system_aclk/ext_reset_in]
  connect_bd_net -net mb_debug_sys_rst_1 [get_bd_pins mb_debug_sys_rst] [get_bd_pins rst_system_aclk/mb_debug_sys_rst]
  connect_bd_net -net mig_7series_0_ui_clk [get_bd_pins c0_ddr4_ui_clk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S06_ACLK] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk] [get_bd_pins axis_passthrough_mon_0/aclk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins ddr4_0/c0_ddr4_ui_clk] [get_bd_pins rst_mig_ui_300M/slowest_sync_clk] [get_bd_pins v_tpg_0/ap_clk]
  connect_bd_net -net rst_mig_0_300M_interconnect_aresetn [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S06_ARESETN] [get_bd_pins rst_mig_ui_300M/interconnect_aresetn]
  connect_bd_net -net rst_mig_7series_0_100M_peripheral_aresetn1 [get_bd_pins aresetn_300m] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axis_passthrough_mon_0/aresetn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins ddr4_0/c0_ddr4_aresetn] [get_bd_pins rst_mig_ui_300M/peripheral_aresetn] [get_bd_pins v_tpg_0/ap_rst_n]
  connect_bd_net -net rst_mig_ui_300M_peripheral_reset [get_bd_pins reset_300m] [get_bd_pins rst_mig_ui_300M/peripheral_reset]
  connect_bd_net -net rst_system_aclk_peripheral_aresetn [get_bd_pins aresetn_100m] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_interconnect_0/S02_ARESETN] [get_bd_pins axi_interconnect_0/S03_ARESETN] [get_bd_pins axi_interconnect_0/S04_ARESETN] [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axis_passthrough_mon_0/s_axi_lite_aresetn] [get_bd_pins axis_switch_0/s_axi_ctrl_aresetn] [get_bd_pins rst_system_aclk/peripheral_aresetn]
  connect_bd_net -net rst_system_bus_struct_reset [get_bd_pins LMB_reset] [get_bd_pins rst_system_aclk/bus_struct_reset]
  connect_bd_net -net rst_system_mb_reset [get_bd_pins mb_reset] [get_bd_pins rst_system_aclk/mb_reset]
  connect_bd_net -net sys_rst_1 [get_bd_pins sys_rst] [get_bd_pins ddr4_0/sys_rst]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set C0_DDR4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 C0_DDR4 ]

  set i2c_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c_0 ]

  set mdio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio ]

  set pcie_mgt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_mgt ]

  set pcie_sys_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_sys_clk ]

  set rgmii [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii ]

  set sys [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $sys

  set uart_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_0 ]

  set uart_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_1 ]


  # Create ports
  set ch0_clkin0_n [ create_bd_port -dir I ch0_clkin0_n ]
  set ch0_clkin0_p [ create_bd_port -dir I ch0_clkin0_p ]
  set ch0_clkin1_n [ create_bd_port -dir I ch0_clkin1_n ]
  set ch0_clkin1_p [ create_bd_port -dir I ch0_clkin1_p ]
  set ch0_datain0_n [ create_bd_port -dir I -from 3 -to 0 ch0_datain0_n ]
  set ch0_datain0_p [ create_bd_port -dir I -from 3 -to 0 ch0_datain0_p ]
  set ch0_datain1_n [ create_bd_port -dir I -from 3 -to 0 ch0_datain1_n ]
  set ch0_datain1_p [ create_bd_port -dir I -from 3 -to 0 ch0_datain1_p ]
  set pcie_resetn [ create_bd_port -dir I -type rst pcie_resetn ]
  set phy_reset_out [ create_bd_port -dir O -from 0 -to 0 -type rst phy_reset_out ]

  # Create instance: GND, and set properties
  set GND [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $GND

  # Create instance: HW_VER, and set properties
  set HW_VER [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 HW_VER ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x24070414} \
   CONFIG.CONST_WIDTH {32} \
 ] $HW_VER

  # Create instance: VCC, and set properties
  set VCC [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 VCC ]

  # Create instance: clock_and_memory_subsystem
  create_hier_cell_clock_and_memory_subsystem [current_bd_instance .] clock_and_memory_subsystem

  # Create instance: ethernet_subsystem
  create_hier_cell_ethernet_subsystem [current_bd_instance .] ethernet_subsystem

  # Create instance: oldi_in
  create_hier_cell_oldi_in [current_bd_instance .] oldi_in

  # Create instance: pcie_hier_0
  create_hier_cell_pcie_hier_0 [current_bd_instance .] pcie_hier_0

  # Create instance: processor_subsystem
  create_hier_cell_processor_subsystem [current_bd_instance .] processor_subsystem

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins clock_and_memory_subsystem/S00_AXI] [get_bd_intf_pins processor_subsystem/M_AXI_DC]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins clock_and_memory_subsystem/S01_AXI] [get_bd_intf_pins processor_subsystem/M_AXI_IC]
  connect_bd_intf_net -intf_net S01_AXI_2 [get_bd_intf_pins pcie_hier_0/M_AXI_LITE] [get_bd_intf_pins processor_subsystem/S01_AXI]
  connect_bd_intf_net -intf_net S05_AXI_1 [get_bd_intf_pins clock_and_memory_subsystem/S05_AXI] [get_bd_intf_pins pcie_hier_0/M_AXI]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets S05_AXI_1]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins clock_and_memory_subsystem/S02_AXI] [get_bd_intf_pins ethernet_subsystem/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_S2MM [get_bd_intf_pins clock_and_memory_subsystem/S03_AXI] [get_bd_intf_pins ethernet_subsystem/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_SG [get_bd_intf_pins clock_and_memory_subsystem/S04_AXI] [get_bd_intf_pins ethernet_subsystem/M_AXI_SG]
  connect_bd_intf_net -intf_net axi_ethernet_0_mdio [get_bd_intf_ports mdio] [get_bd_intf_pins ethernet_subsystem/mdio]
  connect_bd_intf_net -intf_net axi_ethernet_0_rgmii [get_bd_intf_ports rgmii] [get_bd_intf_pins ethernet_subsystem/rgmii]
  connect_bd_intf_net -intf_net ddr4_0_C0_DDR4 [get_bd_intf_ports C0_DDR4] [get_bd_intf_pins clock_and_memory_subsystem/C0_DDR4]
  connect_bd_intf_net -intf_net oldi_in_video_out [get_bd_intf_pins clock_and_memory_subsystem/AXIS_video_in] [get_bd_intf_pins oldi_in/video_out]
  connect_bd_intf_net -intf_net pcie_hier_0_pcie_mgt [get_bd_intf_ports pcie_mgt] [get_bd_intf_pins pcie_hier_0/pcie_mgt]
  connect_bd_intf_net -intf_net pcie_sys_clk_1 [get_bd_intf_ports pcie_sys_clk] [get_bd_intf_pins pcie_hier_0/pcie_sys_clk]
  connect_bd_intf_net -intf_net processor_subsystem_M04_AXI [get_bd_intf_pins ethernet_subsystem/eth_s_axi_tmr] [get_bd_intf_pins processor_subsystem/eth_m_axi_tmr]
  connect_bd_intf_net -intf_net processor_subsystem_M09_AXI [get_bd_intf_pins clock_and_memory_subsystem/S_AXI_LITE] [get_bd_intf_pins processor_subsystem/M09_AXI]
  connect_bd_intf_net -intf_net processor_subsystem_M10_AXI [get_bd_intf_pins clock_and_memory_subsystem/s_axi_lite1] [get_bd_intf_pins processor_subsystem/M10_AXI]
  connect_bd_intf_net -intf_net processor_subsystem_M11_AXI [get_bd_intf_pins clock_and_memory_subsystem/S_AXI_CTRL] [get_bd_intf_pins processor_subsystem/M11_AXI]
  connect_bd_intf_net -intf_net processor_subsystem_M12_AXI [get_bd_intf_pins clock_and_memory_subsystem/s_axi_CTRL1] [get_bd_intf_pins processor_subsystem/M12_AXI]
  connect_bd_intf_net -intf_net processor_subsystem_M22_AXI1 [get_bd_intf_pins ethernet_subsystem/eth_s_axi_dma] [get_bd_intf_pins processor_subsystem/eth_m_axi_dma]
  connect_bd_intf_net -intf_net processor_subsystem_M23_AXI1 [get_bd_intf_pins ethernet_subsystem/eth_s_axi_xeth] [get_bd_intf_pins processor_subsystem/eth_m_axi_xeth]
  connect_bd_intf_net -intf_net processor_subsystem_UART_1 [get_bd_intf_ports uart_0] [get_bd_intf_pins processor_subsystem/uart_0]
  connect_bd_intf_net -intf_net processor_subsystem_UART_2 [get_bd_intf_ports uart_1] [get_bd_intf_pins processor_subsystem/uart_1]
  connect_bd_intf_net -intf_net processor_subsystem_i2c_0 [get_bd_intf_ports i2c_0] [get_bd_intf_pins processor_subsystem/i2c_0]
  connect_bd_intf_net -intf_net sys_1 [get_bd_intf_ports sys] [get_bd_intf_pins clock_and_memory_subsystem/sys_clk]

  # Create port connections
  connect_bd_net -net GND_dout [get_bd_pins GND/dout] [get_bd_pins clock_and_memory_subsystem/sys_rst] [get_bd_pins pcie_hier_0/usr_irq_req]
  connect_bd_net -net HW_VER_dout [get_bd_pins HW_VER/dout] [get_bd_pins processor_subsystem/VERSION]
  connect_bd_net -net In4_1 [get_bd_pins ethernet_subsystem/tmr_irq] [get_bd_pins processor_subsystem/ethernet_tmr_irq]
  connect_bd_net -net LMB_Rst_1 [get_bd_pins clock_and_memory_subsystem/LMB_reset] [get_bd_pins processor_subsystem/LMB_reset]
  connect_bd_net -net Reset_2 [get_bd_pins clock_and_memory_subsystem/mb_reset] [get_bd_pins processor_subsystem/mb_reset]
  connect_bd_net -net VCC_dout [get_bd_pins VCC/dout] [get_bd_pins clock_and_memory_subsystem/dcm_locked] [get_bd_pins clock_and_memory_subsystem/ext_reset_in] [get_bd_pins ethernet_subsystem/clk_wiz_resetn] [get_bd_pins oldi_in/axis_enable]
  connect_bd_net -net axi_dma_0_mm2s_introut [get_bd_pins ethernet_subsystem/mm2s_irq] [get_bd_pins processor_subsystem/ethernet_dma_mm2s_irq]
  connect_bd_net -net axi_dma_0_s2mm_introut [get_bd_pins ethernet_subsystem/s2mm_irq] [get_bd_pins processor_subsystem/ethernet_dma_s2mm_irq]
  connect_bd_net -net axi_ethernet_0_interrupt [get_bd_pins ethernet_subsystem/ethernet_irq] [get_bd_pins processor_subsystem/ethernet_irq]
  connect_bd_net -net axi_ethernet_0_mac_irq [get_bd_pins ethernet_subsystem/mac_irq] [get_bd_pins processor_subsystem/ethernet_mac_irq]
  connect_bd_net -net axi_ethernet_0_phy_rst_n [get_bd_ports phy_reset_out] [get_bd_pins ethernet_subsystem/phy_reset_out]
  connect_bd_net -net clkin1_n_0_1 [get_bd_ports ch0_clkin0_n] [get_bd_pins oldi_in/ch0_clkin0_n]
  connect_bd_net -net clkin1_p_0_1 [get_bd_ports ch0_clkin0_p] [get_bd_pins oldi_in/ch0_clkin0_p]
  connect_bd_net -net clkin2_n_0_1 [get_bd_ports ch0_clkin1_n] [get_bd_pins oldi_in/ch0_clkin1_n]
  connect_bd_net -net clkin2_p_0_1 [get_bd_ports ch0_clkin1_p] [get_bd_pins oldi_in/ch0_clkin1_p]
  connect_bd_net -net clock_and_memory_subsystem_c0_ddr4_ui_clk [get_bd_pins clock_and_memory_subsystem/c0_ddr4_ui_clk] [get_bd_pins oldi_in/aclk] [get_bd_pins processor_subsystem/M12_ACLK]
  connect_bd_net -net clock_and_memory_subsystem_peripheral_aresetn [get_bd_pins clock_and_memory_subsystem/aresetn_300m] [get_bd_pins oldi_in/aresetn] [get_bd_pins processor_subsystem/M12_ARESETN]
  connect_bd_net -net clock_and_memory_subsystem_peripheral_reset [get_bd_pins clock_and_memory_subsystem/reset_300m] [get_bd_pins oldi_in/reset]
  connect_bd_net -net datain1_n_0_1 [get_bd_ports ch0_datain0_n] [get_bd_pins oldi_in/ch0_datain0_n]
  connect_bd_net -net datain1_p_0_1 [get_bd_ports ch0_datain0_p] [get_bd_pins oldi_in/ch0_datain0_p]
  connect_bd_net -net datain2_n_0_1 [get_bd_ports ch0_datain1_n] [get_bd_pins oldi_in/ch0_datain1_n]
  connect_bd_net -net datain2_p_0_1 [get_bd_ports ch0_datain1_p] [get_bd_pins oldi_in/ch0_datain1_p]
  connect_bd_net -net ddr4_0_addn_ui_clkout1 [get_bd_pins clock_and_memory_subsystem/aclk_100m] [get_bd_pins ethernet_subsystem/aclk] [get_bd_pins ethernet_subsystem/clk_wiz_clk_in] [get_bd_pins processor_subsystem/aclk]
  connect_bd_net -net pcie_resetn_1 [get_bd_ports pcie_resetn] [get_bd_pins pcie_hier_0/pcie_resetn]
  connect_bd_net -net processor_subsystem_mb_debug_sys_rst [get_bd_pins clock_and_memory_subsystem/mb_debug_sys_rst] [get_bd_pins processor_subsystem/mb_debug_sys_rst]
  connect_bd_net -net rst_system_peripheral_aresetn [get_bd_pins clock_and_memory_subsystem/aresetn_100m] [get_bd_pins ethernet_subsystem/aresetn] [get_bd_pins processor_subsystem/aresetn]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_pins clock_and_memory_subsystem/S05_ACLK] [get_bd_pins pcie_hier_0/axi_aclk] [get_bd_pins processor_subsystem/S01_ACLK]
  connect_bd_net -net xdma_0_axi_aresetn [get_bd_pins clock_and_memory_subsystem/S05_ARESETN] [get_bd_pins pcie_hier_0/axi_aresetn] [get_bd_pins processor_subsystem/S01_ARESETN]

  # Create address segments
  assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces clock_and_memory_subsystem/axi_vdma_0/Data_S2MM] [get_bd_addr_segs clock_and_memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ethernet_subsystem/axi_dma_0/Data_SG] [get_bd_addr_segs clock_and_memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ethernet_subsystem/axi_dma_0/Data_MM2S] [get_bd_addr_segs clock_and_memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces ethernet_subsystem/axi_dma_0/Data_S2MM] [get_bd_addr_segs clock_and_memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x40000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/AXI_LITE_REG_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x41E00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs ethernet_subsystem/axi_dma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x40C00000 -range 0x00040000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs ethernet_subsystem/axi_ethernet_0/s_axi/Reg0] -force
  assign_bd_address -offset 0x40800000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A20000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/axi_quad_spi_0/AXI_LITE/Reg] -force
  assign_bd_address -offset 0x41C00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs ethernet_subsystem/axi_timer_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40600000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/axi_uartlite_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40610000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/axi_uartlite_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs clock_and_memory_subsystem/axi_vdma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x44A10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs clock_and_memory_subsystem/axis_passthrough_mon_0/s_axi_lite/s_axi_lite_reg] -force
  assign_bd_address -offset 0x44A30000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs clock_and_memory_subsystem/axis_switch_0/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI] [get_bd_addr_segs clock_and_memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/microblaze_0_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A40000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier_0/xdma_0/M_AXI_LITE] [get_bd_addr_segs clock_and_memory_subsystem/v_tpg_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0x40000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/AXI_LITE_REG_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x41E00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs ethernet_subsystem/axi_dma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x40C00000 -range 0x00040000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs ethernet_subsystem/axi_ethernet_0/s_axi/Reg0] -force
  assign_bd_address -offset 0x40800000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A20000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/axi_quad_spi_0/AXI_LITE/Reg] -force
  assign_bd_address -offset 0x41C00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs ethernet_subsystem/axi_timer_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40600000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/axi_uartlite_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40610000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/axi_uartlite_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs clock_and_memory_subsystem/axi_vdma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x44A10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs clock_and_memory_subsystem/axis_passthrough_mon_0/s_axi_lite/s_axi_lite_reg] -force
  assign_bd_address -offset 0x44A30000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs clock_and_memory_subsystem/axis_switch_0/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs clock_and_memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Instruction] [get_bd_addr_segs clock_and_memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x00000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Instruction] [get_bd_addr_segs processor_subsystem/microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/microblaze_0_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A40000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs clock_and_memory_subsystem/v_tpg_0/s_axi_CTRL/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


