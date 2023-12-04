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
if [file exists work] {
    vdel -all
}
vlib work

# compile the Verilog source files
vlog *.v

# generate foreign module declaration
scgenmod -bool ringbuf > ringbuf.h

# compile and link C source files
sccom -g test_ringbuf.cpp
sccom -link

# open debugging windows
quietly view *

# start and run simulation
vsim -voptargs="+acc+/test_ringbuf/ring_INST/block2/sig1 +acc+test_ringbuf/ring_INST/block2/sig2 +acc+/test_ringbuf/ring_INST/block2/sig3 +acc+/test_ringbuf/ring_INST/block2/sig4(0)" test_ringbuf
set StdArithNoWarnings 1
run 1000 ns
