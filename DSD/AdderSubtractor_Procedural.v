module AdderSubtractor_Procedural #(parameter n = 8) (
    input  [n-1:0] A, B,
    input  mode,                    // 0: Addition, 1: Subtraction
    output reg [n-1:0] S,
    output reg Cout
);
    always @(*) begin
        {Cout, S} = mode ? (A - B) : (A + B); 
    end
endmodule

