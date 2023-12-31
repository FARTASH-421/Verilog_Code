// *****************************************************************************
//
// Copyright 2015-2017 Mentor Graphics Corporation
// All Rights Reserved.
//
// THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE 
// PROPERTY OF MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO 
// LICENSE TERMS.
//
// *****************************************************************************

//
// CLASS:- axi4_slave_rw_adapter
//
// The adapter class converts the top level read-write transaction item
// <axi4_master_rw_transaction> to generic payload item <rw_txn>.
//
// After conversion, generic payload item is written to the following
// analysis port
// 
// - <port_rw> - Analysis port writing the <rw_txn> sequence item
//
class axi4_slave_rw_adapter #(int AXI4_ADDRESS_WIDTH   = 32,
                              int AXI4_RDATA_WIDTH     = 32, 
                              int AXI4_WDATA_WIDTH     = 32, 
                              int AXI4_ID_WIDTH        = 4, 
                              int AXI4_USER_WIDTH      = 4, 
                              int AXI4_REGION_MAP_SIZE = 16
                             ) extends mvc_item_listener #(
                                  axi4_master_rw_transaction #(AXI4_ADDRESS_WIDTH,
                                                               AXI4_RDATA_WIDTH,
                                                               AXI4_WDATA_WIDTH,
                                                               AXI4_ID_WIDTH,
                                                               AXI4_USER_WIDTH,
                                                               AXI4_REGION_MAP_SIZE));

  typedef axi4_slave_rw_adapter #(AXI4_ADDRESS_WIDTH,
                            AXI4_RDATA_WIDTH,
                            AXI4_WDATA_WIDTH,
                            AXI4_ID_WIDTH,
                            AXI4_USER_WIDTH,
                            AXI4_REGION_MAP_SIZE) slave_rw_adapt_t;

  `uvm_component_param_utils(slave_rw_adapt_t)

  typedef bit [(AXI4_ADDRESS_WIDTH-1) : 0] addr_t;

  typedef axi4_master_rw_transaction #(AXI4_ADDRESS_WIDTH,
                                       AXI4_RDATA_WIDTH,
                                       AXI4_WDATA_WIDTH,
                                       AXI4_ID_WIDTH,
                                       AXI4_USER_WIDTH,
                                       AXI4_REGION_MAP_SIZE) axi4_rw_txn_t;

  // Variable:- port_rw
  //
  // An analysis port of type <rw_txn> that encapsulates read or write request
  // with respective addr, data and strobe values. This basically represents
  // a generic read-write payload. Users could directly connect through this
  // analysis port to receive simplified generic payload format of bus
  // read-write transactions.
  //
  // uvm_analysis_port #(rw_txn) port_rw;
  uvm_analysis_port #(rw_txn) port_rw_m0;
  uvm_analysis_port #(rw_txn) port_rw_m1;

  rw_txn generic_pl;

  function new(string name="", uvm_component parent = null);
    super.new(name, parent);
    // port_rw = new("port_rw", this);
    port_rw_m0 = new("port_rw_m0", this);
    port_rw_m1 = new("port_rw_m1", this);
  endfunction

  // Function:- do_write
  //
  // This is the standard UVM run phase
  //
  extern function void do_write(axi4_rw_txn_t t);

  // Function:- conv_to_rw
  //
  // This function is used to convert input AXI4 specific sequence item
  // to generic RW txn and then write to <port_rw> analysis port.
  //
  extern function void conv_to_rw(input axi4_rw_txn_t bus_item);

  // Function:- get_rw_addr_data
  //
  extern virtual function void get_rw_addr_data(input axi4_rw_txn_t trans,
                                        output addr_t addr[],
                                        output bit [7:0] data[],
                                        output bit strobes[]);

endclass

// do_write
// --------
function void axi4_slave_rw_adapter::do_write(axi4_rw_txn_t t);
  conv_to_rw(t);

  // port_rw.write(generic_pl);
endfunction


// conv_to_rw
// ----------
function void axi4_slave_rw_adapter::conv_to_rw(input axi4_rw_txn_t bus_item);

  addr_t addr[];
  bit [7:0] data[];
  bit strobes[];

  int resp_size;
  byte t_mem[addr_t];
  addr_t min_addr_index;

  generic_pl = rw_txn::type_id::create("generic_pl");

  assert($cast(generic_pl.sequence_item,bus_item));

  get_rw_addr_data(bus_item, addr, data, strobes);

  if (bus_item.read_or_write == AXI4_TRANS_READ)
    generic_pl.cmd = rw_txn::READ;
  else
    generic_pl.cmd = rw_txn::WRITE;

  // generic_pl.id = bus_item.id;  // WIDTH Conversion
  generic_pl.id = bus_item.id[AXI4_ID_WIDTH-2:0];  // WIDTH Conversion  // lop off MSB bit added by fabric

  generic_pl.size = addr.size();
  for (int i = 0; i < addr.size(); ++i)
    t_mem[addr[i]] = data[i];

  generic_pl.data    = new[1];

  if (t_mem.first(min_addr_index)) begin
    generic_pl.addr       = min_addr_index;
    generic_pl.data[0]    = t_mem[min_addr_index];

    t_mem.delete(min_addr_index);
  end

  while (t_mem.first(min_addr_index)) begin
    generic_pl.data    = new[(min_addr_index - generic_pl.addr + 1)](generic_pl.data);
    generic_pl.data[(min_addr_index - generic_pl.addr)]    = t_mem[min_addr_index];

    t_mem.delete(min_addr_index);
  end
  generic_pl.strobes = strobes;

  resp_size = bus_item.resp.size();
  generic_pl.status = rw_txn::OKAY;

  for (int i = 0; i < resp_size; ++i)
  begin
    if ((bus_item.resp[i] == AXI4_SLVERR) ||
        (bus_item.resp[i] == AXI4_DECERR))
    begin
      generic_pl.status = rw_txn::ERROR;
      i = resp_size;
    end
  end

  `uvm_info("ADAPT", $psprintf({"generic_rw_transaction contents = %p"}, generic_pl), UVM_MEDIUM)

  // Now route the txn to appropriate ap based on 'id' attribute.
  // In particular, if msb of 'id' attribute is set, this indicates it should be routed to m1 sb. Else write to m0 sb.
  // Note: all txn's originating from either master will have id values less than 15, the extra bit is added by the interconnect before being sent to appropriate slave
  // port_rw.write(generic_pl);
  if (bus_item.id[AXI4_ID_WIDTH-1])
     port_rw_m1.write(generic_pl);
  else
     port_rw_m0.write(generic_pl);

endfunction


function void axi4_slave_rw_adapter::get_rw_addr_data(input axi4_rw_txn_t trans,
                                                output addr_t addr[],
                                                output bit [7:0] data[],
                                                output bit strobes[]);
  int unsigned wrap_boundary;
  addr_t aligned_addr;
  addr_t adjusted_addr;
  addr_t next_addr, curr_addr;
  addr_t lower_wrap_boundary;
  addr_t upper_wrap_boundary;

  bit [7:0]  lower_byte_lane, upper_byte_lane;
  int        data_bus_bytes = (AXI4_RDATA_WIDTH/8);
  int        number_bytes = 1<<trans.size;
  int        byte_counter;

  aligned_addr    = ((trans.addr/number_bytes) * number_bytes);
  adjusted_addr   = ((trans.addr/data_bus_bytes) * data_bus_bytes);
  lower_byte_lane = trans.addr - adjusted_addr;
  upper_byte_lane = aligned_addr + (number_bytes-1)-adjusted_addr;

  if(trans.burst === AXI4_WRAP)
  begin
    lower_wrap_boundary=((trans.addr/(number_bytes*(trans.burst_length+1))) *
                         (number_bytes*(trans.burst_length+1)));
    upper_wrap_boundary=lower_wrap_boundary+(number_bytes*(trans.burst_length+1));
  end

  next_addr = aligned_addr;

  for(int beat_number = 0; beat_number < (trans.burst_length+1); beat_number++)
  begin
    if((beat_number != 0) && (trans.burst != AXI4_FIXED))
    begin
      next_addr = next_addr + number_bytes;

      if((trans.burst === AXI4_WRAP) && (next_addr == upper_wrap_boundary))
        next_addr = lower_wrap_boundary;

      if(trans.burst !== AXI4_FIXED)
      begin
        lower_byte_lane = next_addr - ((next_addr/data_bus_bytes) * data_bus_bytes);
        upper_byte_lane = lower_byte_lane + number_bytes - 1;
      end
    end

    curr_addr = next_addr;

    for(int i = lower_byte_lane; i <= upper_byte_lane; i++)
    begin
      addr = new[(byte_counter + 1)](addr);
      strobes = new[(byte_counter + 1)](strobes);
      data = new[(byte_counter + 1)](data);
      addr[byte_counter] = curr_addr++;

      if (trans.read_or_write == AXI4_TRANS_READ)
      begin
        data[byte_counter] = trans.rdata_words[beat_number][(8*(i+1)-1)-:8];
        strobes[byte_counter] = 1;        
      end
      else if(trans.write_strobes[beat_number][i] == 1)
      begin
        data[byte_counter] = trans.wdata_words[beat_number][(8*(i+1)-1)-:8];
        strobes[byte_counter] = 1;        
      end
       
      byte_counter++;
    end 
  end
endfunction
