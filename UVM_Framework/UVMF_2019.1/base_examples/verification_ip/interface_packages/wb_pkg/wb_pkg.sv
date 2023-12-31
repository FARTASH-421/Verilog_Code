//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : jcraft
// Creation Date   : 2016 Nov 03
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : wb interface agent
// Unit            : Interface HVL package
// File            : wb_pkg.sv
//----------------------------------------------------------------------
//     
// PACKAGE: This file defines all of the files contained in the
//    interface package that will run on the host simulator.
//
// CONTAINS:
//    - <wb_typedefs_hdl>
//    - <wb_typedefs.svh>
//    - <wb_transaction.svh>

//    - <wb_configuration.svh>
//    - <wb_driver.svh>
//    - <wb_monitor.svh>

//    - <wb_transaction_coverage.svh>
//    - <wb_sequence_base.svh>
//    - <wb_infact_sequence.svh>
//    - <wb_responder_sequence.svh>
//    - <wb2reg_adapter.svh>
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
package wb_pkg;
  
   import uvm_pkg::*;
   import uvmf_base_pkg_hdl::*;
   import uvmf_base_pkg::*;
   import wb_pkg_hdl::*;
   `include "uvm_macros.svh"
   
   export wb_pkg_hdl::*;

   `include "src/wb_typedefs.svh"
   `include "src/wb_transaction.svh"

   `include "src/wb_configuration.svh"
   `include "src/wb_driver.svh"
   `include "src/wb_monitor.svh"

   `include "src/wb_transaction_coverage.svh"
   `include "src/wb_sequence_base.svh"
   `include "src/wb_master_access_sequence.svh"
   `include "src/wb_infact_sequence.svh"
   `include "src/wb_random_sequence.svh"
   `include "src/wb_memory_slave_sequence.svh"
   `include "src/wb_slave_access_sequence.svh"
   `include "src/wb_reset_sequence.svh"
   `include "src/wb2reg_adapter.svh"

   `include "src/wb_agent.svh"

endpackage

