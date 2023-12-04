#include "producer.h"

void producer::generator()
{
  wait(rst.negedge_event());
  wait(clk.posedge_event());
  data.write(0xdeadbeef);

  wait(clk.posedge_event());
  wait(clk.posedge_event());
  data.write(0xbadc0de);
}
