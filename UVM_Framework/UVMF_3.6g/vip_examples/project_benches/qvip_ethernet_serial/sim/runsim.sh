
make_filelist.py sim.vinfo
vlog -f sim.vf
vopt +acc hdl_top -o hdl_top_opt
vopt +acc hvl_top -o hvl_top_opt
#UVMF_CHANGE_ME: Insert your test name below for the UVM_TESTNAME command line argument
vsim hvl_top_opt hdl_top_opt +UVM_TESTNAME=ahb_random_test "+uvm_set_config_int=*,enable_transaction_viewing,1" -do " set NoQuitOnFinish 1; onbreak {resume}; run 0; do wave.do"
