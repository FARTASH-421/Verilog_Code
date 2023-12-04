# Copyright 1991-2020 Mentor Graphics Corporation
#
# All Rights Reserved.
#
# THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION
# WHICH IS THE PROPERTY OF MENTOR GRAPHICS CORPORATION
# OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.

# Use this run.do file to run this example.
# Either bring up ModelSim and type the following at the "ModelSim>" prompt:
#     do run.do
# or, to run from a shell, type the following at the shell prompt:
#     vsim -do run.do -c
# (omit the "-c" to see the GUI while running from the shell)

onbreak {resume}

# create library
if [file exists work_hvl] {
    vdel -lib work_hvl -all
}
if [file exists work_hdl] {
    vdel -lib work_hdl -all
}

vlib work_hvl

vlib work_hdl

#compile SystemVerilog source file
vlog hello.sv -work work_hdl

# compile and link C source files
sccom -g -DMTI_BIND_SC_MEMBER_FUNCTION hello.cpp -work work_hvl
sccom -link -work work_hvl -dpilib work_hdl

vopt -work work_hvl -o top_vopt work_hdl.top work_hvl.hello -L work_hdl

# start and run simulation
vsim -c -lib work_hvl top_vopt

run -all
quit -f 
