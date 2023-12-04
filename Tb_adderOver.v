`timescale 1ns / 1ns

module Tb_SAdder;


	reg [7:0] A,B;
	reg C_in;
	wire [7:0] SUM;
	wire Out;
	wire Overflow;
	
	Siged_Adder8bit ad(A,B,C_in,SUM,Out,Overflow);

	initial begin
		//Positive Numbers
		C_in =0; A = 64; B = 50; #100;

		// Overflow for Posivtec number
		C_in = 0; A = 120; B = 10; #100; 

		// Negative Numbers
		C_in = 0; A = -30; B = -70; #100; 
		

		//Overflow for Negative Numbers
		C_in = 0; A = -100; B = -30; #100;	
		
	end

endmodule