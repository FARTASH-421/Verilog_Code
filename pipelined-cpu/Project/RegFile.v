module Register(clk,readA,readB,dest,data,reg_wrt,readA_out,readB_out);
    input reg_wrt;
    input [3:0]readA, readB, dest;
    input [7:0]data;
    input clk;
    output [7:0]readA_out, readB_out;


    reg [7:0] Register [0:15];
    initial begin
        Register[1]=1;  //Random values stored
        Register[2]=2;
        Register[3]=3;
        Register[4]=4;
        Register[5]=5; // You can change any value within this initial block
        Register[6]=6;
        Register[7]=7;
        Register[8]=8;
        Register[9]=9;
        Register[10]=10;
        Register[12]=12;
        Register[11]=11;
    end

    assign readA_out = Register[readA];
    assign readB_out = Register[readB];

    always @(posedge clk)
        if(reg_wrt==1)begin
            Register[dest]<=data;
        end

endmodule
