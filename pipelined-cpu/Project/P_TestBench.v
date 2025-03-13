`timescale 1ns / 1ps;

module Test3;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] current_PC_address;
	wire [3:0] opcode;
	wire [3:0] A_Reg_IF2ID;
	wire [3:0] B_Reg_IF2ID;
	wire [3:0] Sign_IF2ID;
    wire [3:0] W_Reg_IF2ID;
	wire [7:0] readA_O;
	wire [7:0] readB_O;
	wire [7:0] alu_result_O;
	wire [3:0] W_address_WB;
	wire [7:0] W_data_WB;

	// Instantiate the Unit Under Test (UUT)
	DataPath_2 uut (
		.clk(clk), 
		.reset(reset), 
		.current_PC_address(current_PC_address), 
		.readA_O(readA_O), 
		.readB_O(readB_O), 
		.A_Reg_IF2ID(A_Reg_IF2ID), 
		.B_Reg_IF2ID(B_Reg_IF2ID), 
		.Sign_IF2ID(Sign_IF2ID), 
		.opcode(opcode), 
		.W_Reg_IF2ID(W_Reg_IF2ID), 
		.W_address_WB(W_address_WB), 
		.alu_result_O(alu_result_O), 
		.W_data_WB(W_data_WB)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#5;
      reset = 0;
		// Add stimulus here

	end
always #1 clk = ~clk; 
endmodule
