//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : boden
// Creation Date   : 2016 Nov 30
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : gpio_example Simulation Bench 
// Unit            : Bench level parameters package
// File            : gpio_example_parameters_pkg.sv
//----------------------------------------------------------------------
// 
//                                         
//----------------------------------------------------------------------
//

package gpio_example_parameters_pkg;

import uvmf_base_pkg_hdl::*;


// These parameters are used to uniquely identify each interface.  The monitor_bfm and
// driver_bfm are placed into and retrieved from the uvm_config_db using these string 
// names as the field_name. The parameter is also used to enable transaction viewing 
// from the command line for selected interfaces using the UVM command line processing.

parameter string gpio_pkg_gpio_a_BFM  = "gpio_pkg_gpio_a_BFM"; /* [0] */
parameter string gpio_pkg_gpio_b_BFM  = "gpio_pkg_gpio_b_BFM"; /* [1] */

parameter string CLOCK_CONTROLLER = "clock_controller";
parameter string RESET_CONTROLLER = "reset_controller";


endpackage

