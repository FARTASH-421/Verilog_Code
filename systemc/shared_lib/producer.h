#ifndef PRODUCER_MODULE__H
#define PRODUCER_MODULE__H

#include "systemc.h"

SC_MODULE(producer)
{
  sc_in<bool> clk;
  sc_in<bool> rst;
  sc_out<sc_dt::sc_uint<32> > data;

  void generator();

    SC_CTOR(producer)
    : clk("clk"),
      rst("rst"),
      data("data")
  {
      SC_THREAD(generator);
  }
};

#endif
