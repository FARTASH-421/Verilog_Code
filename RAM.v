module RAM_255(Din, Addr, Rst, En, We, Clk, Dout);
input En, We, Rst;
input Clk;
input [7:0] Addr;
input [9:0] Din;
output [9:0] Dout;

reg [9:0] Memory[255:0];
reg [7:0] address_register;
integer  i;
always @(posedge Clk) begin
    if(Rst)begin
        address_register = 0;
        for(i = 0; i<10; i = i + 1)begin
             Memory[i] = 1'bx;
        end
    end else if(En && We) begin
        Memory[Addr] <= Din;
        address_register <=1'bx ;
    end 
    else if (En && ~We) begin
        address_register <= Addr; 
        
    end

end

assign Dout = Memory[address_register];

endmodule