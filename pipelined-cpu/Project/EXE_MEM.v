module EXE_MEM(clk, alu_code, mux2_in, mux1_in, new_address_in, A_data, B_data, Extend, A_register, B_register, W_register_WB, MEM, MEM_regwrt, WB_regwrt, MEM_data, WB_data, MEM_dest, WB_dest, 
                zero, carry, new_address_out, alu_result, Write_data_to_RAM, Mux1_O, MEM_O, Branch_Taken
);

    input clk;
    input [3:0] alu_code;
    input mux2_in;
    input mux1_in;
    input [7:0] new_address_in;
    input [7:0] A_data;
    input [7:0] B_data;
    input [7:0] Extend;
    input [3:0] A_register;
    input [3:0] B_register;
    input [3:0] W_register_WB;
    input [5:0] MEM;
    input MEM_regwrt, WB_regwrt;
    input [7:0] MEM_data, WB_data;
    input [3:0] MEM_dest, WB_dest;


    output zero,carry;
    output [7:0] new_address_out, alu_result;
    output [7:0] Write_data_to_RAM;
    output [3:0] Mux1_O;
    output [3:0] Branch_Taken;
    output [1:0] MEM_O;

    wire [7:0] mux2_out, out_for_ALU, out_for_mux2;
    wire [1:0] ForA, ForB;

    MUX4 ForwardA(A_data, MEM_data, WB_data, ForA, out_for_ALU);
    MUX4 ForwardB(B_data, MEM_data, WB_data, ForB, out_for_mux2);
    MUX2 mux2(out_for_mux2, Extend, mux2_in, mux2_out);
    MUX1 mux1(B_register, W_register_WB, mux1_in, Mux1_O);

    ALU Arithmetic(out_for_ALU, mux2_out, alu_code, alu_result, zero, carry);

    Forward Forwarding_Unit(MEM_regwrt, WB_regwrt, MEM_dest, WB_dest, A_register, B_register, ForA, ForB);

    ADDER add(new_address_in, Extend, new_address_out);
    wire p, q, r, s;
    and a(p, MEM[3], zero);
    and b(q, MEM[2], ~zero);
    and c(r, MEM[1], carry);
    and d(s, MEM[0], ~carry);

    assign Branch_Taken = {p, q, r, s};
    assign MEM_O = MEM[5:4];
    assign Write_data_to_RAM = B_data;
endmodule
