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
//                   Mentor Graphics Inc
//----------------------------------------------------------------------
// Project         : AHB interface agent
// Unit            : Typedefs
// File            : ahb_typedefs_hdl.svh
//----------------------------------------------------------------------
// Creation Date   : 05.12.2011
//----------------------------------------------------------------------
// Description:

// FILE: ahb_hdl_typedefs.svh
// This file contains defines and typedefs to be compiled and synthesized
// for use in Veloce.  It is also used by the interface package that is 
// used by the host server performing transaction level simulation 
// activities.

parameter int  AHB_DATA_WIDTH = 16;

parameter int  AHB_ADDR_WIDTH = 32;

typedef enum {AHB_RESET, AHB_READ, AHB_WRITE} ahb_op_t;
