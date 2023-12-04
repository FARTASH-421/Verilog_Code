
`timescale 1ns / 1ps


// input [2:0] r1,
// [3:0] r6,
// input [1:0] r2, r3, r4, r5,
// output carry,
// output reg [31:0] out


module Tb_ALU32;

reg [5:0] r1;
reg [3:0] r6;
reg [1:0] r2, r3, r4, r5;
wire carry, over;
wire [31:0] out;

    MaingerALU m_alu (r1, r6, r2, r3, r4, r5, carry,over, out);
    initial begin
        r1 = 6'b000000; r2 = 2'b00; r3 = 2'b00; r4 = 2'b00; r5 = 2'b10; r6 = 4'b0001; #100;
        r1 = 6'b000001; r2 = 2'b00; r3 = 2'b10; r4 = 2'b10; r5 = 2'b00; r6 = 4'b0001; #100;
        r1 = 6'b000010; r2 = 2'b10; r3 = 2'b00; r4 = 2'b00; r5 = 2'b00; r6 = 4'b0001; #100;
        r1 = 6'b000011; r2 = 2'b00; r3 = 2'b00; r4 = 2'b00; r5 = 2'b00; r6 = 4'b0001; #100;

        r1 = 5'b0001_00; r2 = 2'b00; r3 = 2'b00; r4 = 2'b00; r5 = 2'b00; r6 = 4'b0001; #100;          r1 = 6'b0011_00; r2 = 2'b00; r3 = 2'b00; r4 = 2'b00; r5 = 2'b00; r6 = 4'b0001; #100;
        r1 = 6'b0100_01; r2 = 2'b00; r3 = 2'b00; r4 = 2'b00; r5 = 2'b00; r6 = 4'b0001; #100;
        r1 = 6'b0101_01; r2 = 2'b00; r3 = 2'b00; r4 = 2'b00; r5 = 2'b00; r6 = 4'b0001; #100;
        r1 = 6'b0111_01; r2 = 2'b00; r3 = 2'b00; r4 = 2'b00; r5 = 2'b00; r6 = 4'b0001; #100;

    end

endmodule