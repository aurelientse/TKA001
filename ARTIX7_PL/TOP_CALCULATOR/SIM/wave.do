onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /calculator_tb/pins_vif/rst_n
add wave -noupdate /calculator_tb/pins_vif/clk
add wave -noupdate -radix decimal /calculator_tb/pins_vif/opa
add wave -noupdate -radix decimal /calculator_tb/pins_vif/opb
add wave -noupdate /calculator_tb/pins_vif/start
add wave -noupdate /calculator_tb/pins_vif/ready
add wave -noupdate /calculator_tb/pins_vif/done
add wave -noupdate -radix decimal /calculator_tb/pins_vif/result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {667 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 262
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
WaveRestoreZoom {149 ps} {1583 ps}
