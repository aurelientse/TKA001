
#CLEAN THE SCREEN
.main clear
quit -sim



#############LOAD_DESIGN_MODULES ##############


#COMPILE COMMON TYPE PACKAGES
vcom -check_synthesis -work work -93 ../HDL/COMMON_PKG/REG.VHD 
vcom -check_synthesis -work work -93 ../HDL/COMMON_PKG/MUX.VHD
vcom -check_synthesis -work work -93 ../HDL/COMMON_PKG/COMMON_PKG.VHD 


##COMPILE GCD MODULES BLOCK
vcom -check_synthesis -work work -93 ../HDL/GCD/GCD_DATAPATH.VHD 
vcom -check_synthesis -work work -93 ../HDL/GCD/GCD_CONTROL_UNIT.VHD
vcom -check_synthesis -work work -93 ../HDL/GCD/GCD_PKG.VHD  
vcom -check_synthesis -work work -93 ../HDL/GCD/GCD_TOP.VHD 
##COMPILE
vcom -check_synthesis -work work -93 ../HDL/ALU/SIMPLE_ALU.VHD 



#COMPILE CALCULATOR TOP MODULE
vcom -check_synthesis -work work -93 ../HDL/CALCULATOR_PKG.VHD 
vcom -check_synthesis -work work -93 ../HDL/CALCULATOR.VHD 



#vlog -work work ../../../../../Verilog/test.v  
          
################[LOAD VERIFICATION MODULES] ##################

vlog -work work -sv ../TB/tr_pkg/types_pkg.svh


################# [VIP COMPONENTS] ###########################
vlog -work work -sv ../TB/tb_interface/pins_if.svh

vlog -work work -sv ../TB/vip_component/stimgen.svh
vlog -work work -sv ../TB/vip_component/driver.svh
vlog -work work -sv ../TB/vip_component/monitor.svh
vlog -work work -sv ../TB/vip_component/reference.svh    
vlog -work work -sv ../TB/vip_component/comparator.svh 
vlog -work work -sv ../TB/vip_component/vip_component_pkg.svh
vlog -work work -sv ../TB/env.svh
          
#####@NOTE : vlog -work work -sv ../TB/prog.sv################
###### CANT USE PROGRAM, ASSERTIONS, COVERAGE, RANDOM ########
###### BECAUSE OF STUDENT VERSION ############################  
################# [TESTBENCH TOP] ############################

         
vlog -work work -sv -stats=none  ../TB/CALCULATOR_Tb.sv 

#-------------------------------------------------------------------------------------------
# Compile testbench
#-------------------------------------------------------------------------------------------
# Macro DISPLAY_MESSAGES_STIMGEN 	- activates messages from stimgen during simulation
# Macro DISPLAY_MESSAGES_DRIVER        - activates messages from driver during simulation
#-------------------------------------------------------------------------------------------

vlog +define+DISPLAY_MESSAGES_STIMGEN +define+DISPLAY_MESSAGES_DRIVER +define+DISPLAY_MESSAGES_MONITOR -f calculator_filelist.f


#+incdir+/home/aurelientse/Documents/UVM/UVM_HOME_2017_1.0/src +define+UVM_CMDLINE_NO_DPI +define+UVM_REGEX_NO_DPI  +define+UVM_NO_DPI


#LAUNCH THE SIMULATION
vsim calculator_tb

do wave.do

#RUN THE SIMULATION 
run -all

