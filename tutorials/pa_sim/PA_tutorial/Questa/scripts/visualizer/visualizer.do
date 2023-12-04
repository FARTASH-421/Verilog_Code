##############################################################################
# Source:    visualizer.do
# File:      Visualizer GUI log and wave window setup
# Remarks:   Mentor Low Power tutorial
##############################################################################

add wave -expand -group "Testbench Signals"
add wave -group "Testbench Signals" /interleaver_tester/clock1
add wave -group "Testbench Signals" /interleaver_tester/clock2
add wave -group "Testbench Signals" /interleaver_tester/reset_n
add wave -expand -group "Power Control Signals"
add wave -group "Power Control Signals" /interleaver_tester/mc_PWR
add wave -group "Power Control Signals" /interleaver_tester/mc_SAVE
add wave -group "Power Control Signals" /interleaver_tester/mc_RESTORE
add wave -group "Power Control Signals" /interleaver_tester/mc_ISO
add wave -group "Power Control Signals" /interleaver_tester/mc_CLK_GATE
add wave -group "Power Control Signals" /interleaver_tester/sram_PWR
add wave -expand -group "Power Domains"
add wave -group "Power Domains" /interleaver_tester/dut/PD_top
add wave -group "Power Domains" /interleaver_tester/dut/PD_sram
add wave -group "Power Domains" /interleaver_tester/dut/PD_mem_ctrl
add wave -group "Power Domains" /interleaver_tester/dut/PD_intl
add wave -group "Interleaver"
add wave -group "Interleaver" -ports /interleaver_tester/dut/i0/*
add wave -group "Asynchronous Bridge"
add wave -group "Asynchronous Bridge" -ports /interleaver_tester/dut/i1/*
add wave -expand -group "Memory Controller"
add wave -group "Memory Controller" -ports /interleaver_tester/dut/mc0/*
add wave -expand -group "SRAM #1"
add wave -group "SRAM #1" /interleaver_tester/dut/m1/CLK
add wave -group "SRAM #1" /interleaver_tester/dut/m1/PD
add wave -group "SRAM #1" /interleaver_tester/dut/m1/CEB_i
add wave -group "SRAM #1" /interleaver_tester/dut/m1/WEB_i
add wave -group "SRAM #1" -unsigned /interleaver_tester/dut/m1/A_i
add wave -group "SRAM #1" -unsigned /interleaver_tester/dut/m1/D
add wave -group "SRAM #1" -unsigned /interleaver_tester/dut/m1/Q

# configure wave window
    wave zoomrange 156400ns 185000ns
