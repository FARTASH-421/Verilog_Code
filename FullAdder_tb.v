`include "FullAdder.v"
module Adder_tb();

reg [3:0] A, B;
reg C_in, S;
wire carry;
wire [3:0] Out;
	
    Adder4Bit F (A, B, S, Out, carry);
    initial begin
        S = 0;
        A = 4'b0101; B = 4'b0010;
	#100;
	S = 1;
        A = 4'b0101; B = 4'b0011;
	#100;
	S = 0;
        A = 4'b0011; B = 4'b0010;
	#100;
	S = 1;
        A = 4'b1001; B = 4'b0010;
	#100;
	S = 1;
        A = 4'b1011; B = 4'b0010;
	#100;
	S = 0;
        A = 4'b1101; B = 4'b0110;
    end




endmodule