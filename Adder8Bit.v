// module CLH_Adder8(
//     input[7:0] A, B,
//     input S,
//     output[7:0] SUM,
//     output carry, 
//     output over
// );
    
//     wire w1, c_in;
//     xor(c_in, 0, S);
//     Adder4Bit a1(A[3:0], B[3:0], c_in, S, SUM[3:0], w1);
//     Adder4Bit a2(A[7:4], B[7:4], w1, S, SUM[7:4], carry);

//     assign over = ( A[7] & B[7] & ~SUM[7]) | ( ~A[7] & ~B[7] & SUM[7]);

// endmodule


// module Adder4Bit(
// 	input [3:0] A,B,
// 	input cin, S,
// 	output [3:0] SUM,
// 	output carry
// );
// 	wire c1, c2, c3;
// 	wire c_in;
	
// 	Adder F0(SUM[0],c1,A[0],B[0],cin, S);
// 	Adder F1(SUM[1],c2,A[1],B[1],c1, S);
// 	Adder F2(SUM[2],c3,A[2],B[2],c2, S);
// 	Adder F3(SUM[3],carry,A[3],B[3],c3, S);

// endmodule


// module Adder(
// 	output sum, cout,
// 	input a, b, cin, s
// );
// 	wire c1,c2,c3;
// 	wire x;
	
// 	xor (x, b, s);
// 	xor (sum,a,x,cin);
// 	and (c1,a,x);
// 	and (c2,a,cin);
// 	and (c3,x,cin);
// 	or (cout,c1,c2,c3);
	
// endmodule
