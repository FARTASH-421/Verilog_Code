module top;

export "DPI-C" task verilog_task;

task verilog_task();
  $display("[%t] hello from verilog_task.", $time);
  #200;
  $display("[%t] exiting verilog_task.", $time);
endtask

initial
begin
   $display("starting initial block");
  #200000 $finish;
end
endmodule