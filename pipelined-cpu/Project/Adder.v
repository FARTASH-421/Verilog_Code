module ADDER(A,B,out);
	input [7:0] A,B;
	output reg [7:0] out;
	reg [7:0] temp;
	initial begin
		out <= 0;
	end
	always @(*)begin
		temp = B<<1;
		out = A + temp - 2;
	end
endmodule
