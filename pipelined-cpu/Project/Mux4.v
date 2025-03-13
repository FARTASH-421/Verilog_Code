module MUX4(A, B, C, sel, D);
    input [7:0] A;
    input [7:0] B;
    input [7:0] C;
    input [1:0]sel;
    output reg [7:0]D;

    always @(*)begin
        case(sel)
            2'b00: D = A;
            2'b01: D = B;
            2'b10: D = C;
        endcase
    end
endmodule
