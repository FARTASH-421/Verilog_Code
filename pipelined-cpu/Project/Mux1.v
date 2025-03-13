module MUX1(A, B, sel, C);

input [3:0] A, B;
input sel;
output reg [3:0]C;
always @(*)begin
    if(sel==0)
        C = A;
    else
        C = B;
    end

endmodule
