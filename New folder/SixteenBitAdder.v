module myModule(a, b, z);
input a, b;
wire x, y;
output z;

assign #4 x = a & !b;
assign #3 y = a | b;
assign #5 z = x ^ y;

endmodule