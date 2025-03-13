module MUX8(a,b,sel,e);
	input [7:0] a;
	input [7:0] b;
	input sel;
	output reg [7:0]e;
	always @(*)begin
	if(sel)
		e = b;
	else
		e = a;
	end
endmodule
