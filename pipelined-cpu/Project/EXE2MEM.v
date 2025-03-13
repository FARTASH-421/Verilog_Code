module EXE2MEM(clk, WB, MEM, Jump_address, alu_result, mem_data_in, mux1_in, zero, carry, 
                WB_O, Branch, read, write, zero_O, carry_O, mux1_O,alu_RAM_address, RAM_data
);

    input clk;
    input [1:0] WB;
    input [1:0] MEM;
    input [7:0] Jump_address, alu_result, mem_data_in;
    input [3:0] mux1_in;
    input zero, carry;

    output reg [1:0]WB_O;
    output reg [3:0] Branch;
    output reg read;
    output reg write;
    output reg zero_O;
    output reg carry_O;
    output reg [3:0] mux1_O;
    output reg [7:0]alu_RAM_address;
    output reg [7:0]RAM_data;

    always @(negedge clk)begin
        WB_O <= WB;
        read <= MEM[1];
        write <= MEM[0];
        zero_O <= zero;
        carry_O <= carry;
        mux1_O <= mux1_in;
        alu_RAM_address <= alu_result;
        RAM_data <= mem_data_in;
    end

endmodule
