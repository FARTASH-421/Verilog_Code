//****************************************************
//	TEST BENCH MODULE
//  PROJECT DIGITA LOGIC CIRCUITS 
//	NAME: ABDUL QADIR FARTASH
//	ID STUDEN : 99243100
//	PRAT : 2	  
//****************************************************


module Siged_Adder8bit(
	input [7:0] A, B,
	input C_IN,
	output [7:0] SUM,
	output CAARY,
	output OVERFLOW

);
	wire c1, o1, o2, o3;
	
	Adder4bit F0(A[3:0],B[3:0],C_IN,SUM[3:0],c1);
	Adder4bit F1(A[7:4],B[7:4],c1,SUM[7:4],CAARY);


	and(o1,~SUM[7],A[7],B[7]);
	and(o2,SUM[7],~A[7],~B[7]);
	or(OVERFLOW, o1, o2);

endmodule


module Adder4bit(
	input [3:0] A,B,
	input C_IN,
	output [3:0] SUM,
	output carry
);
	wire c1, c2, c3;
	Adder F0(SUM[0],c1,A[0],B[0],C_IN);
	Adder F1(SUM[1],c2,A[1],B[1],c1);
	Adder F2(SUM[2],c3,A[2],B[2],c2);
	Adder F3(SUM[3],carry,A[3],B[3],c3);

endmodule


module Adder(
	output sum, cout,
	input a, b, cin
);
	wire c1,c2,c3;
	
	xor(sum,a,b,cin);
	and(c1,a,b);
	and(c2,a,cin);
	and(c3,b,cin);
	or(cout,c1,c2,c3);
	
endmodule