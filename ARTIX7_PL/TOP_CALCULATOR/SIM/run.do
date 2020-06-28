

#CLEAN THE SCREEN
.main clear
quit -sim



#############LOAD_DESIGN_MODULES ##############


##COMPILE GCD MODULES BLOCK
vcom -work work -93 ../HDL/GCD/GCD_REG.VHD 
vcom -work work -93 ../HDL/GCD/GCD_MUX.VHD 
vcom -work work -93 ../HDL/GCD/GCD_DATAPATH_PKG.VHD 
vcom -work work -93 ../HDL/GCD/GCD_DATAPATH.VHD 
vcom -work work -93 ../HDL/GCD/GCD_CONTROL_UNIT.VHD
vcom -work work -93 ../HDL/GCD/GCD_PKG.VHD  
vcom -work work -93 ../HDL/GCD/GCD_TOP.VHD 
##COMPILE


#COMPILE CALCULATOR TOP MODULE
vcom -work work -93 ../HDL/CALCULATOR_PKG.VHD 
vcom -work work -93 ../HDL/CALCULATOR.VHD 

#vlog -work work ../../../../../Verilog/test.v  

          
################LOAD VERIFICATION MODULES ############
          
vlog -work work -sv -stats=none  ../TB/CALCULATOR_Tb.sv 

#+incdir+/home/aurelientse/Documents/UVM/UVM_HOME_2017_1.0/src +define+UVM_CMDLINE_NO_DPI +define+UVM_REGEX_NO_DPI  +define+UVM_NO_DPI


#LAUNCH THE SIMULATION
vsim calculator_tb

do wave.do

#RUN THE SIMULATION 
run -all

