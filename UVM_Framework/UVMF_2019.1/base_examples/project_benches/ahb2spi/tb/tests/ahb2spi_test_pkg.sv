//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : boden
// Creation Date   : 2016 Sep 26
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : ahb2spi Simulation Bench 
// Unit            : Test package
// File            : ahb2spi_test_pkg.sv
//----------------------------------------------------------------------
//
// DESCRIPTION: This package contains all tests currently written for
//     the simulation project.  Once compiled, any test can be selected
//     from the vsim command line using +UVM_TESTNAME=yourTestNameHere
//
// CONTAINS:
//     -<test_top>
//     -<example_derived_test>
//
//----------------------------------------------------------------------
//

package ahb2spi_test_pkg;

   import uvm_pkg::*;
   import uvmf_base_pkg::*;
   import ahb2spi_parameters_pkg::*;
   import ahb2spi_env_pkg::*;
   import ahb2spi_sequences_pkg::*;


   `include "uvm_macros.svh"

   `include "src/test_top.svh"
   `include "src/regmodel_test.svh"
   `include "src/example_derived_test.svh"

endpackage

