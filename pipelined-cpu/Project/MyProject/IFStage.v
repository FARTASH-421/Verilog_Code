`include "defines.v"

module IFStage (clk, rst, brTaken, brOffset, freeze, PC, instruction);
  input clk, rst, brTaken, freeze;
  input [`WORD_LEN-1:0] brOffset;
  output reg [`WORD_LEN-1:0] PC;
  output [`WORD_LEN-1:0] instruction;

  wire [`WORD_LEN-1:0] adderIn1, brOffserTimes4;

  mux #(.LENGTH(`WORD_LEN)) adderInput (
    .in1(32'd4),
    .in2(brOffserTimes4),
    .sel(brTaken),
    .out(adderIn1)
  );

  always @ (posedge clk) begin
    if (rst == 1) begin 
        PC <= 0;
    end
    else if (~freeze) begin
       PC <= adderIn1 + PC;
    end
  end


  instructionMem instructions (
    .rst(rst),
    .addr(PC),
    .instruction(instruction)
  );

  assign brOffserTimes4 = brOffset-31;

endmodule 

