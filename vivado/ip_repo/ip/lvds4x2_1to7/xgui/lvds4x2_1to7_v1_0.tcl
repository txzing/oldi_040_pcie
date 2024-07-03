# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "LINES" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CHANNELS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CLKIN_PERIOD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DIFF_TERM" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "USE_PLL" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "DATA_FORMAT" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "LVDS_FORMAT" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.CHANNELS { PARAM_VALUE.CHANNELS } {
	# Procedure called to update CHANNELS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CHANNELS { PARAM_VALUE.CHANNELS } {
	# Procedure called to validate CHANNELS
	return true
}

proc update_PARAM_VALUE.CLKIN_PERIOD { PARAM_VALUE.CLKIN_PERIOD } {
	# Procedure called to update CLKIN_PERIOD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLKIN_PERIOD { PARAM_VALUE.CLKIN_PERIOD } {
	# Procedure called to validate CLKIN_PERIOD
	return true
}

proc update_PARAM_VALUE.DATA_FORMAT { PARAM_VALUE.DATA_FORMAT } {
	# Procedure called to update DATA_FORMAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_FORMAT { PARAM_VALUE.DATA_FORMAT } {
	# Procedure called to validate DATA_FORMAT
	return true
}

proc update_PARAM_VALUE.DIFF_TERM { PARAM_VALUE.DIFF_TERM } {
	# Procedure called to update DIFF_TERM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DIFF_TERM { PARAM_VALUE.DIFF_TERM } {
	# Procedure called to validate DIFF_TERM
	return true
}

proc update_PARAM_VALUE.LINES { PARAM_VALUE.LINES } {
	# Procedure called to update LINES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LINES { PARAM_VALUE.LINES } {
	# Procedure called to validate LINES
	return true
}

proc update_PARAM_VALUE.LVDS_FORMAT { PARAM_VALUE.LVDS_FORMAT } {
	# Procedure called to update LVDS_FORMAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LVDS_FORMAT { PARAM_VALUE.LVDS_FORMAT } {
	# Procedure called to validate LVDS_FORMAT
	return true
}

proc update_PARAM_VALUE.REF_FREQ { PARAM_VALUE.REF_FREQ } {
	# Procedure called to update REF_FREQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REF_FREQ { PARAM_VALUE.REF_FREQ } {
	# Procedure called to validate REF_FREQ
	return true
}

proc update_PARAM_VALUE.USE_PLL { PARAM_VALUE.USE_PLL } {
	# Procedure called to update USE_PLL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.USE_PLL { PARAM_VALUE.USE_PLL } {
	# Procedure called to validate USE_PLL
	return true
}


proc update_MODELPARAM_VALUE.LINES { MODELPARAM_VALUE.LINES PARAM_VALUE.LINES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LINES}] ${MODELPARAM_VALUE.LINES}
}

proc update_MODELPARAM_VALUE.CHANNELS { MODELPARAM_VALUE.CHANNELS PARAM_VALUE.CHANNELS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CHANNELS}] ${MODELPARAM_VALUE.CHANNELS}
}

proc update_MODELPARAM_VALUE.CLKIN_PERIOD { MODELPARAM_VALUE.CLKIN_PERIOD PARAM_VALUE.CLKIN_PERIOD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLKIN_PERIOD}] ${MODELPARAM_VALUE.CLKIN_PERIOD}
}

proc update_MODELPARAM_VALUE.REF_FREQ { MODELPARAM_VALUE.REF_FREQ PARAM_VALUE.REF_FREQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REF_FREQ}] ${MODELPARAM_VALUE.REF_FREQ}
}

proc update_MODELPARAM_VALUE.DIFF_TERM { MODELPARAM_VALUE.DIFF_TERM PARAM_VALUE.DIFF_TERM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DIFF_TERM}] ${MODELPARAM_VALUE.DIFF_TERM}
}

proc update_MODELPARAM_VALUE.USE_PLL { MODELPARAM_VALUE.USE_PLL PARAM_VALUE.USE_PLL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.USE_PLL}] ${MODELPARAM_VALUE.USE_PLL}
}

proc update_MODELPARAM_VALUE.DATA_FORMAT { MODELPARAM_VALUE.DATA_FORMAT PARAM_VALUE.DATA_FORMAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_FORMAT}] ${MODELPARAM_VALUE.DATA_FORMAT}
}

proc update_MODELPARAM_VALUE.LVDS_FORMAT { MODELPARAM_VALUE.LVDS_FORMAT PARAM_VALUE.LVDS_FORMAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LVDS_FORMAT}] ${MODELPARAM_VALUE.LVDS_FORMAT}
}

#proc update_MODELPARAM_VALUE.SIM_DEVICE { IPINST MODELPARAM_VALUE.SIM_DEVICE PROJECT_PARAM.ARCHITECTURE } {
proc update_MODELPARAM_VALUE.SIM_DEVICE { IPINST MODELPARAM_VALUE.SIM_DEVICE PROJECT_PARAM.ARCHITECTURE PROJECT_PARAM.PART } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	# WARNING: There is no corresponding user parameter named "SIM_DEVICE". Setting updated value from the model parameter.
    # set_property value ULTRASCALE_PLUS ${MODELPARAM_VALUE.SIM_DEVICE}
    
    ## ref to oddr_v1_0
    puts "PROJECT_PARAM.PART=${PROJECT_PARAM.PART}"
    puts "PROJECT_PARAM.ARCHITECTURE=${PROJECT_PARAM.ARCHITECTURE}"
    #if {(${PROJECT_PARAM.ARCHITECTURE} == "virtexu") || (${PROJECT_PARAM.ARCHITECTURE} == "kintexu")} {
        #puts "!!!!! setting SIM_DEVICE"
        #set SIM_DEVICE ULTRASCALE
        set SIM_DEVICE [get_device_data D_SIM ISERDESE3]
        #set SIM_DEVICE [get_device_data D_SIM ODDRE1]
        puts "!!!!! SIM_DEVICE=${SIM_DEVICE}"
        set_property value $SIM_DEVICE ${MODELPARAM_VALUE.SIM_DEVICE}
    #} else {
    #    puts "!!!!! NO SIM_DEVICE"
    #    #set SIM_DEVICE ULTRASCALE_PLUS
    #    puts [get_device_data D_SIM ISERDESE3]
    #    set SIM_DEVICE [get_device_data D_SIM ISERDESE3]
    #    puts "!!!!!SIM_DEVICE=${SIM_DEVICE}"
    #    set_property value $SIM_DEVICE ${MODELPARAM_VALUE.SIM_DEVICE}
    #}
}

