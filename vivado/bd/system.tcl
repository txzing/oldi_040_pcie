
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


# The design that will be created by this Tcl script contains the following 
# module references:
# pcie_irq_deal

# Please add the sources of those modules before sourcing this Tcl script.

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
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:system_ila:1.1\
xilinx.com:ip:axi_vdma:6.3\
xilinx.com:ip:axis_clock_converter:1.1\
xilinx.com:user:axis_passthrough_monitor:1.0\
xilinx.com:ip:axis_subset_converter:1.1\
xilinx.com:ip:axis_switch:1.1\
xilinx.com:ip:ddr4:2.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:v_tpg:8.0\
user.org:user:lvds4x2_1to7:1.0\
xilinx.com:ip:v_vid_in_axi4s:4.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:xdma:4.1\
xilinx.com:user:AXI_LITE_REG:1.0\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:axi_quad_spi:3.2\
xilinx.com:ip:axi_timer:2.0\
xilinx.com:ip:axi_uartlite:2.0\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:axi_intc:4.1\
alinx.com.cn:user:xgpio_to_i2c:1.0\
xilinx.com:ip:xlslice:1.0\
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

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
pcie_irq_deal\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
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
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB


  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

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
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: xgpio_i2c_0
proc create_hier_cell_xgpio_i2c_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_xgpio_i2c_0() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c_1


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS_2 {0} \
   CONFIG.C_GPIO2_WIDTH {32} \
   CONFIG.C_GPIO_WIDTH {4} \
   CONFIG.C_IS_DUAL {0} \
 ] $axi_gpio_0

  # Create instance: xgpio_to_i2c_0, and set properties
  set xgpio_to_i2c_0 [ create_bd_cell -type ip -vlnv alinx.com.cn:user:xgpio_to_i2c:1.0 xgpio_to_i2c_0 ]

  # Create instance: xgpio_to_i2c_1, and set properties
  set xgpio_to_i2c_1 [ create_bd_cell -type ip -vlnv alinx.com.cn:user:xgpio_to_i2c:1.0 xgpio_to_i2c_1 ]

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_1

  # Create instance: xlslice_O0, and set properties
  set xlslice_O0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_O0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_O0

  # Create instance: xlslice_O1, and set properties
  set xlslice_O1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_O1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_O1

  # Create instance: xlslice_O2, and set properties
  set xlslice_O2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_O2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_O2

  # Create instance: xlslice_O3, and set properties
  set xlslice_O3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_O3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_O3

  # Create instance: xlslice_T0, and set properties
  set xlslice_T0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_T0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_T0

  # Create instance: xlslice_T1, and set properties
  set xlslice_T1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_T1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_T1

  # Create instance: xlslice_T2, and set properties
  set xlslice_T2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_T2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_T2

  # Create instance: xlslice_T3, and set properties
  set xlslice_T3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_T3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_T3

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_gpio_0/S_AXI]
  connect_bd_intf_net -intf_net xgpio_to_i2c_0_i2c_down [get_bd_intf_pins i2c_0] [get_bd_intf_pins xgpio_to_i2c_0/i2c_down]
  connect_bd_intf_net -intf_net xgpio_to_i2c_1_i2c_down [get_bd_intf_pins i2c_1] [get_bd_intf_pins xgpio_to_i2c_1/i2c_down]

  # Create port connections
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins axi_gpio_0/gpio_io_o] [get_bd_pins xlslice_O0/Din] [get_bd_pins xlslice_O1/Din] [get_bd_pins xlslice_O2/Din] [get_bd_pins xlslice_O3/Din]
  connect_bd_net -net axi_gpio_0_gpio_io_t [get_bd_pins axi_gpio_0/gpio_io_t] [get_bd_pins xlslice_T0/Din] [get_bd_pins xlslice_T1/Din] [get_bd_pins xlslice_T2/Din] [get_bd_pins xlslice_T3/Din]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn]
  connect_bd_net -net xgpio_to_i2c_0_upstream_scl_0 [get_bd_pins xgpio_to_i2c_0/upstream_scl_O] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net xgpio_to_i2c_0_upstream_scl_1 [get_bd_pins xgpio_to_i2c_1/upstream_scl_O] [get_bd_pins xlconcat_1/In3]
  connect_bd_net -net xgpio_to_i2c_0_upstream_sda_0 [get_bd_pins xgpio_to_i2c_0/upstream_sda_O] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net xgpio_to_i2c_0_upstream_sda_1 [get_bd_pins xgpio_to_i2c_1/upstream_sda_O] [get_bd_pins xlconcat_1/In2]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins axi_gpio_0/gpio_io_i] [get_bd_pins xlconcat_1/dout]
  connect_bd_net -net xlslice_O0_Dout [get_bd_pins xgpio_to_i2c_0/upstream_sda_I] [get_bd_pins xlslice_O0/Dout]
  connect_bd_net -net xlslice_O1_Dout [get_bd_pins xgpio_to_i2c_0/upstream_scl_I] [get_bd_pins xlslice_O1/Dout]
  connect_bd_net -net xlslice_O2_Dout [get_bd_pins xgpio_to_i2c_1/upstream_sda_I] [get_bd_pins xlslice_O2/Dout]
  connect_bd_net -net xlslice_O3_Dout [get_bd_pins xgpio_to_i2c_1/upstream_scl_I] [get_bd_pins xlslice_O3/Dout]
  connect_bd_net -net xlslice_T0_Dout [get_bd_pins xgpio_to_i2c_0/upstream_sda_T] [get_bd_pins xlslice_T0/Dout]
  connect_bd_net -net xlslice_T1_Dout [get_bd_pins xgpio_to_i2c_0/upstream_scl_T] [get_bd_pins xlslice_T1/Dout]
  connect_bd_net -net xlslice_T2_Dout [get_bd_pins xgpio_to_i2c_1/upstream_sda_T] [get_bd_pins xlslice_T2/Dout]
  connect_bd_net -net xlslice_T3_Dout [get_bd_pins xgpio_to_i2c_1/upstream_scl_T] [get_bd_pins xlslice_T3/Dout]

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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M06_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M07_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M08_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M09_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M10_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M11_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_DC

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_IC

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S01_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart_1


  # Create pins
  create_bd_pin -dir I -type clk S01_ACLK
  create_bd_pin -dir I -type rst S01_ARESETN
  create_bd_pin -dir I -from 31 -to 0 VERSION
  create_bd_pin -dir I dcm_locked
  create_bd_pin -dir I -type rst ext_reset_in
  create_bd_pin -dir O -type rst mb_debug_sys_rst
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn
  create_bd_pin -dir I -type clk s00_axi_aclk
  create_bd_pin -dir I -from 0 -to 0 -type intr s2mm_introut

  # Create instance: AXI_LITE_REG_0, and set properties
  set AXI_LITE_REG_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:AXI_LITE_REG:1.0 AXI_LITE_REG_0 ]

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {0} \
   CONFIG.C_GPIO_WIDTH {1} \
 ] $axi_gpio_0

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

  # Create instance: axi_timer_0, and set properties
  set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]

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
 ] $axi_uartlite_1

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {15} \
   CONFIG.C_CACHE_BYTE_SIZE {65536} \
   CONFIG.C_DCACHE_ADDR_TAG {15} \
   CONFIG.C_DCACHE_BYTE_SIZE {65536} \
   CONFIG.C_DCACHE_LINE_LEN {8} \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_ICACHE_LINE_LEN {8} \
   CONFIG.C_I_LMB {1} \
   CONFIG.C_USE_DCACHE {1} \
   CONFIG.C_USE_ICACHE {1} \
   CONFIG.C_USE_MMU {0} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
   CONFIG.C_HAS_FAST {1} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
   CONFIG.NUM_MI {13} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_HAS_REGSLICE {3} \
   CONFIG.S01_HAS_REGSLICE {3} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory $hier_obj microblaze_0_local_memory

  # Create instance: microblaze_0_xlconcat, and set properties
  set microblaze_0_xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 microblaze_0_xlconcat ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {4} \
 ] $microblaze_0_xlconcat

  # Create instance: rst_system, and set properties
  set rst_system [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_system ]
  set_property -dict [ list \
   CONFIG.C_AUX_RST_WIDTH {1} \
   CONFIG.C_EXT_RST_WIDTH {1} \
 ] $rst_system

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M10_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M10_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M06_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins M07_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins M08_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins M09_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M09_AXI]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins M11_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M11_AXI]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins S01_AXI] [get_bd_intf_pins microblaze_0_axi_periph/S01_AXI]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_pins gpio] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_intc_0_interrupt [get_bd_intf_pins microblaze_0/INTERRUPT] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_pins uart_0] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net axi_uartlite_1_UART [get_bd_intf_pins uart_1] [get_bd_intf_pins axi_uartlite_1/UART]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DC [get_bd_intf_pins M_AXI_DC] [get_bd_intf_pins microblaze_0/M_AXI_DC]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_IC [get_bd_intf_pins M_AXI_IC] [get_bd_intf_pins microblaze_0/M_AXI_IC]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins AXI_LITE_REG_0/S00_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins axi_quad_spi_0/AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins axi_uartlite_1/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M12_AXI [get_bd_intf_pins axi_timer_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M12_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]

  # Create port connections
  connect_bd_net -net In3_1 [get_bd_pins s2mm_introut] [get_bd_pins microblaze_0_xlconcat/In3]
  connect_bd_net -net S01_ACLK_1 [get_bd_pins S01_ACLK] [get_bd_pins microblaze_0_axi_periph/S01_ACLK]
  connect_bd_net -net S01_ARESETN_1 [get_bd_pins S01_ARESETN] [get_bd_pins microblaze_0_axi_periph/S01_ARESETN]
  connect_bd_net -net axi_quad_spi_0_ip2intc_irpt [get_bd_pins axi_quad_spi_0/ip2intc_irpt] [get_bd_pins microblaze_0_xlconcat/In1]
  connect_bd_net -net axi_timer_0_interrupt [get_bd_pins axi_timer_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In2]
  connect_bd_net -net axi_uartlite_0_interrupt [get_bd_pins axi_uartlite_0/interrupt] [get_bd_pins microblaze_0_xlconcat/In0]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins s00_axi_aclk] [get_bd_pins AXI_LITE_REG_0/s00_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_quad_spi_0/ext_spi_clk] [get_bd_pins axi_quad_spi_0/s_axi_aclk] [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins axi_uartlite_1/s_axi_aclk] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/M06_ACLK] [get_bd_pins microblaze_0_axi_periph/M07_ACLK] [get_bd_pins microblaze_0_axi_periph/M08_ACLK] [get_bd_pins microblaze_0_axi_periph/M09_ACLK] [get_bd_pins microblaze_0_axi_periph/M10_ACLK] [get_bd_pins microblaze_0_axi_periph/M11_ACLK] [get_bd_pins microblaze_0_axi_periph/M12_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rst_system/slowest_sync_clk]
  connect_bd_net -net clk_wiz_0_locked1 [get_bd_pins dcm_locked] [get_bd_pins rst_system/dcm_locked]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk_sync_rst [get_bd_pins ext_reset_in] [get_bd_pins rst_system/ext_reset_in]
  connect_bd_net -net mdm_1_Debug_SYS_Rst [get_bd_pins mb_debug_sys_rst] [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_system/mb_debug_sys_rst]
  connect_bd_net -net rst_mig_7series_0_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins microblaze_0_axi_intc/processor_rst] [get_bd_pins rst_system/mb_reset]
  connect_bd_net -net rst_mig_7series_0_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_system/bus_struct_reset]
  connect_bd_net -net rst_system_peripheral_aresetn [get_bd_pins peripheral_aresetn] [get_bd_pins AXI_LITE_REG_0/s00_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins axi_uartlite_1/s_axi_aresetn] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/M06_ARESETN] [get_bd_pins microblaze_0_axi_periph/M07_ARESETN] [get_bd_pins microblaze_0_axi_periph/M08_ARESETN] [get_bd_pins microblaze_0_axi_periph/M09_ARESETN] [get_bd_pins microblaze_0_axi_periph/M10_ARESETN] [get_bd_pins microblaze_0_axi_periph/M11_ARESETN] [get_bd_pins microblaze_0_axi_periph/M12_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins rst_system/peripheral_aresetn]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins microblaze_0_axi_intc/intr] [get_bd_pins microblaze_0_xlconcat/dout]
  connect_bd_net -net xlconstant_0_dout1 [get_bd_pins VERSION] [get_bd_pins AXI_LITE_REG_0/VERSION]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pcie_hier
proc create_hier_cell_pcie_hier { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pcie_hier() - Empty argument(s)!"}
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
  create_bd_pin -dir O -from 0 -to 0 usr_irq_ack
  create_bd_pin -dir I -from 0 -to 0 usr_irq_req
  create_bd_pin -dir O xdma_irq_req_o

  # Create instance: pcie_irq_deal_0, and set properties
  set block_name pcie_irq_deal
  set block_cell_name pcie_irq_deal_0
  if { [catch {set pcie_irq_deal_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pcie_irq_deal_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
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
   CONFIG.pf0_msix_cap_pba_offset {00008FE0} \
   CONFIG.pf0_msix_cap_table_bir {BAR_1} \
   CONFIG.pf0_msix_cap_table_offset {00008000} \
   CONFIG.pf0_msix_cap_table_size {01F} \
   CONFIG.pf0_msix_enabled {true} \
   CONFIG.pf0_sub_class_interface_menu {Other_memory_controller} \
   CONFIG.pl_link_cap_max_link_speed {5.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X8} \
   CONFIG.plltype {QPLL1} \
   CONFIG.xdma_rnum_chnl {4} \
   CONFIG.xdma_wnum_chnl {4} \
 ] $xdma_0

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_pins pcie_sys_clk] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
  connect_bd_intf_net -intf_net xdma_0_M_AXI [get_bd_intf_pins M_AXI] [get_bd_intf_pins xdma_0/M_AXI]
  connect_bd_intf_net -intf_net xdma_0_M_AXI_LITE [get_bd_intf_pins M_AXI_LITE] [get_bd_intf_pins xdma_0/M_AXI_LITE]
  connect_bd_intf_net -intf_net xdma_0_pcie_mgt [get_bd_intf_pins pcie_mgt] [get_bd_intf_pins xdma_0/pcie_mgt]

  # Create port connections
  connect_bd_net -net pcie_irq_deal_0_xdma_irq_req_o [get_bd_pins xdma_irq_req_o] [get_bd_pins pcie_irq_deal_0/xdma_irq_req_o] [get_bd_pins xdma_0/usr_irq_req]
  connect_bd_net -net reset_rtl_0_1 [get_bd_pins pcie_resetn] [get_bd_pins xdma_0/sys_rst_n]
  connect_bd_net -net usr_irq_req_1 [get_bd_pins usr_irq_req] [get_bd_pins pcie_irq_deal_0/user_irq_req_i]
  connect_bd_net -net util_ds_buf_0_IBUF_DS_ODIV2 [get_bd_pins util_ds_buf_0/IBUF_DS_ODIV2] [get_bd_pins xdma_0/sys_clk]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins util_ds_buf_0/IBUF_OUT] [get_bd_pins xdma_0/sys_clk_gt]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_pins axi_aclk] [get_bd_pins pcie_irq_deal_0/clk] [get_bd_pins xdma_0/axi_aclk]
  connect_bd_net -net xdma_0_axi_aresetn [get_bd_pins axi_aresetn] [get_bd_pins pcie_irq_deal_0/rst_n] [get_bd_pins xdma_0/axi_aresetn]
  connect_bd_net -net xdma_0_usr_irq_ack [get_bd_pins usr_irq_ack] [get_bd_pins pcie_irq_deal_0/xdma_irq_ack_i] [get_bd_pins xdma_0/usr_irq_ack]

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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis


  # Create pins
  create_bd_pin -dir I -type rst aresetn_200m
  create_bd_pin -dir I ch0_clkin0_n
  create_bd_pin -dir I ch0_clkin0_p
  create_bd_pin -dir I ch0_clkin1_n
  create_bd_pin -dir I ch0_clkin1_p
  create_bd_pin -dir I -from 3 -to 0 ch0_datain0_n
  create_bd_pin -dir I -from 3 -to 0 ch0_datain0_p
  create_bd_pin -dir I -from 3 -to 0 ch0_datain1_n
  create_bd_pin -dir I -from 3 -to 0 ch0_datain1_p
  create_bd_pin -dir I -type clk clk_200m
  create_bd_pin -dir I -type clk refclk
  create_bd_pin -dir I -type rst reset
  create_bd_pin -dir I -type clk s00_axi_aclk
  create_bd_pin -dir I -type rst s00_axi_aresetn
  create_bd_pin -dir I vcc

  # Create instance: axis_passthrough_mon_0, and set properties
  set axis_passthrough_mon_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:axis_passthrough_monitor:1.0 axis_passthrough_mon_0 ]
  set_property -dict [ list \
   CONFIG.WIDTH {48} \
 ] $axis_passthrough_mon_0

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
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_passthrough_mon_0/m_axis]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axis_passthrough_mon_0/S00_AXI]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins axis_passthrough_mon_0/s_axis] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins vcc] [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins clk_200m] [get_bd_pins axis_passthrough_mon_0/aclk] [get_bd_pins v_vid_in_axi4s_0/aclk]
  connect_bd_net -net clkin1_n_0_1 [get_bd_pins ch0_clkin0_n] [get_bd_pins lvds4x2_1to7_0/clkin1_n]
  connect_bd_net -net clkin1_p_0_1 [get_bd_pins ch0_clkin0_p] [get_bd_pins lvds4x2_1to7_0/clkin1_p]
  connect_bd_net -net clkin2_n_0_1 [get_bd_pins ch0_clkin1_n] [get_bd_pins lvds4x2_1to7_0/clkin2_n]
  connect_bd_net -net clkin2_p_0_1 [get_bd_pins ch0_clkin1_p] [get_bd_pins lvds4x2_1to7_0/clkin2_p]
  connect_bd_net -net datain1_n_0_1 [get_bd_pins ch0_datain0_n] [get_bd_pins lvds4x2_1to7_0/datain1_n]
  connect_bd_net -net datain1_p_0_1 [get_bd_pins ch0_datain0_p] [get_bd_pins lvds4x2_1to7_0/datain1_p]
  connect_bd_net -net datain2_n_0_1 [get_bd_pins ch0_datain1_n] [get_bd_pins lvds4x2_1to7_0/datain2_n]
  connect_bd_net -net datain2_p_0_1 [get_bd_pins ch0_datain1_p] [get_bd_pins lvds4x2_1to7_0/datain2_p]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk [get_bd_pins refclk] [get_bd_pins lvds4x2_1to7_0/refclk]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk_sync_rst [get_bd_pins reset] [get_bd_pins lvds4x2_1to7_0/reset]
  connect_bd_net -net lvds4x2_1to7_0_de0 [get_bd_pins lvds4x2_1to7_0/de0] [get_bd_pins v_vid_in_axi4s_0/vid_active_video]
  connect_bd_net -net lvds4x2_1to7_0_dout0 [get_bd_pins lvds4x2_1to7_0/dout0] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net lvds4x2_1to7_0_dout1 [get_bd_pins lvds4x2_1to7_0/dout1] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net lvds4x2_1to7_0_hs0 [get_bd_pins lvds4x2_1to7_0/hs0] [get_bd_pins v_vid_in_axi4s_0/vid_hsync]
  connect_bd_net -net lvds4x2_1to7_0_px_clk [get_bd_pins lvds4x2_1to7_0/px_clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net lvds4x2_1to7_0_vs0 [get_bd_pins lvds4x2_1to7_0/vs0] [get_bd_pins v_vid_in_axi4s_0/vid_vsync]
  connect_bd_net -net rst_mig_7series_0_100M_peripheral_aresetn [get_bd_pins aresetn_200m] [get_bd_pins axis_passthrough_mon_0/aresetn] [get_bd_pins v_vid_in_axi4s_0/aresetn]
  connect_bd_net -net s00_axi_aclk_1 [get_bd_pins s00_axi_aclk] [get_bd_pins axis_passthrough_mon_0/s00_axi_aclk]
  connect_bd_net -net s00_axi_aresetn_1 [get_bd_pins s00_axi_aresetn] [get_bd_pins axis_passthrough_mon_0/s00_axi_aresetn]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins v_vid_in_axi4s_0/vid_data] [get_bd_pins xlconcat_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: memory_subsystem
proc create_hier_cell_memory_subsystem { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_memory_subsystem() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S01_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S03_AXI

  create_bd_intf_pin -mode Monitor -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_S2MM

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTRL

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c0_ddr4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys


  # Create pins
  create_bd_pin -dir I -type clk S03_ACLK
  create_bd_pin -dir I -type rst S03_ARESETN
  create_bd_pin -dir O -type clk addn_ui_clkout1
  create_bd_pin -dir I -type rst axi_resetn
  create_bd_pin -dir O -type clk c0_ddr4_ui_clk
  create_bd_pin -dir O -type rst c0_ddr4_ui_clk_sync_rst
  create_bd_pin -dir I dcm_locked
  create_bd_pin -dir I -type clk m_axi_s2mm_aclk
  create_bd_pin -dir I -type rst mb_debug_sys_rst
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn
  create_bd_pin -dir O -from 5 -to 0 s2mm_frame_ptr_out
  create_bd_pin -dir O -from 0 -to 0 -type intr s2mm_introut
  create_bd_pin -dir I -type clk s_axi_lite_aclk
  create_bd_pin -dir I -type rst sys_rst

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {4} \
   CONFIG.S00_HAS_DATA_FIFO {2} \
   CONFIG.S00_HAS_REGSLICE {3} \
   CONFIG.S01_HAS_DATA_FIFO {2} \
   CONFIG.S01_HAS_REGSLICE {3} \
   CONFIG.S02_HAS_DATA_FIFO {2} \
   CONFIG.S02_HAS_REGSLICE {3} \
   CONFIG.S03_HAS_DATA_FIFO {2} \
   CONFIG.S03_HAS_REGSLICE {3} \
   CONFIG.STRATEGY {0} \
 ] $axi_interconnect_0

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_0 ]
  set_property -dict [ list \
   CONFIG.C_FAMILY {artix7} \
   CONFIG.c_include_mm2s {0} \
   CONFIG.c_include_s2mm_dre {0} \
   CONFIG.c_m_axi_mm2s_data_width {64} \
   CONFIG.c_m_axi_s2mm_data_width {64} \
   CONFIG.c_m_axis_mm2s_tdata_width {32} \
   CONFIG.c_mm2s_genlock_mode {0} \
   CONFIG.c_mm2s_linebuffer_depth {512} \
   CONFIG.c_mm2s_max_burst_length {8} \
   CONFIG.c_num_fstores {3} \
   CONFIG.c_s2mm_linebuffer_depth {1024} \
   CONFIG.c_s2mm_max_burst_length {64} \
 ] $axi_vdma_0

  # Create instance: axis_clock_converter_0, and set properties
  set axis_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_0 ]

  # Create instance: axis_passthrough_mon_0, and set properties
  set axis_passthrough_mon_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:axis_passthrough_monitor:1.0 axis_passthrough_mon_0 ]
  set_property -dict [ list \
   CONFIG.WIDTH {48} \
 ] $axis_passthrough_mon_0

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.M_HAS_TLAST {1} \
   CONFIG.M_TDATA_NUM_BYTES {6} \
   CONFIG.M_TUSER_WIDTH {1} \
   CONFIG.S_HAS_TLAST {1} \
   CONFIG.S_TDATA_NUM_BYTES {6} \
   CONFIG.S_TUSER_WIDTH {1} \
   CONFIG.TDATA_REMAP {{tdata[47:40],tdata[31:24],tdata[39:32],tdata[23:16],tdata[7:0],tdata[15:8]}} \
 ] $axis_subset_converter_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.HAS_TLAST {1} \
   CONFIG.ROUTING_MODE {1} \
   CONFIG.TUSER_WIDTH {1} \
 ] $axis_switch_0

  # Create instance: ddr4_0, and set properties
  set ddr4_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_0 ]
  set_property -dict [ list \
   CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {200} \
   CONFIG.C0.BANK_GROUP_WIDTH {1} \
   CONFIG.C0.DDR4_AxiAddressWidth {31} \
   CONFIG.C0.DDR4_AxiDataWidth {256} \
   CONFIG.C0.DDR4_CasLatency {18} \
   CONFIG.C0.DDR4_DataWidth {32} \
   CONFIG.C0.DDR4_InputClockPeriod {4998} \
   CONFIG.C0.DDR4_MCS_ECC {false} \
   CONFIG.C0.DDR4_MemoryPart {MT40A512M16HA-083E} \
   CONFIG.System_Clock {Differential} \
 ] $ddr4_0

  # Create instance: rst_ddr4_0_300M, and set properties
  set rst_ddr4_0_300M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ddr4_0_300M ]
  set_property -dict [ list \
   CONFIG.C_AUX_RST_WIDTH {1} \
   CONFIG.C_EXT_RST_WIDTH {1} \
 ] $rst_ddr4_0_300M

  # Create instance: rst_video_system, and set properties
  set rst_video_system [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_video_system ]
  set_property -dict [ list \
   CONFIG.C_AUX_RST_WIDTH {1} \
   CONFIG.C_EXT_RST_WIDTH {1} \
 ] $rst_video_system

  # Create instance: v_tpg_0, and set properties
  set v_tpg_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg:8.0 v_tpg_0 ]
  set_property -dict [ list \
   CONFIG.MAX_COLS {3840} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_tpg_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S00_AXI1] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S01_AXI] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins S03_AXI] [get_bd_intf_pins axi_interconnect_0/S03_AXI]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axis_passthrough_mon_0/S00_AXI]
  connect_bd_intf_net -intf_net S_AXI_CTRL_1 [get_bd_intf_pins S_AXI_CTRL] [get_bd_intf_pins axis_switch_0/S_AXI_CTRL]
  connect_bd_intf_net -intf_net S_AXI_LITE_1 [get_bd_intf_pins S_AXI_LITE] [get_bd_intf_pins axi_vdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins ddr4_0/C0_DDR4_S_AXI]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_S2MM [get_bd_intf_pins axi_interconnect_0/S02_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axis_clock_converter_0_M_AXIS [get_bd_intf_pins axis_clock_converter_0/M_AXIS] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net axis_passthrough_mon_0_m_axis [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM] [get_bd_intf_pins axis_passthrough_mon_0/m_axis]
  connect_bd_intf_net -intf_net [get_bd_intf_nets axis_passthrough_mon_0_m_axis] [get_bd_intf_pins S_AXIS_S2MM] [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets axis_passthrough_mon_0_m_axis]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_passthrough_mon_0/s_axis] [get_bd_intf_pins axis_subset_converter_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_subset_converter_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net ddr4_0_C0_DDR4 [get_bd_intf_pins c0_ddr4] [get_bd_intf_pins ddr4_0/C0_DDR4]
  connect_bd_intf_net -intf_net oldi_in_m_axis [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axi_CTRL1_1 [get_bd_intf_pins s_axi_CTRL1] [get_bd_intf_pins v_tpg_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net sys_1 [get_bd_intf_pins sys] [get_bd_intf_pins ddr4_0/C0_SYS_CLK]
  connect_bd_intf_net -intf_net v_tpg_0_m_axis_video [get_bd_intf_pins axis_clock_converter_0/S_AXIS] [get_bd_intf_pins v_tpg_0/m_axis_video]

  # Create port connections
  connect_bd_net -net S03_ACLK_1 [get_bd_pins S03_ACLK] [get_bd_pins axi_interconnect_0/S03_ACLK]
  connect_bd_net -net S03_ARESETN_1 [get_bd_pins S03_ARESETN] [get_bd_pins axi_interconnect_0/S03_ARESETN]
  connect_bd_net -net axi_vdma_0_s2mm_frame_ptr_out [get_bd_pins s2mm_frame_ptr_out] [get_bd_pins axi_vdma_0/s2mm_frame_ptr_out]
  connect_bd_net -net axi_vdma_0_s2mm_introut [get_bd_pins s2mm_introut] [get_bd_pins axi_vdma_0/s2mm_introut]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets axi_vdma_0_s2mm_introut]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins s_axi_lite_aclk] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axis_clock_converter_0/s_axis_aclk] [get_bd_pins axis_passthrough_mon_0/s00_axi_aclk] [get_bd_pins axis_switch_0/s_axi_ctrl_aclk] [get_bd_pins v_tpg_0/ap_clk]
  connect_bd_net -net clk_wiz_0_clk_out3 [get_bd_pins m_axi_s2mm_aclk] [get_bd_pins axi_interconnect_0/S02_ACLK] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk] [get_bd_pins axis_clock_converter_0/m_axis_aclk] [get_bd_pins axis_passthrough_mon_0/aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins rst_video_system/slowest_sync_clk]
  connect_bd_net -net clk_wiz_0_locked1 [get_bd_pins dcm_locked] [get_bd_pins rst_video_system/dcm_locked]
  connect_bd_net -net ddr4_0_addn_ui_clkout1 [get_bd_pins addn_ui_clkout1] [get_bd_pins ddr4_0/addn_ui_clkout1]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk1 [get_bd_pins c0_ddr4_ui_clk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins ddr4_0/c0_ddr4_ui_clk] [get_bd_pins rst_ddr4_0_300M/slowest_sync_clk]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk_sync_rst [get_bd_pins c0_ddr4_ui_clk_sync_rst] [get_bd_pins ddr4_0/c0_ddr4_ui_clk_sync_rst] [get_bd_pins rst_ddr4_0_300M/ext_reset_in] [get_bd_pins rst_video_system/ext_reset_in]
  connect_bd_net -net ddr4_0_c0_init_calib_complete [get_bd_pins ddr4_0/c0_init_calib_complete] [get_bd_pins rst_ddr4_0_300M/dcm_locked]
  connect_bd_net -net mdm_1_Debug_SYS_Rst [get_bd_pins mb_debug_sys_rst] [get_bd_pins rst_video_system/mb_debug_sys_rst]
  connect_bd_net -net rst_ddr4_0_300M_interconnect_aresetn [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins rst_ddr4_0_300M/interconnect_aresetn]
  connect_bd_net -net rst_ddr4_0_300M_peripheral_aresetn [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins ddr4_0/c0_ddr4_aresetn] [get_bd_pins rst_ddr4_0_300M/peripheral_aresetn]
  connect_bd_net -net rst_system_peripheral_aresetn [get_bd_pins axi_resetn] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axis_clock_converter_0/s_axis_aresetn] [get_bd_pins axis_passthrough_mon_0/s00_axi_aresetn] [get_bd_pins axis_switch_0/s_axi_ctrl_aresetn] [get_bd_pins v_tpg_0/ap_rst_n]
  connect_bd_net -net rst_video_system_peripheral_aresetn [get_bd_pins peripheral_aresetn] [get_bd_pins axi_interconnect_0/S02_ARESETN] [get_bd_pins axis_clock_converter_0/m_axis_aresetn] [get_bd_pins axis_passthrough_mon_0/aresetn] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins rst_video_system/peripheral_aresetn]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins sys_rst] [get_bd_pins ddr4_0/sys_rst]

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
  set c0_ddr4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c0_ddr4 ]

  set gpio [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio ]

  set i2c_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c_0 ]

  set i2c_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c_1 ]

  set pcie_mgt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_mgt ]

  set pcie_sys_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_sys_clk ]

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
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $pcie_resetn

  # Create instance: GND, and set properties
  set GND [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $GND

  # Create instance: HW_VER, and set properties
  set HW_VER [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 HW_VER ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x24073017} \
   CONFIG.CONST_WIDTH {32} \
 ] $HW_VER

  # Create instance: VCC, and set properties
  set VCC [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 VCC ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {50.0} \
   CONFIG.CLKOUT1_DRIVES {BUFG} \
   CONFIG.CLKOUT1_JITTER {112.316} \
   CONFIG.CLKOUT1_PHASE_ERROR {89.971} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {100.000} \
   CONFIG.CLKOUT2_DRIVES {BUFG} \
   CONFIG.CLKOUT2_JITTER {98.146} \
   CONFIG.CLKOUT2_PHASE_ERROR {89.971} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {200.000} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {5.000} \
   CONFIG.MMCM_CLKIN1_PERIOD {5.000} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {10.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {5} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.PRIM_IN_FREQ {200.000} \
   CONFIG.PRIM_SOURCE {Global_buffer} \
 ] $clk_wiz_0

  # Create instance: memory_subsystem
  create_hier_cell_memory_subsystem [current_bd_instance .] memory_subsystem

  # Create instance: oldi_in
  create_hier_cell_oldi_in [current_bd_instance .] oldi_in

  # Create instance: pcie_hier
  create_hier_cell_pcie_hier [current_bd_instance .] pcie_hier

  # Create instance: processor_subsystem
  create_hier_cell_processor_subsystem [current_bd_instance .] processor_subsystem

  # Create instance: system_ila_0, and set properties
  set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_0 ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {25} \
   CONFIG.C_DATA_DEPTH {16384} \
   CONFIG.C_MON_TYPE {MIX} \
   CONFIG.C_NUM_MONITOR_SLOTS {1} \
   CONFIG.C_NUM_OF_PROBES {4} \
   CONFIG.C_PROBE0_TYPE {0} \
   CONFIG.C_SLOT_0_APC_EN {0} \
   CONFIG.C_SLOT_0_AXI_DATA_SEL {1} \
   CONFIG.C_SLOT_0_AXI_TRIG_SEL {1} \
   CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
 ] $system_ila_0

  # Create instance: xgpio_i2c_0
  create_hier_cell_xgpio_i2c_0 [current_bd_instance .] xgpio_i2c_0

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_ports pcie_sys_clk] [get_bd_intf_pins pcie_hier/pcie_sys_clk]
connect_bd_intf_net -intf_net Conn [get_bd_intf_pins memory_subsystem/S_AXIS_S2MM] [get_bd_intf_pins system_ila_0/SLOT_0_AXIS]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins memory_subsystem/S00_AXI] [get_bd_intf_pins processor_subsystem/M07_AXI]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins oldi_in/S00_AXI] [get_bd_intf_pins processor_subsystem/M09_AXI]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins processor_subsystem/M11_AXI] [get_bd_intf_pins xgpio_i2c_0/S_AXI]
  connect_bd_intf_net -intf_net S_AXI_CTRL_1 [get_bd_intf_pins memory_subsystem/S_AXI_CTRL] [get_bd_intf_pins processor_subsystem/M08_AXI]
  connect_bd_intf_net -intf_net S_AXI_LITE_1 [get_bd_intf_pins memory_subsystem/S_AXI_LITE] [get_bd_intf_pins processor_subsystem/M06_AXI]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports gpio] [get_bd_intf_pins processor_subsystem/gpio]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports uart_0] [get_bd_intf_pins processor_subsystem/uart_0]
  connect_bd_intf_net -intf_net axi_uartlite_1_UART [get_bd_intf_ports uart_1] [get_bd_intf_pins processor_subsystem/uart_1]
  connect_bd_intf_net -intf_net ddr4_0_C0_DDR4 [get_bd_intf_ports c0_ddr4] [get_bd_intf_pins memory_subsystem/c0_ddr4]
  connect_bd_intf_net -intf_net oldi_in_m_axis [get_bd_intf_pins memory_subsystem/S00_AXIS] [get_bd_intf_pins oldi_in/m_axis]
  connect_bd_intf_net -intf_net processor_subsystem_M_AXI_DC [get_bd_intf_pins memory_subsystem/S00_AXI1] [get_bd_intf_pins processor_subsystem/M_AXI_DC]
  connect_bd_intf_net -intf_net processor_subsystem_M_AXI_IC [get_bd_intf_pins memory_subsystem/S01_AXI] [get_bd_intf_pins processor_subsystem/M_AXI_IC]
  connect_bd_intf_net -intf_net s_axi_CTRL1_1 [get_bd_intf_pins memory_subsystem/s_axi_CTRL1] [get_bd_intf_pins processor_subsystem/M10_AXI]
  connect_bd_intf_net -intf_net sys_1 [get_bd_intf_ports sys] [get_bd_intf_pins memory_subsystem/sys]
  connect_bd_intf_net -intf_net xdma_0_M_AXI [get_bd_intf_pins memory_subsystem/S03_AXI] [get_bd_intf_pins pcie_hier/M_AXI]
  connect_bd_intf_net -intf_net xdma_0_M_AXI_LITE [get_bd_intf_pins pcie_hier/M_AXI_LITE] [get_bd_intf_pins processor_subsystem/S01_AXI]
  connect_bd_intf_net -intf_net xdma_0_pcie_mgt [get_bd_intf_ports pcie_mgt] [get_bd_intf_pins pcie_hier/pcie_mgt]
  connect_bd_intf_net -intf_net xgpio_i2c_0_i2c_0 [get_bd_intf_ports i2c_0] [get_bd_intf_pins xgpio_i2c_0/i2c_0]
  connect_bd_intf_net -intf_net xgpio_i2c_0_i2c_1 [get_bd_intf_ports i2c_1] [get_bd_intf_pins xgpio_i2c_0/i2c_1]

  # Create port connections
  connect_bd_net -net In3_1 [get_bd_pins memory_subsystem/s2mm_introut] [get_bd_pins pcie_hier/usr_irq_req] [get_bd_pins processor_subsystem/s2mm_introut] [get_bd_pins system_ila_0/probe0]
  connect_bd_net -net Net [get_bd_pins VCC/dout] [get_bd_pins oldi_in/vcc]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins memory_subsystem/s_axi_lite_aclk] [get_bd_pins oldi_in/s00_axi_aclk] [get_bd_pins processor_subsystem/s00_axi_aclk] [get_bd_pins xgpio_i2c_0/s_axi_aclk]
  connect_bd_net -net clk_wiz_0_clk_out3 [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins memory_subsystem/m_axi_s2mm_aclk] [get_bd_pins oldi_in/clk_200m] [get_bd_pins system_ila_0/clk]
  connect_bd_net -net clk_wiz_0_locked1 [get_bd_pins clk_wiz_0/locked] [get_bd_pins memory_subsystem/dcm_locked] [get_bd_pins processor_subsystem/dcm_locked]
  connect_bd_net -net clkin1_n_0_1 [get_bd_ports ch0_clkin0_n] [get_bd_pins oldi_in/ch0_clkin0_n]
  connect_bd_net -net clkin1_p_0_1 [get_bd_ports ch0_clkin0_p] [get_bd_pins oldi_in/ch0_clkin0_p]
  connect_bd_net -net clkin2_n_0_1 [get_bd_ports ch0_clkin1_n] [get_bd_pins oldi_in/ch0_clkin1_n]
  connect_bd_net -net clkin2_p_0_1 [get_bd_ports ch0_clkin1_p] [get_bd_pins oldi_in/ch0_clkin1_p]
  connect_bd_net -net datain1_n_0_1 [get_bd_ports ch0_datain0_n] [get_bd_pins oldi_in/ch0_datain0_n]
  connect_bd_net -net datain1_p_0_1 [get_bd_ports ch0_datain0_p] [get_bd_pins oldi_in/ch0_datain0_p]
  connect_bd_net -net datain2_n_0_1 [get_bd_ports ch0_datain1_n] [get_bd_pins oldi_in/ch0_datain1_n]
  connect_bd_net -net datain2_p_0_1 [get_bd_ports ch0_datain1_p] [get_bd_pins oldi_in/ch0_datain1_p]
  connect_bd_net -net ddr4_0_addn_ui_clkout1 [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins memory_subsystem/addn_ui_clkout1]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk1 [get_bd_pins memory_subsystem/c0_ddr4_ui_clk] [get_bd_pins oldi_in/refclk]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk_sync_rst [get_bd_pins clk_wiz_0/reset] [get_bd_pins memory_subsystem/c0_ddr4_ui_clk_sync_rst] [get_bd_pins oldi_in/reset] [get_bd_pins processor_subsystem/ext_reset_in]
  connect_bd_net -net mdm_1_Debug_SYS_Rst [get_bd_pins memory_subsystem/mb_debug_sys_rst] [get_bd_pins processor_subsystem/mb_debug_sys_rst]
  connect_bd_net -net memory_subsystem_s2mm_frame_ptr_out [get_bd_pins memory_subsystem/s2mm_frame_ptr_out] [get_bd_pins system_ila_0/probe1]
  connect_bd_net -net pcie_hier_usr_irq_ack [get_bd_pins pcie_hier/usr_irq_ack] [get_bd_pins system_ila_0/probe3]
  connect_bd_net -net pcie_hier_xdma_irq_req_o [get_bd_pins pcie_hier/xdma_irq_req_o] [get_bd_pins system_ila_0/probe2]
  connect_bd_net -net reset_rtl_0_1 [get_bd_ports pcie_resetn] [get_bd_pins pcie_hier/pcie_resetn]
  connect_bd_net -net rst_system_peripheral_aresetn [get_bd_pins memory_subsystem/axi_resetn] [get_bd_pins oldi_in/s00_axi_aresetn] [get_bd_pins processor_subsystem/peripheral_aresetn] [get_bd_pins xgpio_i2c_0/s_axi_aresetn]
  connect_bd_net -net rst_video_system_peripheral_aresetn [get_bd_pins memory_subsystem/peripheral_aresetn] [get_bd_pins oldi_in/aresetn_200m] [get_bd_pins system_ila_0/resetn]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_pins memory_subsystem/S03_ACLK] [get_bd_pins pcie_hier/axi_aclk] [get_bd_pins processor_subsystem/S01_ACLK]
  connect_bd_net -net xdma_0_axi_aresetn [get_bd_pins memory_subsystem/S03_ARESETN] [get_bd_pins pcie_hier/axi_aresetn] [get_bd_pins processor_subsystem/S01_ARESETN]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins GND/dout] [get_bd_pins memory_subsystem/sys_rst]
  connect_bd_net -net xlconstant_0_dout1 [get_bd_pins HW_VER/dout] [get_bd_pins processor_subsystem/VERSION]

  # Create address segments
  assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces memory_subsystem/axi_vdma_0/Data_S2MM] [get_bd_addr_segs memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x44A50000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/AXI_LITE_REG_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x40000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs xgpio_i2c_0/axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A60000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/axi_quad_spi_0/AXI_LITE/Reg] -force
  assign_bd_address -offset 0x41C00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/axi_timer_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40600000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/axi_uartlite_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40610000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/axi_uartlite_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs memory_subsystem/axi_vdma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x44A10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs memory_subsystem/axis_passthrough_mon_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x44A40000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs oldi_in/axis_passthrough_mon_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x44A20000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs memory_subsystem/axis_switch_0/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI] [get_bd_addr_segs memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs processor_subsystem/microblaze_0_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A30000 -range 0x00010000 -target_address_space [get_bd_addr_spaces pcie_hier/xdma_0/M_AXI_LITE] [get_bd_addr_segs memory_subsystem/v_tpg_0/s_axi_CTRL/Reg] -force
  assign_bd_address -offset 0x44A50000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/AXI_LITE_REG_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x40000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs xgpio_i2c_0/axi_gpio_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A60000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/axi_quad_spi_0/AXI_LITE/Reg] -force
  assign_bd_address -offset 0x41C00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/axi_timer_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40600000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/axi_uartlite_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40610000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/axi_uartlite_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs memory_subsystem/axi_vdma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x44A10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs memory_subsystem/axis_passthrough_mon_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x44A40000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs oldi_in/axis_passthrough_mon_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x44A20000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs memory_subsystem/axis_switch_0/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x80000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Instruction] [get_bd_addr_segs memory_subsystem/ddr4_0/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x00000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00000000 -range 0x00100000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Instruction] [get_bd_addr_segs processor_subsystem/microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs processor_subsystem/microblaze_0_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A30000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processor_subsystem/microblaze_0/Data] [get_bd_addr_segs memory_subsystem/v_tpg_0/s_axi_CTRL/Reg] -force


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


