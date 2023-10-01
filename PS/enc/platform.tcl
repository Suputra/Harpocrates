# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\saaha\Documents\Code\Research\Harpocrates-Architecture\PS\enc\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\saaha\Documents\Code\Research\Harpocrates-Architecture\PS\enc\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {enc}\
-hw {C:\Users\saaha\Documents\Code\Research\Harpocrates-Architecture\ADC_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out {C:/Users/saaha/Documents/Code/Research/Harpocrates-Architecture/PS}

platform write
platform generate -domains 
platform active {enc}
