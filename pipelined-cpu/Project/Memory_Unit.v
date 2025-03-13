module Memory_Unit(clk, address, data_in, data_out, re, wr);
    input [7:0]address;
    input [7:0]data_in;
    input clk,re,wr;
    output [7:0]data_out;
    reg[7:0] mem [0:30];

    initial begin
        mem[4]=15;
        mem[7]=14;
    end

    always @(negedge clk)begin
        if(wr)
            mem[address] <= data_in;
    end

    assign data_out = re? mem [address] : 0;

endmodule
