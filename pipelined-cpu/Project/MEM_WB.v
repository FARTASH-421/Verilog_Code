module MEM_WB(clk, read, write, Branch, alu_result, Data_for_RAM, zero, carry, mem_data, Branch_O);

input clk;
input zero, carry;
input [3:0] Branch;
input read, write;
input [7:0] alu_result, Data_for_RAM;

output [7:0]mem_data;
output [3:0] Branch_O;

//module Memory_Unit(clk,address,data_in,data_out,re,wr);
Memory_Unit Memory (clk, alu_result, Data_for_RAM, mem_data, read, write);

wire p, q, r, s;
and a(p, Branch[3], zero);
and b(q, Branch[2], ~zero);
and c(r, Branch[1], carry);
and d(s, Branch[0], ~carry);

assign Branch_O = {p, q, r, s};

endmodule
