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
#     vsim -do run.do -c
# (omit the "-c" to see the GUI while running from the shell)

onbreak {resume}
#if {[batch_mode]} {
#    echo "Run this test in the GUI mode."
#    quit -f
#}

# Create the library.
if [file exists work] {
    vdel -all
}
vlib work

# Compile the source files.
vlog -work work -f compile_rtl.f

# Optimize the design.
 vopt -work work -access=r+/. -pa_enable=highlight+debug \
     interleaver_tester \
     -pa_upf rtl_top.upf \
     -pa_top "/interleaver_tester/dut" \
     -pa_genrpt=pa+de+ud \
     -pa_checks=s+ul+i+r+p+cp+upc+ugc -pa_coverage=state \
     +designfile \
     -o top_opt

# Simulate the design and view the results.
vsim top_opt \
     -vopt_verbose \
     +nowarnTSCALE \
     +nowarnTFMPC \
     -l rtl.log \
     -wlf rtl.wlf \
     -pa \
     -pa_highlight \
     -coverage \
     +notimingchecks \
     -msgmode both \
     -qwavedb=+signal \
     -displaymsgmode both

pa msg -disable -pa_checks=irc
pa msg -stopafter 5 -pa_checks=rsa
pa msg -stopafter 5 -pa_checks=rtc

run -all
pa msg -disable -pa_checks=r

run -continue
coverage report -detail -pa
coverage save -pa pa.ucdb
vcover report pa.ucdb -pa

quit -f
