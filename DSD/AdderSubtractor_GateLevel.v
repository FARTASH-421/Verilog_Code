module AdderSubtractor_GateLevel #(parameter n = 8) (
    input  [n-1:0] A, B,
    input  mode,             // 0: Addition, 1: Subtraction
    output [n-1:0] S,
    output Cout
);
    wire [n-1:0] B_xor;
    wire [n:0] C;
    genvar i;


    buf(C[0], mode);    
    
    generate
        for (i = 0; i < n; i = i + 1) begin
            xor (B_xor[i], B[i], mode);
        end
    endgenerate

 
    generate
        for (i = 0; i < n; i = i + 1) begin
            wire sum, c1, c2;
            xor (sum, A[i], B_xor[i]);
            xor (S[i], sum, C[i]);
            and (c1, A[i], B_xor[i]);
            and (c2, sum, C[i]);
            or  (C[i+1], c1, c2);
        end
    endgenerate

    
    buf(Cout, C[n]);
endmodule
