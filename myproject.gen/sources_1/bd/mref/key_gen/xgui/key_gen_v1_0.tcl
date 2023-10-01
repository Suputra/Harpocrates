# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "eta" -parent ${Page_0}
  ipgui::add_param $IPINST -name "lambda" -parent ${Page_0}
  ipgui::add_param $IPINST -name "nu" -parent ${Page_0}


}

proc update_PARAM_VALUE.eta { PARAM_VALUE.eta } {
	# Procedure called to update eta when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.eta { PARAM_VALUE.eta } {
	# Procedure called to validate eta
	return true
}

proc update_PARAM_VALUE.lambda { PARAM_VALUE.lambda } {
	# Procedure called to update lambda when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.lambda { PARAM_VALUE.lambda } {
	# Procedure called to validate lambda
	return true
}

proc update_PARAM_VALUE.nu { PARAM_VALUE.nu } {
	# Procedure called to update nu when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.nu { PARAM_VALUE.nu } {
	# Procedure called to validate nu
	return true
}


proc update_MODELPARAM_VALUE.lambda { MODELPARAM_VALUE.lambda PARAM_VALUE.lambda } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.lambda}] ${MODELPARAM_VALUE.lambda}
}

proc update_MODELPARAM_VALUE.eta { MODELPARAM_VALUE.eta PARAM_VALUE.eta } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.eta}] ${MODELPARAM_VALUE.eta}
}

proc update_MODELPARAM_VALUE.nu { MODELPARAM_VALUE.nu PARAM_VALUE.nu } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.nu}] ${MODELPARAM_VALUE.nu}
}

