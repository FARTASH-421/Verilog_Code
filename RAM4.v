module RAM4(
    input [1:0] in,
    output reg [31:0] my_out   
);

    always @(in, my_out) begin
        case (in)

            2'b00: my_out = 32'h00001100;
            2'b01: my_out = 32'h00000080;
            2'b10: my_out = 32'h00000060;
            2'b11: my_out = 32'h00000040;

            default: 
               my_out = 31'hxxxxxxxx;
        endcase
    end

endmodule


