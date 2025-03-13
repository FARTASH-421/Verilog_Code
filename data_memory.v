`timescale 1ns/1ps

module data_memory(
    input clk,
    input [7:0] mem_access_addr,
    input [7:0] mem_write_data,
    input mem_write_en,
    input mem_read,
    output [7:0] mem_read_data
);

integer i;
reg [7:0] ram [255:0];
wire [7:0] ram_addr = mem_access_addr[7:0];
initial begin
    ram[0] = 8'b0000_0011;
    ram[1] = 8'b0000_0100;
    ram[2] = 8'b0000_0101;
    ram[3] = 8'b0000_0110;
    ram[4] = 8'b0000_0111;
    ram[5] = 8'b0000_1000;
    ram[6] = 8'b0000_1001;
    ram[7] = 8'b0000_1011;
    
    for(i = 8; i< 256; i = i + 1)
        ram[i] <= 8'd0;
end

always @(posedge clk) begin
    if (mem_write_en)
        ram[ram_addr] <= mem_write_data;
end

assign mem_read_data = (mem_read == 1'b1) ? ram[ram_addr] : 8'd0;

endmodule
