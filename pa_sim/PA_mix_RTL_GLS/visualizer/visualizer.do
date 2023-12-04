# Copyright 1991-2020 Mentor Graphics Corporation
#
# All Rights Reserved.
#
# THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION
# WHICH IS THE PROPERTY OF MENTOR GRAPHICS CORPORATION
# OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.

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

wave zoomrange 156400ns 185000ns
