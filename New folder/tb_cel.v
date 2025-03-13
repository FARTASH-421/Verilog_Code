`timescale 1ns / 1ps



module tb_cel;

	// Inputs
	reg [30:0] ctr;
	reg [1:0] cbi;
	reg [5:0] sbi;

	// Outputs
	wire [1:0] cbo;
	wire [5:0] sbo;

	// Instantiate the Unit Under Test (UUT)
	cel uut (
		.ctr(ctr), 
		.cbi(cbi), 
		.sbi(sbi), 
		.cbo(cbo), 
		.sbo(sbo)
	);

	initial begin
		// Initialize Inputs
		ctr = 0;
		cbi = 0;
		sbi = 0;

		// Wait 100 ns for global reset to finish
		#100;
      		ctr = 999;
		cbi = 3;
		sbi = 1;
		#100
		ctr = 0;
		cbi = 0;
		sbi = 0;
		// Add stimulus here

	end
      
endmodule

