//----------------------------------------------------------------------
//   Copyright 2013 Mentor Graphics Corporation
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                   Mentor Graphics Inc
//----------------------------------------------------------------------
// Project         : QVIP Integration example
// Unit            : Configuration
// File            : vip_ahb_example_configuration.svh
//----------------------------------------------------------------------
// Creation Date   : 01.16.2013
//----------------------------------------------------------------------
// Description: This class defines the configuration used by the 
//    vip_ahb_example environment.  It contains a configuration for 
//    each agent within the environemnt.  The configuration for the ahb 
//    vip contains a reference to the systemVerilog interface that 
//    the agent will drive.  A handle to the interface is retrieved from
//    the uvm_config_db.  Once configured, the ahb vip configuration
//    is made available to the agent though the uvm_config_db.
//
//----------------------------------------------------------------------
//
class vip_ahb_example_configuration #(int AHB_NUM_MASTERS = 1,
                                       int AHB_NUM_MASTER_BITS = 1,
                                       int AHB_NUM_SLAVES = 1,
                                       int AHB_ADDRESS_WIDTH = 32,
                                       int AHB_WDATA_WIDTH = 32,
                                       int AHB_RDATA_WIDTH = 32 ) extends uvmf_environment_configuration_base;

  `uvm_object_param_utils( vip_ahb_example_configuration #(AHB_NUM_MASTERS,
                                                            AHB_NUM_MASTER_BITS,
                                                            AHB_NUM_SLAVES,
                                                            AHB_ADDRESS_WIDTH,
                                                            AHB_WDATA_WIDTH,
                                                            AHB_RDATA_WIDTH ));

  // This typedef is used to define the interface type retrieved from the 
  // uvm_config_db.  
  typedef virtual mgc_ahb #(AHB_NUM_MASTERS,
                            AHB_NUM_MASTER_BITS,
                            AHB_NUM_SLAVES,
                            AHB_ADDRESS_WIDTH,
                            AHB_WDATA_WIDTH,
                            AHB_RDATA_WIDTH) bfm_type;

  // This class, ahb_vip_config, defines a single configuration object that is
  // used to configure the AHB (mgc_ahb) interface. All aspects of the
  // AHB interface can be configured, including abstraction-level, clocks, and
  // reset.
  // Each member has a default value that is applied to the interface if the
  // member is not set.
  typedef ahb_vip_config #(AHB_NUM_MASTERS,
                           AHB_NUM_MASTER_BITS,
                           AHB_NUM_SLAVES,
                           AHB_ADDRESS_WIDTH,
                           AHB_WDATA_WIDTH,
                           AHB_RDATA_WIDTH) ahb_vip_config_t;

  ahb_vip_config_t ahb_master_cfg;

// ****************************************************************************
  function new( string name = "" );
    super.new( name );

    // Create a new ahb_master_cfg object (ahb_vip_config object)
    ahb_master_cfg = new();

  endfunction

// ****************************************************************************
  virtual function string convert2string();
     return {"\n"};
  endfunction
// ****************************************************************************
  function void initialize(uvmf_sim_level_t sim_level, 
                           string environment_path,
                           string interface_names[],
                           uvm_reg_block register_model = null,
                           uvmf_active_passive_t interface_activity[] = null
                           );

     if(!uvm_config_db #( bfm_type )::get( null , UVMF_VIRTUAL_INTERFACES, interface_names[0] , ahb_master_cfg.m_bfm ))
       `uvm_error("CFG" , {"uvm_config_db #( bfm_type )::get cannot find resource ", interface_names[0]} )

     //Perform the ex01_test test specific configuration.
     do_ahb_master_config();

     // Place the configured object in global configuration space.
     // This propagates the configuration items down through the
     // hierarchy (because of the "*")
     uvm_config_db #( uvm_object )::set( null , {environment_path,".ahb_master_agent*"} , mvc_config_base_id , ahb_master_cfg );

     // Place the configuration object additionally in "UVMF_CONFIGURATIONS" space
     // for retrieval by non-components, i.e. objects like the base sequence and such
     uvm_config_db #( ahb_vip_config_t )::set( null, UVMF_CONFIGURATIONS, interface_names[0], ahb_master_cfg );

  endfunction

// ****************************************************************************
// Function: do_ahb_master_config
//
// This function populates the ahb master configuration to be the master of a
// single master single slave ahb bus.

function void do_ahb_master_config();
  bfm_type bfm = ahb_master_cfg.m_bfm;

  bfm.set_config_slave_start_address_range_index1(0, 0) ;
  bfm.set_config_slave_end_address_range_index1(0,1023) ;

  // Each interface used with the MVC must be configured with an abstraction
  // level (one of w x y z). The abstraction level is defined by two bits,
  // giving the ‘WLM-connectedness’ and ‘TLM-connectedness’ for that end of
  // the interface. The abstraction level determines the behavior of the MVC
  // with respect to driving and recognizing value changes on the signals
  // driven from that end of the interface.

  // The leftmost two arguments specify the abstraction level WLM,TLM
  // WLM means Wire Level Model, and means that the abstraction level is in
  // the testbench as opposed to in the UVM class based environment.
  // TLM is Transaction Level Model, and means that the level is the 
  // UVM class based environment. 
  bfm.ahb_set_master_abstraction_level    (0,0,1);// Master 0, TLM
  bfm.ahb_set_slave_abstraction_level     (0,1,0);// Slave  0, RTL
  bfm.ahb_set_arbiter_abstraction_level     (1,0);// Arbiter, RTL

  bfm.ahb_set_clock_source_abstraction_level(1,0);// Clock,  RTL
  bfm.ahb_set_reset_source_abstraction_level(1,0);// Reset,  RTL

  // Like clock, reset, slave and arbiter above, decoder is RTL in this example. Since
  // RTL is the default abstraction level there is in principle no need to set it here,
  // and we're hence not doing that for the decoder because VTL does not support the API.
  //bfm.ahb_set_decoder_abstraction_level(1,0);// Decoder,  RTL

  bfm.set_config_user_data_support(0) ;

  ahb_master_cfg.m_ahb_lite_config = 0 ; // Not an AHB-Lite system.

  // This end is master zero.
  ahb_master_cfg.set_structural_index(0);

  // Turn off the default sequence. The sequence will
  // be invoked with task ex01_test::run_phase(uvm_phase phase);
  ahb_master_cfg.set_default_sequence(null);

endfunction

endclass

