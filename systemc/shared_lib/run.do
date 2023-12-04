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

if [file exists consumer] {
	vdel -lib consumer -all
}
if [file exists work] {
	vdel -lib work -all
}

# compile and link C source files

sccom consumer.cpp -work consumer
sccom -linkshared -work consumer

sccom producer.cpp top.cpp
sccom -link -libshared consumer

# start and run simulation
vopt top -o top_opt
vsim top_opt
run -all
