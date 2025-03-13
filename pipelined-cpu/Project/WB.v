module WB(mux3_select, mem_data, alu_result, mux1_in, W_data, W_addr_Reg);
    input mux3_select;
    input [3:0]mux1_in;
    input [7:0] mem_data;
    input [7:0] alu_result;

    output [7:0]W_data;
    output [3:0]W_addr_Reg;
    assign W_addr_Reg = mux1_in;
    MUX3 max(mem_data, alu_result, mux3_select, W_data);
    
endmodule
