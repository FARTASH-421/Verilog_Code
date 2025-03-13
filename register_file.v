`timescale 1ns/1ps

module register_file(
    input clk,
    input rst,
    input reg_write_en,
    input [2:0] reg_read_addr_1,
    input [2:0] reg_read_addr_2,
    input [2:0] reg_write_dest,

    input [7: 0] reg_write_data,
    output [7:0] reg_read_data_1,
    output [7:0] reg_read_data_2
);
    reg [7:0] reg_array [7:0];

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            reg_array[0] <= 8'd1;
            reg_array[1] <= 8'd2;
            reg_array[2] <= 8'd0;
            reg_array[3] <= 8'd0;
            reg_array[4] <= 8'd0;
            reg_array[5] <= 8'd0;
            reg_array[6] <= 8'd0;
            reg_array[7] <= 8'd0;
        end
        else begin
            if(reg_write_en) begin
                reg_array[reg_write_dest] <=reg_write_data;
            end

         end
    end

    assign reg_read_data_1 = reg_array[reg_read_addr_1];
    assign reg_read_addr_2 = reg_array[reg_read_addr_2];


endmodule
