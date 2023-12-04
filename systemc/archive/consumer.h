#ifndef CONSUMER_MODULE__H
#define CONSUMER_MODULE__H

#include "systemc.h"

SC_MODULE(consumer)
{
    sc_in<bool> clk;
    sc_in<bool> rst;
    sc_in<sc_dt::sc_uint<32> > data;

    void receiver();

    SC_CTOR(consumer)
      : clk("clk"),
        rst("rst"),
        data("data")
    {
        SC_METHOD(receiver);
          dont_initialize();
          sensitive << data;
    }
};

#endif