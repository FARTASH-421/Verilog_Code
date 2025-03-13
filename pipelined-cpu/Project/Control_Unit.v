//module CONTROL(opcode,Mux1,Branch, re, wr, alu_op, Mux2, Mux3_reg_wrt, pc_select);
module CONTROL(clk, opcode, Signal, EXE, MEM, WB, pc_select, Flush);
	input clk;
	input [3:0] Signal;
	input [3:0] opcode;

	output reg [5:0]EXE;
	output reg [5:0]MEM;
	output reg [1:0]WB;
	output reg pc_select;
	output reg Flush;


	//EXE[5] = Mux2 Select Line
	//EXE[4] = Mux1 Select Line
	//EXE[3:0] = AluOp

	//MEM[5] = Write
	//MEM[4] = Read
	//MEM[3:0] = Branch

	//WB[1] = Mux3 Select Line
	//WB[0] = RegWrt 

	reg sign;

	initial begin
	sign = 0;
	pc_select = 1;
	Flush = 0;
	end

	always @(*)begin
		case(opcode)
			4'b0001: begin  // Addition	
				EXE = 6'b010001;  MEM = 6'b000000;  WB = 2'b11;  pc_select = 1; Flush = 0;
			end
			4'b0010: begin  // Subtraction
				EXE = 6'b010010;  MEM = 6'b000000;  WB = 2'b11;  pc_select = 1; Flush = 0;
			end
			4'b0011: begin  // Increment
				EXE = 6'b010011;  MEM = 6'b000000;  WB = 2'b11;  pc_select = 1; Flush = 0;
			end
			4'b0100: begin  // Decrement
				EXE = 6'b010100;  MEM = 6'b000000;  WB = 2'b11;  pc_select = 1; Flush = 0;
			end
			4'b0101: begin  // Add Immediate
				EXE = 6'b110101;  MEM = 6'b000000;  WB = 2'b11;  pc_select = 1; Flush = 0;
			end
			4'b0110: begin  // Subtract Immediate
				EXE = 6'b110110;  MEM = 6'b000000;  WB = 2'b11;  pc_select = 1; Flush = 0;
			end
			4'b1001: begin  // BEQ
				EXE = 6'b0;  MEM = 6'b0;  WB = 2'b0; Flush = Signal[0];
			end
			4'b1010: begin  // BLT
				EXE = 6'b0;  MEM = 6'b0;  WB = 2'b0; Flush = Signal[2];
			end
			4'b1011: begin  // BGT
				EXE = 6'b0;  MEM = 6'b0;  WB = 2'b0; Flush = Signal[1];
			end
			4'b1101: begin  // BNE
				EXE = 6'b0;  MEM = 6'b0;  WB = 2'b0; Flush = Signal[3];
			end
			4'b1110: begin  // LW
				EXE = 6'b10_0001;  MEM = 6'b10_0000;  WB = 2'b01; Flush = 0;
			end
			4'b1111: begin  // SW
				EXE = 6'b1x_0001;  MEM = 6'b01_0000;  WB = 2'b00; Flush = 0;
			end
			default: begin
				EXE = 6'b0;
				MEM = 6'b0;
				WB = 2'b0;
				Flush = 0;
			end
		endcase
	end
endmodule
