#________________________________________________#
#________________________________________________#
#________________________________________________#
# (Project definition [filename , path and option]





#___________________________________________________________
# Create and map library
puts "INFO: map Testbench SV library"


puts "INFO: map Testbench PCIe library"


#__________________________________________________________
# compile Test Bench project files
puts "INFO: Compile DUT files started... "
vcom -check_synthesis -work work -93 ../HDL/COMMON_PKG/REG.VHD 
vcom -check_synthesis -work work -93 ../HDL/COMMON_PKG/MUX.VHD
vcom -check_synthesis -work work -93 ../HDL/COMMON_PKG/COMMON_PKG.VHD 

vcom -check_synthesis -work work -93 ../HDL/GCD/GCD_DATAPATH.VHD 
vcom -check_synthesis -work work -93 ../HDL/GCD/GCD_CONTROL_UNIT.VHD
vcom -check_synthesis -work work -93 ../HDL/GCD/GCD_PKG.VHD  
vcom -check_synthesis -work work -93 ../HDL/GCD/GCD_TOP.VHD 
##COMPILE
puts "INFO: Compile DUT files completed... "
#___________________________________________________________
# compile Test Bench project files
puts "INFO: Compile testbench files started... "


puts "INFO: Compile testbench files completed... "
