`include "defines.v"

module MyMemory (clk, rst, writeEn, readEn, address, dataIn, dataOut);
  input clk, rst, readEn, writeEn;
  input [`WORD_LEN-1:0] address, dataIn;
  output [`WORD_LEN-1:0] dataOut;

  
  reg [`MEM_CELL_SIZE-1:0] RAM [0:`DATA_MEM_SIZE-1];
  integer i;
  always@(negedge clk) begin
    if (rst) begin
      for (i = 0; i < `DATA_MEM_SIZE; i = i + 1) begin
          RAM[i] <= 0;
      end
    end
    else if (writeEn)begin
      {RAM[address], RAM[address + 1], RAM[address + 2], RAM[address + 3]} <= dataIn;
    end
  end

  assign dataOut = readEn ?  {RAM[address], RAM[address + 1], RAM[address + 2], RAM[address + 3]}: 0;

endmodule 
