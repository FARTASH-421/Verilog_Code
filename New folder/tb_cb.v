`timescale 1ns / 1ps

module tb_cb;

	// Inputs
	reg [1:0] ri;
	reg [1:0] li;
	reg [9:0] sel;
	reg q;
	
	wire [1:0] clb;
	wire [1:0] ro;
	wire [1:0] lo;


	// Instantiate the Unit Under Test (UUT)
	cb uut (
		.ri(ri), 
		.li(li),
		.sel(sel),
		.q(q),
		.ro(ro),
		.lo(lo),
		.clb(clb)
	);

	initial begin
		// Initialize Inputs
		ri = 0;
		li = 0;
		sel = 0;
		q = 0;

		// Wait 100 ns for global reset to finish
		#100;
		ri = 1;
		li = 1;
		sel = 1;
		q = 1;
		#100;
		ri = 12;
		li = 13;
		sel = 2;
		q = 0;

        
		// Add stimulus here

	end
      
endmodule

