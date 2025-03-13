`timescale 1ns / 1ps
module register(
    input in,
    input clk,
    input en,
    input clr,
    output reg out
  );

  always @(posedge clk ,posedge clr)
  begin
    if(clr)
    begin
      out <= 0;
    end
    else if (en)
    begin
      out <= in ;
    end
  end

endmodule
