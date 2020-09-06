#!/usr/bin/tclsh

set simtool MODELSIM
set name    "Aurélien Tseguiancap kenfack"

puts stdout "\:"
puts stdout "#########################################################"
puts stdout "#   SCRIPT FOR $simtool RTL COMPILER SYNTHESIS          "
puts stdout "#   $name, Sr,Eng 2020                                  "
puts stdout "#   USE WITH SYN - RTL -FILES                           "
puts stdout "#   REPLACE ITEMS INSIDE < > WITH YOUR OWN INFORMATION  "
puts stdout "#   TCL VERSION:: $tcl_version                          "
puts stdout "#########################################################"


#________________________________________________#
# Please run this script with the command tclsh  #
#________________________________________________#
# (Project definition [filename , path and option]
#________________________________________________#


#________________________________________________
# 
puts "INFO: Creating the common library ... "
     vlib lib_common
     vmap lib_common lib_common
     vcom -check_synthesis -work lib_common -93 ../HDL/COMMON_PKG/REG.VHD 
     vcom -check_synthesis -work lib_common -93 ../HDL/COMMON_PKG/MUX.VHD
     vcom -check_synthesis -work lib_common -93 ../HDL/COMMON_PKG/COMMON_PKG.VHD  
puts "INFO: common library created ... "


#________________________________________________
#
puts "INFO: Compiling the GCD libray  ... "
     vlib lib_gcd
     vmap lib_gcd lib_gcd
     vcom -check_synthesis -work lib_gcd -93 ../HDL/GCD/GCD_DATAPATH.VHD 
     vcom -check_synthesis -work lib_gcd -93 ../HDL/GCD/GCD_CONTROL_UNIT.VHD
     vcom -check_synthesis -work lib_gcd -93 ../HDL/GCD/GCD_PKG.VHD  
     vcom -check_synthesis -work lib_gcd -93 ../HDL/GCD/GCD_TOP.VHD 
puts "INFO: Compiling the GCD libray  completed... "


puts "INFO: Compiling the SIMPLE ALU libray  ... "
     vlib lib_alu
     vmap lib_alu lib_alu
     vcom -check_synthesis -work lib_alu -93 ../HDL/ALU/SIMPLE_ALU.VHD 
puts "INFO: Compiling the GCD libray  completed... "

#________________________________________________
# Create and map library
puts "INFO: map Testbench SV library"


puts "INFO: map Testbench PCIe library"


______________
# compile Test Bench project files
puts "INFO: Compile testbench files started... "




puts "INFO: Compile testbench files completed... "
