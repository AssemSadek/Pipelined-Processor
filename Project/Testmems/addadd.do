onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /corei9/Clk
add wave -noupdate /corei9/Reset
add wave -noupdate /corei9/RGFL/R0/Q
add wave -noupdate /corei9/RGFL/R1/Q
add wave -noupdate /corei9/F_D_PC
add wave -noupdate /corei9/F_D_InstCode
add wave -noupdate /corei9/D_E_WB
add wave -noupdate /corei9/D_E_Ra
add wave -noupdate /corei9/D_E_Rb
add wave -noupdate /corei9/D_E_Vra
add wave -noupdate /corei9/D_E_Vrb
add wave -noupdate /corei9/E_M_WB
add wave -noupdate /corei9/E_M_Ra
add wave -noupdate /corei9/E_M_Result
add wave -noupdate /corei9/M_WB_WB
add wave -noupdate /corei9/M_WB_Data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {454 ns} 0}
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
WaveRestoreZoom {221 ns} {721 ns}
