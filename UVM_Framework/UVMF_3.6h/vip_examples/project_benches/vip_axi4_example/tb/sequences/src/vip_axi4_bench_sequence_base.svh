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
// Project         : UVMF_Templates
// Unit            : vip_axi4_bench_sequence_base
// File            : vip_axi4_bench_sequence_base.svh
//----------------------------------------------------------------------
// Created by      : student
// Creation Date   : 2014/11/03
//----------------------------------------------------------------------

// Description: This file contains the top level and utility sequences
//     used by test_top. It can be extended to create derivative top
//     level sequences.
//
//----------------------------------------------------------------------
//
class vip_axi4_bench_sequence_base #(int AXI4_ADDRESS_WIDTH = 32, int AXI4_RDATA_WIDTH = 32,int AXI4_WDATA_WIDTH = 32,int AXI4_ID_WIDTH = 8,int AXI4_USER_WIDTH = 2,int AXI4_REGION_MAP_SIZE = 16) extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_param_utils( vip_axi4_bench_sequence_base #(AXI4_ADDRESS_WIDTH, AXI4_RDATA_WIDTH,AXI4_WDATA_WIDTH,AXI4_ID_WIDTH,AXI4_USER_WIDTH,AXI4_REGION_MAP_SIZE));


    typedef axi4_out_of_order_sequence #(AXI4_ADDRESS_WIDTH, AXI4_RDATA_WIDTH,AXI4_WDATA_WIDTH,AXI4_ID_WIDTH,AXI4_USER_WIDTH,AXI4_REGION_MAP_SIZE) test_sequence_t;
    test_sequence_t master_seq; 
							  
    typedef axi4_slave_sequence #(AXI4_ADDRESS_WIDTH, AXI4_RDATA_WIDTH, AXI4_WDATA_WIDTH, AXI4_ID_WIDTH, AXI4_USER_WIDTH, AXI4_REGION_MAP_SIZE ) slave_responder_sequence_t;
    slave_responder_sequence_t slave_seq; 

  // Sequencer handles for each active interface in the environment
  mvc_sequencer  master_sequencer; 
  mvc_sequencer  slave_sequencer; 
  mvc_sequencer  monitor_sequencer; 

// ****************************************************************************
  function new( string name = "" );
     super.new( name );

     // Retrieve the sequencer handles from the uvm_config_db
     if( !uvm_config_db #( mvc_sequencer )::get( null , UVMF_SEQUENCERS , MASTER_INTERFACE_BFM , master_sequencer ) ) 
    `uvm_error("CFG" , "uvm_config_db #( mvc_sequencer )::get cannot find resource master_sequencer" ) 

     if( !uvm_config_db #( mvc_sequencer )::get( null , UVMF_SEQUENCERS , SLAVE_INTERFACE_BFM , slave_sequencer ) ) 
    `uvm_error("CFG" , "uvm_config_db #( mvc_sequencer )::get cannot find resource slave_sequencer" ) 

     if( !uvm_config_db #( mvc_sequencer )::get( null , UVMF_SEQUENCERS , MONITOR_INTERFACE_BFM , monitor_sequencer ) ) 
    `uvm_error("CFG" , "uvm_config_db #( mvc_sequencer )::get cannot find resource monitor_sequencer" ) 

  endfunction


// ****************************************************************************
  virtual task body();

`ifdef QVIP_PRE_10_4_BACKWARD_COMPATIBLE
    // No 10.4 AXI4 agent class so need to explicitly create and start slave sequence
    slave_seq = slave_responder_sequence_t::type_id::create("slave_sequence");
    fork
    begin
       slave_seq.start(slave_sequencer);
    end
    join_none
`endif

    master_seq = test_sequence_t::type_id::create("master_sequence");
    master_seq.start(master_sequencer);

  endtask

endclass
