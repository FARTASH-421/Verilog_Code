// `timescale 1ns / 1ps

module My_ALU(
    input [7:0] A, B,
    input [2:0] opCode,
    output myCarry, Sign, Over,
    output reg [7:0] myOut
);

wire [7:0] out_1, out_2;

Adder4Bit sum (A, B, 1'b0, myCarry, out_1);
Adder4Bit sub (A, B, 1'b1, myCarry, out_2);

wire w1, w2;

always @(*) begin
    case (opCode)
    3'b000  :  myOut = out_1;
    3'b001  :  myOut = out_2;
    3'b010  :  myOut = (A & B);
    3'b011  :  myOut = (A | B);
    3'b100  :  myOut = (~A & B ) | (A & ~B);
    3'b101  :  myOut = ~A;
    3'b110  :  myOut = A << 1;
    3'b111  :  myOut = A[7]? (~A+1 ): A;
     
    endcase    
    
   
 end
assign Sign = myOut[7];
assign w1 = (A[7] & (B[7]^1) & ~out_2[7]) | (~A[7] & ~(B[7]^1) & out_2[7]);
assign w2 = (A[7] & (B[7]) & ~out_1[7]) | (~A[7] & ~(B[7]) & out_1[7]);

assign Over = opCode[0]? w1 : w2;
  
    

endmodule


module Adder4Bit(
	input [7:0] A,B,
	input S,
    output carry,
	output [7:0] SUM
	
);
	wire c1, c2, c3, c4, c5, c6 ,c7;
	wire c_in;
    wire b;
	xor(c_in, 0, S);
    

	Adder F0(SUM[0],c1,A[0],B[0],c_in, S);
	Adder F1(SUM[1],c2,A[1],B[1],c1, S);
	Adder F2(SUM[2],c3,A[2],B[2],c2, S);
    Adder F3(SUM[3],c4,A[3],B[3],c3, S);
    Adder F4(SUM[4],c5,A[4],B[4],c4, S);
    Adder F5(SUM[5],c6,A[5],B[5],c5, S);
    Adder F6(SUM[6],c7,A[6],B[6],c6, S);
	Adder F7(SUM[7],carry, A[7],B[7],c7, S);

    // assign b =  (S & ~B[7]) | (~S & B[7]);
    // assign b = B[7] ^ S;
    

endmodule


module Adder(
	output sum, cout,
	input a, b, cin, s
);
	wire c1,c2,c3;
	wire x;
	
	xor (x, b, s);
	xor (sum,a,x,cin);
	and (c1,a,x);
	and (c2,a,cin);
	and (c3,x,cin);
	or (cout,c1,c2,c3);
	
endmodule




