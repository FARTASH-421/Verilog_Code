module IF2ID(clk, next_PC_address, opcode, A_Reg, B_Reg, W_Reg, Sign, freeze, flush, 
 				next_PC_address_O, opcode_O, A_Reg_O, B_Reg_O, W_Reg_O, Sign_O
 );

	input clk;
	input [7:0] next_PC_address;
	input [3:0] opcode;
	input [3:0] A_Reg;
	input [3:0] B_Reg;
	input [3:0] W_Reg;
	input [3:0] Sign;
	input freeze, flush;

	output reg  [7:0] next_PC_address_O;
	output reg  [3:0] opcode_O;
	output reg  [3:0] A_Reg_O;
	output reg  [3:0] B_Reg_O;
	output reg  [3:0] W_Reg_O;
	output reg  [3:0] Sign_O;

	always @(negedge clk)begin
		if(~freeze)begin
			if(flush)begin
				next_PC_address_O <= 7'bx;
				opcode_O <= 3'bx;
				A_Reg_O <= 3'bx;
				B_Reg_O <= 3'bx;
				W_Reg_O <= 3'bx;
				Sign_O <= 3'bx;
			end
			else begin
				next_PC_address_O <= next_PC_address;
				opcode_O <= opcode;
				A_Reg_O <= A_Reg;
				B_Reg_O <= B_Reg;
				W_Reg_O <= W_Reg;
				Sign_O <= Sign;
			end
		end
	end

endmodule
