module IF_ID(clk, reset, select_line, new_address, pc_select, opcode, A_reg_address,
             B_reg_address, W_reg_address, Sign, pc_to_im, next_pc_address
);

    input clk, reset;
    input select_line;
    input [7:0]new_address;
    input pc_select;

    output [3:0]opcode;
    output [3:0]A_reg_address;
    output [3:0]B_reg_address;
    output [3:0]W_reg_address;
    output [3:0]Sign;
    output [7:0]pc_to_im;
    output [7:0]next_pc_address;


    wire [7:0] pc_out;
    wire [7:0] pc_in, pc_to_im, next_pc_address;


    //PC_ADD adder(pc_to_im,next_pc);
    assign next_pc_address = pc_to_im + 2;
    MUX8 mux4(next_pc_address, new_address, select_line, pc_in); 
    //module PC(in,clk,pc_select,out);
    PC P_Counter(pc_in, clk, pc_select, reset, pc_to_im);
    //module IF_Stage(in,out,clk,pc_select,opcode,A_reg,B_reg,W_reg,Sign);
    IM Instruction_Mem(pc_to_im, clk, reset, opcode, A_reg_address, B_reg_address, W_reg_address, Sign);


endmodule
