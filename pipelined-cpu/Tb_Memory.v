`timescale 1ns/1ps
`include "defines.v"


module Tb_Memory;

reg readM, writeM, clk, reset;
reg [`WORD_LEN-1:0] address, data;

wire [`WORD_LEN-1:0] outdata;

MyMemory mm (clk, reset, writeM, readM, address, data, outdata);

initial begin
 clk = 0;
 reset = 1;
end

always #10 clk = ~clk;

initial begin
    #20 reset = 0;
    #30; address = 4; data = 120; writeM = 1; readM = 0;
    #30; address = 5; data = 46; writeM = 1; readM = 0;
    #30; address = 12; data = 55; writeM = 1; readM = 0;
    #30; address = 14; data = 98; writeM = 1; readM = 0;
    #30; address = 40; data = 190; writeM = 1; readM = 0;
    #30; address = 84; data = 547; writeM = 1; readM = 0;

    #10; address = 4; data = 0; writeM = 0; readM = 1;
    #10; address = 5; data = 0; writeM = 0; readM = 1;
    #10; address = 12; data = 0; writeM = 0; readM = 1;
    #10; address = 14; data = 0; writeM = 0; readM = 1;
    #10; address = 40; data = 0; writeM = 0; readM = 1;
    #10; address = 84; data = 0; writeM = 0; readM = 1;

    #30; address = 39; data = 23; writeM = 1; readM = 0;
    #30; address = 57; data = 547; writeM = 1; readM = 0;

    #10; address = 5; data = 10; writeM = 0; readM = 1;
    #10; address = 94; data = 10; writeM = 0; readM = 1;
    #10 readM = 0;

end




endmodule
