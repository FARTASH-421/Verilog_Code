#include "systemc.h"
#include "dpiheader.h"

SC_MODULE(hello)
{
    void call_verilog_task();
    SC_CTOR(hello)
    {
        SC_THREAD(call_verilog_task);
    }
    ~hello() {};
};


void hello::call_verilog_task()
{
    svSetScope(svGetScopeFromName("top"));
    for(int i = 0; i < 3; ++i)
    {
        verilog_task();
    }
}
SC_MODULE_EXPORT(hello);
