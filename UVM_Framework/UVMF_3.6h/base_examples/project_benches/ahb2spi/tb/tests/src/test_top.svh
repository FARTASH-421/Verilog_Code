//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : boden
// Creation Date   : 2016 Sep 26
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : ahb2spi Simulation Bench 
// Unit            : Top level UVM test
// File            : test_top.svh
//----------------------------------------------------------------------
// Description: This top level UVM test is the base class for all
//     future tests created for this project.
//
//     This test class contains:
//          Configuration:  The top level configuration for the project.
//          Environment:    The top level environment for the project.
//          Top_level_sequence:  The top level sequence for the project.
//                                          
//----------------------------------------------------------------------
//

class test_top extends uvmf_test_base #(.CONFIG_T(ahb2spi_env_configuration#(.WB_ADDR_WIDTH(WB_ADDR_WIDTH),.WB_DATA_WIDTH(WB_DATA_WIDTH))), 
                                        .ENV_T(ahb2spi_environment#(.WB_ADDR_WIDTH(WB_ADDR_WIDTH),.WB_DATA_WIDTH(WB_DATA_WIDTH))), 
                                        .TOP_LEVEL_SEQ_T(ahb2spi_bench_sequence_base));

  `uvm_component_utils( test_top );


string interface_names[] = {
    ahb_pkg_ahb_BFM /* ahb     [0] */ , 
    wb_pkg_wb_BFM /* wb     [1] */ , 
    wb_pkg_wb_BFM /* wb     [2] */ , 
    spi_pkg_spi_BFM /* spi     [3] */ 
};

uvmf_active_passive_t interface_activities[] = { 
    ACTIVE /* ahb     [0] */ , 
    PASSIVE /* wb     [1] */ , 
    PASSIVE /* wb     [2] */ , 
    ACTIVE /* spi     [3] */ 
};


// ****************************************************************************
// FUNCTION: new()
// This is the standard system verilog constructor.  All components are 
// constructed in the build_phase to allow factory overriding.
//
  function new( string name = "", uvm_component parent = null );
     super.new( name ,parent );
  endfunction




// ****************************************************************************
// FUNCTION: build_phase()
// The construction of the configuration and environment classes is done in
// the build_phase of uvmf_test_base.  Once the configuraton and environment
// classes are built then the initialize call is made to perform the
// following: 
//     Monitor and driver BFM virtual interface handle passing into agents
//     Set the active/passive state for each agent
// Once this build_phase completes, the build_phase of the environment is
// executed which builds the agents.
//
  virtual function void build_phase(uvm_phase phase);

    super.build_phase(phase);
    configuration.initialize(BLOCK, "uvm_test_top.environment", interface_names, null, interface_activities);
  endfunction

endclass

