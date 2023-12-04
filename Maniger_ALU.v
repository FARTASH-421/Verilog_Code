module MaingerALU(
input [5:0] r1,
input [3:0] r6,
input [1:0] r2, r3, r4, r5,
output carry, over,
output [31:0] out

);
	wire [5:0] my_ram1;
	wire [31:0] my_ram2, my_ram3, my_ram4, my_ram5, my_ram6;

	RAM1 R1(r1, my_ram1);

	RAM2 R2(r2, my_ram2);
	RAM3 R3(r3, my_ram3);
	RAM4 R4(r4, my_ram4);
	RAM4 R5(r5, my_ram5);
	
	
	wire [31:0] mux_1, mux_2;
	MUX_1 x1(my_ram2, my_ram3, my_ram1[4], mux_1);
	MUX_1 x2(my_ram4, my_ram5, my_ram1[5], mux_2);
	
	wire [31:0] alu;
	reg[31:0] res;

	ALU al(mux_1, mux_2, my_ram1[3:0], carry, over ,alu);
	RAM6 R6 (r6, my_ram6);

	always @(*)begin
     	if (alu < 32'h1000_0000) begin
			if (alu < 999) begin
				res = my_ram6 + alu;
			end
			else begin
		 		// res = my_ram6[31:12]+alu[31:12];
				res = my_ram6 +1000000;
				
			end
			
		end
		else begin
		 res = 32'hzzzzzzzz;
		end
    end
assign out = res;
	

	

endmodule
