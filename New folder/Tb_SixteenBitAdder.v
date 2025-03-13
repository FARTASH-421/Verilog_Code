

module Tb_SixteenBitAdder;

    reg  A;     
    reg  B;         

    wire Z;          

    // Instantiate the SixteenBitAdder module
    SixteenBitAdder uut (
        .a(A),
        .b(B),
        .z(Z)
    );


    initial begin

        A = 1'b0; B = 1'b0;

        #10 A = 1'b1; B = 1'b0;
        #5 A = 1'b1; B = 1'b1;
        #5 A = 1'b0; B = 1'b1;
        #5 A = 1'b0; B = 1'b1;
        #5 A = 1'b0; B = 1'b0;
        #5 A = 1'b0; B = 1'b0;
        #5A = 1'b0; B = 1'b0;
    end

endmodule
