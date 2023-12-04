module RAM5(input [1:0] in,
    output reg [31:0] my_out   
);

    always @(in, my_out) begin
        case (in)

            2'b00: my_out = 32'h00000019;
            2'b01: my_out = 32'h00000014;
            2'b10: my_out = 32'h00000077;
            2'b11: my_out = 32'h00000069;

            default: 
               my_out = 31'hxxxxxxxx;
        endcase
    end
endmodule