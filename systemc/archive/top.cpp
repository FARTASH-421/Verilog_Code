#include "systemc.h"
#include "top.h"

SC_MODULE_EXPORT(top);

void top::main_loop()
{
  rst.write(true);
  wait(10, SC_NS);

  rst.write(false);
  wait(40, SC_NS);

  sc_stop();
}