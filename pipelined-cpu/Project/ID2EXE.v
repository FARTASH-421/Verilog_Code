module ID2EXE (clk, new_address_IDEXE, A_data_IDEXE, B_data_IDEXE, 
Extend_IDEXE, A_address_IDEXE, B_address_IDEXE, W_address_IDEXE, WB, MEM, EX,
WB_O, MEM_O, alu_code, mux1, mux2, new_address_EXMEM, Sign_O, readA_O, readB_O, A_reg_O, B_reg_O, W_reg_O

);

    input clk;
    input [7:0] new_address_IDEXE;
    input [7:0] A_data_IDEXE;
    input [7:0] B_data_IDEXE;
    input [7:0] Extend_IDEXE;
    input [3:0] A_address_IDEXE;
    input [3:0] B_address_IDEXE;
    input [3:0] W_address_IDEXE;
    input [5:0] EX;
    input [5:0] MEM;
    input [1:0] WB;

    output reg [1:0] WB_O;
    output reg [5:0] MEM_O;
    output reg [3:0] alu_code;
    output reg mux1, mux2;
    output reg [7:0] new_address_EXMEM;
    output reg [7:0] Sign_O;
    output reg [7:0] readA_O;
    output reg [7:0] readB_O;
    output reg [3:0] A_reg_O;
    output reg [3:0] B_reg_O;
    output reg [3:0] W_reg_O;

    always @(negedge clk)begin
        WB_O <= WB;
        MEM_O <= MEM;
        alu_code <= EX[3:0];
        mux1 <= EX[4];
        mux2 <= EX[5];
        new_address_EXMEM <= new_address_IDEXE;
        Sign_O <= Extend_IDEXE;
        readA_O <= A_data_IDEXE;
        readB_O <= B_data_IDEXE;
        A_reg_O <= A_address_IDEXE;
        B_reg_O <= B_address_IDEXE;
        W_reg_O <= W_address_IDEXE;

    end

endmodule
