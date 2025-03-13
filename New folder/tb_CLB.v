`timescale 1ns / 1ps


module tb_clb;

	// Inputs
	reg [4:0] data_in;
	reg [1:0] sel;
	reg clk;

	// Outputs
	wire data_out;

	// Instantiate the Unit Under Test (UUT)
	clb uut (
		.data_in(data_in), 
		.sel(sel), 
		.clk(clk), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		data_in = 0;
		sel = 0;
		clk = 0;

		#100;
       		data_in = 0;
		sel = 1;
		clk = 1;

		#100;
		data_in = 6;
		sel = 2;
		clk = 0;

		#100;
		clk = 1;

		#100;
	end
      
endmodule

