`timescale 1ns/1ps;

module DataPath_2(clk, reset, current_PC_address, readA_O, readB_O, A_Reg_IF2ID, B_Reg_IF2ID, Sign_IF2ID, opcode, W_Reg_IF2ID, W_address_WB, alu_result_O, W_data_WB);
    input clk, reset;
    output [7:0] current_PC_address,readA_O, readB_O;
    output [3:0] opcode, A_Reg_IF2ID, B_Reg_IF2ID, W_Reg_IF2ID, Sign_IF2ID, W_address_WB;
    output [7:0] alu_result_O, W_data_WB;





    wire [3:0]opcode, A_reg_address, B_reg_address, W_reg_address, Sign, opcode_IF2ID, A_Reg_IF2ID, B_Reg_IF2ID, W_Reg_IF2ID, Sign_IF2ID
    , W_address_IDEXE, B_address_IDEXE, A_address_IDEXE;
    wire [7:0] current_PC_address, next_PC_address, next_PC_address_IF2ID, Extend_IDEXE, A_data_IDEXE, B_data_IDEXE, new_address_IDEXE, W_data_WB;

    wire [7:0] Sign_O, readA_O, readB_O, new_address_EXMEM, alu_result, mem_data, alu_result_O, Jump_address_O, new_address_EXMEM_O,Write_data_to_RAM
    ,alu_O, mem_out_O, RAM_data;
    wire [3:0] A_reg_O, B_reg_O, W_reg_O, alu_code,Mux1_O_WB_Register, Branch, Branch_O, mux1_O, mux1_O1, W_address_WB;
    wire [1:0] WB,WB_O, WB_O2;
    wire [5:0] MEM, EX, MEM_O;
    wire test;
    wire [3:0] Branch_Taken;
    wire [1:0] B_Check;
    wire PC_freeze, IF_P_Freeze, Flush_O;


    // HazardUnit HD(MEM_O[4], B_reg_O, A_Reg_IF2ID, B_Reg_IF2ID, PC_freeze, IF_P_Freeze, Flush_O);
    // Branch_Unit Branch_Hazard_Unit(opcode_IF2ID, A_data_IDEXE, B_data_IDEXE, Flush, B_Check);
                        //Yha Branch_O use krna hoga test ki jagah par new_address_IDEXE
    IF_ID Fetch(clk, reset, test, new_address_IDEXE, ~PC_freeze,
    opcode, A_reg_address, B_reg_address, W_reg_address, Sign, current_PC_address, next_PC_address);

    IF2ID PIPE_IF2ID(clk, next_PC_address, opcode, A_reg_address, B_reg_address, W_reg_address, Sign, /*IM_Freeze*/IF_P_Freeze, Flush, //Flush, 
    next_PC_address_IF2ID, opcode_IF2ID, A_Reg_IF2ID, B_Reg_IF2ID, W_Reg_IF2ID, Sign_IF2ID);

//                   clk,  new_address_in,      opcode,       A_address,   B_address,   W_address,   Sign,       W_address_WB, W_data_WB, Reg_write, B_Hazard, 
    ID_EXE ID_STAGE(clk, next_PC_address_IF2ID, opcode_IF2ID, A_Reg_IF2ID, B_Reg_IF2ID, W_Reg_IF2ID, Sign_IF2ID, W_address_WB, W_data_WB, Reg_write, B_Check,
 // Extend,       A_data,       B_data,       new_address_out,   W_address_out,   B_address_out,   A_address_out,   WB, MEM, EX, test, Flush);
    Extend_IDEXE, A_data_IDEXE, B_data_IDEXE, new_address_IDEXE, W_address_IDEXE, B_address_IDEXE, A_address_IDEXE, WB, MEM, EX, test, Flush);



    ID2EXE PIPE_ID2EXE(clk, new_address_IDEXE, A_data_IDEXE, B_data_IDEXE, Extend_IDEXE, A_address_IDEXE, B_address_IDEXE, W_address_IDEXE, WB, MEM, EX,
     WB_O, MEM_O, alu_code, mux1, mux2, new_address_EXMEM, Sign_O, readA_O, readB_O, A_reg_O, B_reg_O, W_reg_O);
    
    wire [1:0] MEM_EXE;
    EXE_MEM Execute(clk, alu_code, mux2, mux1, new_address_EXMEM, readA_O, readB_O, Sign_O, A_reg_O, B_reg_O, W_reg_O, MEM_O, WB_O2[0], Reg_write, alu_result_O, W_data_WB, mux1_O, W_address_WB, 
    zero, carry, new_address_EXMEM_O, alu_result, Write_data_to_RAM, Mux1_O_WB_Register, MEM_EXE, Branch_Taken);

    EXE2MEM PIPE_EXE2MEM(clk, WB_O, MEM_EXE, new_address_EXMEM_O, alu_result, Write_data_to_RAM, Mux1_O_WB_Register, zero, carry, 
    WB_O2, Branch, read, write, zero_O, carry_O, mux1_O, alu_result_O, RAM_data);

    MEM_WB Memory(clk, read, write, Branch, alu_result_O, RAM_data, zero_O, carry_O, mem_data, Branch_O);
    MEM2WB PIPE_MEM2WB(clk, WB_O2, mem_data, alu_result_O, mux1_O, mux1_O1, alu_O, mem_out_O, mux3, Reg_write);


    WB Write_Back(mux3, mem_out_O,alu_O, mux1_O1, W_data_WB, W_address_WB);

endmodule
