module Forward(MEM_regwrt, WB_regwrt, MEM_dest, WB_dest, A_reg, B_reg, ForA, ForB);

input MEM_regwrt;
input WB_regwrt;
input [3:0]MEM_dest;
input [3:0]WB_dest;
input [3:0]A_reg;
input [3:0]B_reg;

output reg[1:0]ForA;
output reg[1:0]ForB;

always @(*)begin
	if(MEM_regwrt==1 && (MEM_dest==A_reg))
		ForA = 1;
	else if(MEM_regwrt==1 && MEM_dest==B_reg)
		ForB = 1;
	else if(WB_regwrt==1 && WB_dest==A_reg && (MEM_dest != A_reg || MEM_regwrt == 0))
		ForA = 2;
	else if(WB_regwrt==1 && WB_dest==B_reg && (MEM_dest != B_reg || MEM_regwrt == 0))
		ForB = 2;
	else begin
		ForA = 0;
		ForB = 0;
	end
end
endmodule
