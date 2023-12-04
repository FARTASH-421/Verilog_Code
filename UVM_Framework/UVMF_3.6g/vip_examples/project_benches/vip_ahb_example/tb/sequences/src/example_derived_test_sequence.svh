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
// Unit            : Test 1 top level sequence
// File            : example_derived_test_sequence.svh
//----------------------------------------------------------------------
// Creation Date   : 01.16.2013
//----------------------------------------------------------------------
// Description: This test extends the base top level sequence and
//    makes specific changes to generate the desired stimulus for
//    example_derived_test.
//
//----------------------------------------------------------------------
//
class example_derived_test_sequence  #(int AHB_NUM_MASTERS = 1,
                        int AHB_NUM_MASTER_BITS = 1,
                        int AHB_NUM_SLAVES = 1,
                        int AHB_ADDRESS_WIDTH = 32,
                        int AHB_WDATA_WIDTH = 32,
                        int AHB_RDATA_WIDTH = 32,
                        type REQ=uvm_sequence_item,
                        type RSP=uvm_sequence_item
                        ) extends vip_ahb_example_sequence_base
                                                         #(AHB_NUM_MASTERS,
                                                           AHB_NUM_MASTER_BITS,
                                                           AHB_NUM_SLAVES,
                                                           AHB_ADDRESS_WIDTH,
                                                           AHB_WDATA_WIDTH,
                                                           AHB_RDATA_WIDTH,
                                                           REQ,RSP);

  `uvm_object_param_utils( example_derived_test_sequence #(AHB_NUM_MASTERS,
                                            AHB_NUM_MASTER_BITS,
                                            AHB_NUM_SLAVES,
                                            AHB_ADDRESS_WIDTH,
                                            AHB_WDATA_WIDTH,
                                            AHB_RDATA_WIDTH,
                                            REQ,RSP));

  function new(string name = "" );
    super.new(name);
  endfunction

endclass
