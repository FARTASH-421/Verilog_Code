#Copyright 1991-2020 Mentor Graphics Corporation
#
#All Rights Reserved.
#
#THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE PROPERTY OF 
#MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.

# Use this run.do file to run this example.
# Either bring up ModelSim and type the following at the "ModelSim>" prompt:
#     do run.do
# or, to run from a shell, type the following at the shell prompt:
#     vsim -do run.do -c
# (omit the "-c" to see the GUI while running from the shell)

onbreak {resume}

# create library
if [file exists work] {
    vdel -all
}
vlib work


# compile and link C source files
sccom -suppress 6102 -I../../utils -I../basic_protocol -I../user -g main.cc
sccom -suppress 6102 -I../../utils -I../basic_protocol -I../user -g reset.cc slave.cc my_master.cc
sccom -suppress 6102 -I../../utils -I../basic_protocol -I../user -g ../user/master.cc  
sccom -suppress 6102 -I../../utils -I../basic_protocol -I../user -g ../user/mem_slave.cc  
sccom -suppress 6102 -I../../utils -I../basic_protocol -I../user -g ../user/switch_master.cc 
sccom -link

# open debugging windows
quietly view *

# start and run simulation
vsim top
run 2000 ns
quit -f
