//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : boden
// Creation Date   : 2016 Sep 26
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : wb2spi Simulation Bench 
// Unit            : Bench level parameters package
// File            : wb2spi_parameters_pkg.sv
//----------------------------------------------------------------------
// 
//                                         
//----------------------------------------------------------------------
//

package wb2spi_parameters_pkg;

import uvmf_base_pkg_hdl::*;

// These parameters are used to uniquely identify each interface.  The monitor_bfm and
// driver_bfm are placed into and retrieved from the uvm_config_db using these string 
// names as the field_name. The parameter is also used to enable transaction viewing 
// from the command line for selected interfaces using the UVM command line processing.

parameter string wb_pkg_wb_BFM  = "wb_pkg_wb_BFM"; /* [0] */
parameter string spi_pkg_spi_BFM  = "spi_pkg_spi_BFM"; /* [1] */

parameter int WB_ADDR_WIDTH = 2;
parameter int WB_DATA_WIDTH = 8;


endpackage

