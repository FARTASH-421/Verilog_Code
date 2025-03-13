module AdderSubtractor_Continuous #(parameter n = 8) (
    input  [n-1:0] A, B,
    input  mode,                        // 0: Addition, 1: Subtraction
    output [n-1:0] S,
    output Cout
);
    wire [n-1:0] B_xor;
    wire [n:0] sum;

    assign B_xor = B ^ {n{mode}}; 
    assign sum = A + B_xor + mode; 
    assign S = sum[n-1:0]; 
    assign Cout = sum[n];               // Carry-Out

endmodule

