module RAM1(
    input [5:0] in,
    output reg [5:0] my_out   
);

    always @(in, my_out) begin
        case (in)
// sum
            6'b0000_00: my_out = 6'b00_0001;
            6'b0000_01: my_out = 6'b01_0001;
            6'b0000_10: my_out = 6'b10_0001;
            6'b0000_11: my_out = 6'b11_0001;

// sub
            6'b0001_00: my_out = 6'b00_0011;
            6'b0001_01: my_out = 6'b01_0011;
            6'b0001_10: my_out = 6'b10_0011;
            6'b0001_11: my_out = 6'b11_0011;
// other
           6'b0011_00: my_out = 6'b00_0100;
           6'b0100_01: my_out = 6'b00_1000;
           6'b0110_01: my_out = 6'b00_1010;
           6'b0101_01: my_out = 6'b00_1011;
           6'b0111_01: my_out = 6'b00_1111;
            default: 
               my_out = 31'hzzzzzzzz;
        endcase
    end

endmodule


