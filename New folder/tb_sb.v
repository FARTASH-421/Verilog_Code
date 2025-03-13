`timescale 1ns / 1ps


module tb_sb;

	// Inputs
	reg [7:0] in;
	reg [15:0] sel;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	SB uut (
		.in(in), 
		.sel(sel), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
       		in = 12;
		sel = 1;
		#100;
        	in = 100;
		sel = 4;
		// Add stimulus here

	end
      
endmodule

