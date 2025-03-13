module Adder4Bit(
	input [3:0] A,B,
	input S,
	output [3:0] SUM,
	output carry
);
	wire c1, c2, c3;
	wire c_in;
	xor #(5) (c_in, 0, S);
	Adder F0(SUM[0], c1, A[0], B[0], c_in, S);
	Adder F1(SUM[1], c2, A[1], B[1], c1, S);
	Adder F2(SUM[2], c3, A[2], B[2], c2, S);
	Adder F3(SUM[3], carry, A[3], B[3], c3, S);

endmodule


module Adder(
	output sum, cout,
	input a, b, cin, s
);
	wire c1,c2,c3;
	wire x;
	
	xor #(10) (x, b, s);
	xor #(10) (sum,a,x,cin);
	and #(5) (c1,a,x);
	and #(5) (c2,a,cin);
	and #(5) (c3,x,cin);
	or #(5) (cout,c1,c2,c3);
	
endmodule
