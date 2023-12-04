module RAM6(
    input [3:0] in,
    output reg [31:0] my_out   
);

    always @(in, my_out) begin
        case (in)

            4'b0000: my_out = 31'd97243000;
            4'b0001: my_out = 31'd98243000;
            4'b0011: my_out = 31'd99243000;
            4'b0111: my_out = 31'd00243000;
            4'b1111: my_out = 31'd01243000;

            default: 
               my_out = 31'hxxxxxxxx;
        endcase
    end

endmodule

