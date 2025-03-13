`include "opcodes.v"

module ALUControl(opCode, funcCode, ALUOp);
	input [3:0] opCode;
	input [5:0] funcCode;
	output reg [3:0] ALUOp;


	always @(opCode or funcCode) begin
		case(opCode)
			// Signed addition
			`ADI_OP, `LWD_OP, `SWD_OP : begin
				ALUOp = 4'b0000;
			end
			// Bitwise OR
			`ORI_OP : begin
				ALUOp = 4'b0101;
			end
			// Select B
			`LHI_OP : begin
				ALUOp = 4'b1010;
			end
			// A != B
			`BNE_OP : begin
				ALUOp = 4'b0110;
			end
			// A == B
			`BEQ_OP : begin
				ALUOp = 4'b0111;
			end
			// A > 0
			`BGZ_OP : begin
				ALUOp = 4'b1000;
			end
			// A < 0
			`BLZ_OP : begin
				ALUOp = 4'b1001;
			end
			// ALU Operations
			`ALU_OP : begin
				case(funcCode)
					`INST_FUNC_ADD : begin
						ALUOp = 4'b0000;
					end
					`INST_FUNC_SUB : begin
						ALUOp = 4'b0001;
					end
					`INST_FUNC_AND : begin
						ALUOp = 4'b0100;
					end
					`INST_FUNC_NOT : begin
						ALUOp = 4'b0011;
					end
					`INST_FUNC_ORR : begin
						ALUOp = 4'b0101;
					end
					`INST_FUNC_TCP : begin
						ALUOp = 4'b1110;
					end
					`INST_FUNC_SHL : begin
						ALUOp = 4'b1100;
					end
					`INST_FUNC_SHR : begin
						ALUOp = 4'b1101;
					end
				endcase
			end
			// Default case - Select A
			default : begin
				ALUOp = 4'b0010;
			end
		endcase
	end
endmodule