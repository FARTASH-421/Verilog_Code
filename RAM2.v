module RAM2(input [1:0] in,
    output reg [31:0] my_out   
);

    always @(in, my_out) begin
        case (in)

            2'b00: my_out = 32'h0000009;
            2'b01: my_out = 32'h00000024;
            2'b10: my_out = 32'h00000067;
            2'b11: my_out = 32'h00000045;

            default: 
               my_out = 31'hxxxxxxxx;
        endcase
    end

endmodule

