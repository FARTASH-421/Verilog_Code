`timescale 1ns/1ps

module Tb_Processer;
reg clk;
reg rst;
wire [15:0] insdata;
wire [7:0] data_read;

// output
wire [7:0] insaddr;
wire mem_read;
wire mem_write;
wire [7:0] data_addr;
wire [7:0] data_write;

// Instantiate the uint tess (uut)


Processor_core uut (
    .clk(clk),
    .rst(rst),
    .insaddr(insaddr),
    .insdata(insdata),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .data_addr(data_addr),
    .data_read(data_read),
    .data_write(data_write)
);
 // IM
    IM im (
        .pc(insaddr),
        .instruction(insdata)
    );

    // data memory
    data_memory dm (
        .clk(clk),
        .mem_access_addr(data_addr),
        .mem_write_data(data_write),
        .mem_write_en(mem_write),
        .mem_read(mem_read),
        .mem_read_data(data_read)
    );
    

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;
    end

    always #10 clk = ~clk;

endmodule
