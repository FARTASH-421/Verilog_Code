module SIGN(a,b);
    input [3:0]a;
    output reg [7:0]b;
    always @(a or b)begin
        if(a[3]==1)
            b = {4'b1111, a};
        else
            b = {4'b0000, a};
    end
endmodule