onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/rst_n
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/clk
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/result
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/ready
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/start
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/done
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/xsel
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/ysel
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/xload
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/yload
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/gload
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/xin
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/yin
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/eq
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/lt
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/x
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/y
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/x1
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/y1
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/xmy
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCG_DATAPATH_INST/ymx
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCD_CONTROL_UNIT_INST/C_STATE
add wave -noupdate -height 30 -radix decimal /calculator_tb/calculator_inst0/GCD_INST/GCD_CONTROL_UNIT_INST/N_STATE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {299 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 372
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {4400 ps}
