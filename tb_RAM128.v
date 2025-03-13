`timescale 1ns/1ps

module Tb_RAM255 ;
reg [9:0] Din;
reg [7:0] Addr;
reg En;
reg Rst;
reg We;
reg Clk;

wire [9:0] Dout;
RAM_255 uut( Din, Addr, Rst, En, We, Clk, Dout);


initial begin // clock initialization
Clk =1'b1;
forever #10 Clk=~Clk;
end
initial begin
    Rst = 1;
    #20
    Rst = 0;
    En = 1;
    We = 1;
    #20;
    Addr = 2; Din = 40;
    #20;
    Addr = 90; Din = 60;
    #20;
    We = 0; Addr = 2;
    #20;
    We = 1;
    #20;
    Addr = 120; Din = 128;

    #10;
    We = 0;
    #10; Addr = 90;
    #10;  Addr = 120;

    
end

endmodule
