// Copyright 1991-2020 Mentor Graphics Corporation

// All Rights Reserved.

// THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION
// WHICH IS THE PROPERTY OF MENTOR GRAPHICS CORPORATION
// OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.

#include "test_ringbuf.h"
#include <iostream>


SC_MODULE_EXPORT(test_ringbuf);


//
// Reset pulse generator.
// The first time it runs at initialization and sets reset low.
// It schedules a wakeup at time 400 ns, and at that time sets
// reset high (inactive).
//
void test_ringbuf::reset_generator()
{
    static bool first = true;
    if (first)
    {
        first = false;
        reset.write(SC_LOGIC_0);
        reset_deactivation_event.notify(400, SC_NS);
    }
    else
        reset.write(SC_LOGIC_1);
}


//
// Generates a pseudo-random data stream that is
// used as the input to the ring buffer.
// The process fires on the posedge of txc.
//
void test_ringbuf::generate_data()
{
    // Use a 20-bit LFSR to generate data
    if (reset.read() == 0)
    {
        // Reset pseudo-random data
        pseudo.write(0);
        txda.write(SC_LOGIC_0);
    }
    else
    {
        sc_lv<20> var_pseudo = pseudo.read();
        sc_lv<20> var_pseudo_newval = (var_pseudo.range(18, 0), var_pseudo[2] ^ ~var_pseudo[19]);
        pseudo.write(var_pseudo_newval);

        if (var_pseudo_newval[19] != var_pseudo[19])
            txda.write(var_pseudo_newval[19]);
    }
}


//
// On every negedge of the clock, compare actual and expected data.
//
void test_ringbuf::compare_data()
{
    sc_logic var_dataerror_newval = actual.read() ^ ~expected.read();
    dataerror.write(var_dataerror_newval);

    if (reset.read() == SC_LOGIC_0)
    {
        storage.write(0);
        expected.write(SC_LOGIC_0);
        actual.write(SC_LOGIC_0);
    }
    else
    {
        if (outstrobe.read() == SC_LOGIC_1)
        {
            sc_lv<20> var_storage = storage.read();
            sc_lv<20> var_storage_newval = (var_storage.range(18, 0), rxda.read());
            storage.write(var_storage_newval);
            actual.write(var_storage_newval[0]);

            expected.write(var_storage[2] ^ ~var_storage[19]);
        }
    }
}


void test_ringbuf::print_error()
{
    cout << "\n** NOTICE  ** at " << sc_time_stamp() << ": Data value not expected.\n";
}


void test_ringbuf::print_restore()
{
    if (sc_time_stamp().to_default_time_units() > 600)
        cout << "\n** RESTORED ** at " << sc_time_stamp() << ": Data returned to expected value.\n";
}


void test_ringbuf::clock_assign()
{
    sc_logic clock_tmp(clock.signal().read());
    iclock.write(clock_tmp);
}