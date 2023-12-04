#ifndef TOP_MODULE__H
#define TOP_MODULE__H

#include "consumer.h"
#include "producer.h"

SC_MODULE(top)
{
    sc_clock clk;
    sc_signal<bool> rst;
    sc_signal<sc_uint<32> > data;

    consumer cons;
    producer prod;

    void main_loop();

    SC_CTOR(top) :
        clk("clk", 2.0, SC_NS),
        rst("rst"),
        data("data"),
        cons("cons"),
        prod("prod")
    {
        cons.clk(clk);
        cons.rst(rst);
        cons.data(data);

        prod.clk(clk);
        prod.rst(rst);
        prod.data(data);

        SC_THREAD(main_loop);
    }
};

#endif