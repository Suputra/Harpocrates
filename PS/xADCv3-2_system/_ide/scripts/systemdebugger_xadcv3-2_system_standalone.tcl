# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: D:\Vitis\xADCv3-2_system\_ide\scripts\systemdebugger_xadcv3-2_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source D:\Vitis\xADCv3-2_system\_ide\scripts\systemdebugger_xadcv3-2_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-SMT1 210203A62EBCA" && level==0 && jtag_device_ctx=="jsn-JTAG-SMT1-210203A62EBCA-23727093-0"}
fpga -file D:/Vitis/xADCv3-2/_ide/bitstream/xADCv3.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw D:/Vitis/xADCv3_2/export/xADCv3_2/hw/xADCv3_2.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source D:/Vitis/xADCv3-2/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow D:/Vitis/xADCv3-2/Debug/xADCv3-2.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
