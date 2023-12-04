//*****************************************
//	PROJECT DIGITA LOGIC CIRCUITS 
//	NAME: ABDUL QADIR FARTASH
//	ID STUDEN : 99243100
//	PRAT : 4	
//*****************************************

module CLAdder_32bit(
  input [31:0] A,
  input [31:0] B,
  input CIN,
  output [31:0] SUM,
  output CARRY_OUT
);

  wire a1, a2, a3;
  
  
   CLAdder_8bit b1 (A[7:0], B[7:0], CIN, SUM[7:0], a1 );
   CLAdder_8bit b2 (A[15:8], B[15:8], a1, SUM[15:8], a2 );
   CLAdder_8bit b3 (A[23:16], B[23:16], a2, SUM[23:16], a3 );
   CLAdder_8bit b4 (A[31:24], B[31:24], a3, SUM[31:24],CARRY_OUT );
     
endmodule

module CLAdder_8bit(
  input [7:0] A,
  input [7:0] B,
  input CIN,
  output [7:0] SUM,
  output CARRY_OUT
);

   wire f1, f2, f3;
  
   fullAdder q1 (A[1:0], B[1:0], CIN, SUM[1:0], f1);
   fullAdder q2 (A[3:2], B[3:2], f1, SUM[3:2], f2);
   fullAdder q3 (A[5:4], B[5:4], f2, SUM[5:4], f3);
   fullAdder q4 (A[7:6], B[7:6], f3, SUM[7:6],CARRY_OUT);
     
endmodule

module fullAdder(
	input [1:0] A, B,
	input CIN,
	output reg[1:0] sum,
	output reg CARRY_OUT
);
	
	reg x1,x2,x3, x4, x5, x6, x7, x8;
	
	
	always@(*)
	begin
		x1 = A[0] ^ B[0];
		x2 = A[0] & B[0];
		sum[0] = x1 ^ CIN;
		x3 = x1 & CIN;
		x4 = x2 | x3;
		x5 = A[1] ^ B[1];
		x6 = A[1] & B[1];
		sum[1] = x5 ^ x4;
		x7 = CIN & x1 & x5;
		x8 = x5 & x2;
		CARRY_OUT = x6 | x7 | x8;
	end
endmodule
			
