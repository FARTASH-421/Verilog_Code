
`timescale 1ns / 1ps
module Tb_Trans_Level;

    // Inputs
    	reg A, B, C, D;
 	wire F;

    // Instantiate the Unit Under Test (UUT)
    Trans_Level tr (.A(A),.B(B),.C(C),.D(D),.F(F));
    
  
  initial begin
     
    $monitor ("T=%0t A=%0b B=%0b C=%0b D=%0b F=%0b", $time, A, B, C, D,F);
    
   	#100; A = 0;B = 0; C = 0; D = 0;
	#100; A = 0;B = 0; C = 0; D = 1;
	#100; A = 0;B = 0; C = 1; D = 0;
	#100; A = 0;B = 0; C = 1; D = 1;
	#100; A = 0;B = 1; C = 0; D = 0;
	#100; A = 0;B = 1; C = 0; D = 1;
	#100; A = 0;B = 1; C = 1; D = 0;
	#100; A = 0;B = 1; C = 1; D = 1;
	#100; A = 1;B = 0; C = 0; D = 0;
	#100; A = 1;B = 0; C = 0; D = 1;
	#100; A = 1;B = 0; C = 1; D = 0;
	#100; A = 1;B = 0; C = 1; D = 1;
	#100; A = 1;B = 1; C = 0; D = 0;
	#100; A = 1;B = 1; C = 0; D = 1;
	#100; A = 1;B = 1; C = 1; D = 0;
	#100; A = 1;B = 1; C = 1; D = 1;
    
  end
      
endmodule
