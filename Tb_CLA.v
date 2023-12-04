//*****************************************
//	PROJECT DIGITA LOGIC CIRCUITS 
//	NAME: ABDUL QADIR FARTASH
//	ID STUDEN : 99243100
//	PRAT : TestBench 4	
//*****************************************
	
module Tb_CLA;

	reg[31:0] x,y;
	reg cin;
	wire[31:0] sum;
	wire cout;
	
	CLAdder_32bit tes (x,y,cin,sum,cout);
	initial begin
		
		cin =0; x = 1; y = 2; #100;
		cin =1; x = 1; y = 2; #100;

		cin = 0; x = 2; y = 3; #100; 
		cin = 1; x = 2; y = 3; #100;

		cin = 0; x = 5; y = 16; #100; 
		cin = 1; x = 5; y = 16; #100;
		
		cin = 0; x = 12; y = 18; #100;
		cin = 1; x = 12; y = 18; #100; 
		
		
	end
	
	
endmodule
