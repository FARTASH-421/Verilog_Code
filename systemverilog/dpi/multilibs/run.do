#
# Copyright 1991-2020 Mentor Graphics Corporation
#
# All Rights Reserved.
#
# THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION
# WHICH IS THE PROPERTY OF MENTOR GRAPHICS CORPORATION
# OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.
#
# To run this example, bring up the simulator and type the following at the prompt:
#     do run.do
# or, to run from a shell, type the following at the shell prompt:
#     vsim -c -do run.do
# (omit the "-c" to see the GUI while running from the shell)
#

onerror {resume}
# Create the library.
if [file exists work_hvl] {
    vdel -lib work_hvl -all
}
if [file exists work_hdl] {
    vdel -lib work_hdl -all
}

vlib work_hvl
vlib work_hdl

# Compile the HDL source(s)
vlog -sv -work work_hdl -dpiheader dpiheader.h hello.sv 

sccom -work work_hvl hello.cpp 

sccom -link -work work_hvl

vopt -work work_hvl -o top_vopt work_hdl.top work_hvl.hello -dpilib work_hdl -undefsyms=verbose

# Simulate the design.
onerror {quit -sim}

vsim -c top_vopt -lib work_hvl -dpioutoftheblue 2 -undefsyms=verbose

run -all
quit -f
