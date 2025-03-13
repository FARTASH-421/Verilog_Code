module ID_EXE(clk, new_address_in, opcode, A_address, B_address, W_address, Sign, W_address_WB, W_data_WB, Reg_write, B_Hazard, 
 Extend, A_data, B_data, new_address_out, W_address_out, B_address_out, A_address_out, WB, MEM, EX, test, Flush);

//IPs
input clk;
input [7:0]new_address_in;
input [3:0]opcode;
input [3:0]A_address;
input [3:0]B_address;
input [3:0]W_address;
input [3:0]Sign;
input [3:0]W_address_WB;
input [7:0]W_data_WB;
input Reg_write;
input [1:0] B_Hazard;

//OPs
output [7:0] Extend;
output [7:0] A_data;
output [7:0] B_data;
output [7:0] new_address_out;
output [3:0] A_address_out;
output [3:0] W_address_out;
output [3:0] B_address_out;
output [5:0] EX;
output [5:0] MEM;
output [1:0] WB;
output test;
output Flush;


//assign new_address_out = new_address_in;
assign W_address_out = W_address;
assign B_address_out = B_address;
assign A_address_out = A_address;

wire p, q, r, s;
wire [3:0] Comparator_Out;
and A(p, MEM[3], B_Hazard[1]);
and B(q, MEM[2], ~B_Hazard[1]);
and C(r, MEM[1], B_Hazard[0]);
and D(s, MEM[0], ~B_Hazard[0]);
assign test = Flush; 

CONTROL CU(clk, opcode, Comparator_Out, EX, MEM, WB,/* pc_enable*/, Flush);
//module Register(clk,readA,readB,dest,data,reg_wrt,readA_out,readB_out);
Register Reg_File (clk, A_address, B_address, W_address_WB, W_data_WB, Reg_write, A_data, B_data);
ADDER add(new_address_in, Extend, new_address_out);
SIGN extend_7bit (Sign, Extend);

Comparator Mag(A_data, B_data, Comparator_Out); 

endmodule
