`timescale 1ns / 1ps



module tb_fcel;

	// Inputs
	reg [123:0] ctrs;
	reg [3:0] cbis;
	reg [11:0] sbis;

	// Outputs
	wire [3:0] cbos;
	wire [11:0] sbos;

	// Instantiate the Unit Under Test (UUT)
	fcel uut (
		.ctrs(ctrs), 
		.cbis(cbis), 
		.sbis(sbis), 
		.cbos(cbos), 
		.sbos(sbos)
	);

	initial begin
		// Initialize Inputs
		ctrs = 0;
		cbis = 0;
		sbis = 0;

		// Wait 100 ns for global reset to finish
		#100;
      		ctrs = 999;
		cbis = 3;
		sbis = 1;
		#100
		ctrs = 0;
		cbis = 0;
		sbis = 0;
		// Add stimulus here

	end
      
endmodule

