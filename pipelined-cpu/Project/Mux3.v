module MUX3(A, B, sel, C);
    input [7:0] A, B;
    input sel;
    output reg [7:0]C;
    always @(*)begin
    if(sel==0)
        C = A;
    else
        C = B;
    end
endmodule
