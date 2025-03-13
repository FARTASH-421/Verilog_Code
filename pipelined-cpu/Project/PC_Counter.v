module PC(in,clk,pc_select,reset,out);
	input [7:0]in;
	input pc_select, clk,reset;
	output reg[7:0]out;

	always @(negedge clk)begin
		if(reset)
			out <= 0;
		else if(pc_select)begin
			out <= in;
		end
	end
endmodule
