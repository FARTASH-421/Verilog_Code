module MUX_1(

    input [31:0] data_1, data_2,
    input sel,
    output reg [31:0] my_out

);

   initial begin
     assign my_out = sel ? data_1 : data_2;
   end 

endmodule
