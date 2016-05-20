onerror {resume}
quietly WaveActivateNextPane {} 0
vsim work.corei9
mem load -i {D:/Project/TestCases/twoOperand/twoOperand.mem} /corei9/InstMemory/ram
mem load -i {D:/Project/TestCases/twoOperand/twoOperandDataMemory.mem} /corei9/DataMemory/ram
add wave -noupdate /corei9/Clk
add wave -noupdate /corei9/Reset
add wave -noupdate /corei9/InPort
add wave -noupdate /corei9/OutPort
add wave -noupdate /corei9/Interrupt
add wave -noupdate /corei9/F_D_PC
add wave -noupdate /corei9/RGFL/R0/Q
add wave -noupdate /corei9/RGFL/R1/Q
add wave -noupdate /corei9/RGFL/R2/Q
add wave -noupdate /corei9/RGFL/R3/Q
add wave -noupdate /corei9/RGFL/R4/Q
add wave -noupdate /corei9/RGFL/R5/Q
add wave -noupdate /corei9/RGFL/R6/Q
add wave -noupdate /corei9/RGFL/R7/Q
add wave -noupdate /corei9/RGFL/CCR/Q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {136 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
force -freeze sim:/corei9/Clk 0 0, 1 {50 ns} -r 100
force -freeze sim:/corei9/Reset 1 0
force -freeze sim:/corei9/Interrupt 0 0
run
force -freeze sim:/corei9/Reset 0 0
run
run
run
run
run
run
run
force -freeze sim:/corei9/Interrupt 1 0
run
force -freeze sim:/corei9/Interrupt 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run