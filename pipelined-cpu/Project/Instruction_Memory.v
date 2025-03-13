module IM(in,clk, reset, opcode, A_reg, B_reg, W_reg, Sign);
    input [7:0]in;
    input clk, reset;
    reg [3:0]dest;
    output [3:0]opcode;
    output [3:0]A_reg;
    output [3:0]B_reg;
    output [3:0]W_reg;
    output [3:0]Sign;

    reg [7:0] imem [0:19];
    reg [15:0] instruction; 
    reg [8:0]temp;

    always @(*)begin
        if(reset) begin
            imem[0]=8'b0001_0001; //0000
            imem[1]=8'b0010_0001;

            imem[2]=8'b0010_0101; //0010
            imem[3]=8'b0101_0010; 

            imem[4]=8'b0011_0111; //0100
            imem[5]=8'b0111_0100;

            imem[6]=8'b0100_0110; //0110
            imem[7]=8'b0101_0110;

            imem[8]=8'b0101_1010; //1000
            imem[9]=8'b0111_0101;

            imem[10]=8'b0110_0001; //1010
            imem[11]=8'b0100_0110;

            imem[12]=8'b1110_0010; //1100
            imem[13]=8'b0011_0111;

            imem[14]=8'b1111_0001; //1110
            imem[15]=8'b0100_0010;
        end
    end

    assign A_reg = imem[in][3:0];
    assign opcode = imem[in][7:4];
    assign B_reg = imem[in+1][7:4];
    assign W_reg = imem[in+1][3:0];
    assign Sign = imem[in+1][3:0];


endmodule




