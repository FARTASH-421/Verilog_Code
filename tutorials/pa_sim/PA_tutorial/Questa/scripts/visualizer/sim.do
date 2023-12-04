##############################################################################
# Source:    sim.do
# File:      Questa Classic GUI log and wave window setup
# Remarks:   Mentor Low Power tutorial
##############################################################################
onbreak {resume}
if {[batch_mode]} {
    onerror {quit -f}
}

pa msg -disable -pa_checks=irc
pa msg -pa_checks=rsa -stopafter 5
pa msg -pa_checks=rtc -stopafter 5

# run simulation
run 192830 ns

pa msg -disable -pa_checks=rsa
pa msg -disable -pa_checks=rtc
run -continue

# quit simulation
if {[batch_mode]} {
    quit -f
}
quit -f
