`timescale 1ns / 1ps

module Tb_ALU;

reg [7:0] A, B ;

reg [2:0] opCode;

wire carry, over, sign;
wire[7:0]  myOut;


    My_ALU f (A, B, opCode, carry, sign, over, myOut);
    initial begin
       
        A = 8'b0010_1000; B = 8'b0010_0011; opCode = 3'b000; #100;
        A = 8'b0010_1010; B = 8'b0110_0111; opCode = 3'b001; #100;
        A = 8'b0100_1010; B = 8'b0101_0111; opCode = 3'b000; #100;
        A = 8'b1000_0000; B = 8'b0000_0111; opCode = 3'b001; #100;

        A = 8'b1100_1010; B = 8'b0110_0111; opCode = 3'b000; #100;
        A = 8'b1011_0000; B = 8'b1100_1111; opCode = 3'b001; #100;

         A = 8'b00000000; B = 8'b0000_0000; opCode = 3'b000; #100;
        // test for AND
         A = 8'b0111_0000; B = 8'b0001_1011; opCode = 3'b010; #100;
        // test for OR
         A = 8'b0000_0110; B = 8'b0000_1001; opCode = 3'b011; #100;
        //  test for XOR
         A = 8'b0111_0000; B = 8'b0000_1111; opCode = 3'b100; #100;
        //  test for NOT INPUT first
         A = 8'b0111_0000; opCode = 3'b101; #100;

        //  test for shift A
         A = 8'b0011_0000; opCode = 3'b110; #100;

        A = 8'b1000_0001; opCode = 3'b111; #100;
        A = 8'b1000_0000; opCode = 3'b111; #100;


    end


endmodule
