module MEM2WB(clk, WB, mem_out, alu_result, mux1_w_reg, mux1_w_reg_O, alu_O, mem_out_O, mux3, regwrt);
    input clk;
    input [1:0] WB;
    input [7:0] mem_out;
    input [7:0] alu_result;
    input [3:0] mux1_w_reg;

    output reg [3:0] mux1_w_reg_O;
    output reg [7:0] alu_O, mem_out_O;
    output reg mux3;
    output reg regwrt;

    always @(negedge clk)begin
        mux1_w_reg_O <=  mux1_w_reg;
        alu_O <= alu_result;
        mem_out_O <= mem_out;
        mux3 <= WB[1];
        regwrt <= WB[0];
    end
endmodule
