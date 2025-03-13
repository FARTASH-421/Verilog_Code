`timescale 1ns / 100ps
`define	NumBits	16

module ALU (A, B, FuncCode, C, Flag);
	input [`NumBits-1:0] A;
	input [`NumBits-1:0] B;
	input [3:0] FuncCode;
	output reg [`NumBits-1:0] C;
	output reg Flag;


	initial begin
		C = 0;
		Flag = 0;
	end   	

	always @(A or B or FuncCode) begin
		case(FuncCode)
			4'b0000 : begin
				// 0. Signed addition
				C = A + B;
				Flag = 0;
			end
			4'b0001 : begin
				// 1. Signed subtraction
				C = A - B;
				Flag = 0;
			end
			4'b0010 : begin
				// 2. Identity A
				C = A;
				Flag = 0;
			end
			4'b0011 : begin
				// 3. Bitwise NOT
				C = ~A;
				Flag = 0;
			end
			4'b0100 : begin
				// 4. Bitwise AND
				C = A & B;
				Flag = 0;
			end
			4'b0101 : begin
				// 5. Bitwise OR
				C = A | B;
				Flag = 0;
			end
			4'b0110 : begin
				// 6. A != B check
				C = A;
				Flag = (A != B);
			end
			4'b0111 : begin
				// 7. A == B check
				C = A;
				Flag = (A == B);
			end
			4'b1000 : begin
				// 8. A > 0 check
				C = A;
				Flag = (A[15] == 0 && A != 0 ? 1 : 0);
			end
			4'b1001 : begin
				// 9. A < 0 check
				C = A;
				Flag = (A[15] == 1 ? 1 : 0);
			end
			4'b1010 : begin
				// 10. Identity B
				C = B;
				Flag = 0;
			end
			4'b1011 : begin
				// 11. Empty
				C = A;
				Flag = 0;
			end
			4'b1100 : begin
				// 12. Arithmetic left shift
				C = A<< 1;
				Flag = 0;
			end
			4'b1101 : begin
				// 13. Arithmetic right shift
				C = A >> 1;
				Flag = 0;
			end
			4'b1110 : begin
				// 14. Two's complement
				C =  ~A + 1;
				Flag = 0;
			end
			default : begin
				// 15. Zero
				C = 0;
				Flag = 0;
			end
		endcase
	end

endmodule