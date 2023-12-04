
`timescale 1ns / 1ps
module Tb_ALU;

    // Inputs
    reg [5:0] A;
    reg [5:0] B;
    reg [1:0] Op;

    // Outputs
    wire [5:0] R;

    // Instantiate the Unit Under Test (UUT)
    ALU6bit uut (A,B,Op, R);
    
    initial begin
        // Apply inputs.
        A = 6'd4; B = 6'd3; Op = 0; #100;
	A = 6'd4; B = 6'd3; Op = 1; #100;
	A = 6'd4; B = 6'd3; Op = 2; #100;
	A = 6'd4; B = 6'd3; Op = 3; #100;

	A = 6'd14; B = 6'd5; Op = 0; #100;
	A = 6'd14; B = 6'd5; Op = 1; #100;
	A = 6'd14; B = 6'd5; Op = 2; #100;
	A = 6'd14; B = 6'd5; Op = 3; #100;

	A = 6'd2; B = 6'd10; Op = 0; #100;
	A = 6'd2; B = 6'd10; Op = 1; #100;
	A = 6'd2; B = 6'd10; Op = 2; #100;
	A = 6'd2; B = 6'd10; Op = 3; #100;
       
    end
      
endmodule