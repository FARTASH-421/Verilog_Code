`timescale 1ns/1ps

module Tb_ALU;

reg [15: 0] A, B;
wire [15: 0] cout;
reg [3:0] opCode;
wire flag;

ALU alu (A, B,opCode, cout, flag );

initial begin
    #10  A = 10; B= 20; opCode = 4'b0000;
    #10  A = 10; B= -20; opCode = 4'b0000;
    #10  A = -10; B= 20; opCode = 4'b0000;
    #10  A = -110; B= -20; opCode = 4'b0000;

    #10  A = 100; B= 20; opCode = 4'b0001;
    #10  A = 10; B= -20; opCode = 4'b0001;
    #10  A = -10; B= 20; opCode = 4'b0001;
    #10  A = -10; B= -20; opCode = 4'b0001;

    #10  A = 100; B= 20; opCode = 4'b0010;

    #10  A = 10; B= -20; opCode = 4'b0011;

    #10  A = 10; B= -20; opCode = 4'b0100;
    #10  A = 10; B= -20; opCode = 4'b0101;

    #10  A = 10; B= 20; opCode = 4'b0110;
    #10  A = 10; B= 10; opCode = 4'b0110;


    #10  A = 10; B= 10; opCode = 4'b0111;
    #10  A = 10; B= 140; opCode = 4'b0111;

    #10  A = 10; B= 10; opCode = 4'b1000;
    #10  A = -10; B= 10; opCode = 4'b1000;

    
    #10  A = 10; B= 10; opCode = 4'b1001;
    #10  A = -10; B= 10; opCode = 4'b1001;

    
    #10  A = 64; B= 10; opCode = 4'b1100;
    #10  A = 64; B= 10; opCode = 4'b1101;

    
    #10  A = 10; B= 10; opCode = 4'b1110;








 end





endmodule