`timescale 1ns/1ps
module Tb_multiplierWithAdderShift;

reg clk, rst;
reg [7:0] A;
reg [7:0] B;
wire [15:0] C;


multiWithAdd_Shift f1(clk, rst, A, B, C);

initial 
begin
    clk = 1'b1;
    forever #2 clk = ~clk;
end
initial
begin
    rst = 1; #2;
    rst = 0; A = 8'b01111111; B = 8'b00011111; #20;

    rst = 1; #2;
    rst = 0; A = 8'b00011111; B = 8'b000001011; #20;

    rst = 1; #2;
    rst = 0; A = 8'b00000011; B = 8'b00000010; #20;

    rst = 1; #2;
    rst = 0; A = 8'b10001111; B = 8'b1111_0101; #20;

    rst = 1; #2;
    rst = 0; A = 8'b1111_1111; B = 8'b1001_1001; #20;

    
    rst = 1; #2;
    rst = 0; A = 8'b0000_1111; B = 8'b1011_1001; #20;

    
    rst = 1; #4;
    rst = 0; A = 8'b1111_1111; B = 8'b0001_1001; #20;

    

end
endmodule
