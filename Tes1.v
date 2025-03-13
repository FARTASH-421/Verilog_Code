
module deCoder2_4( input [1:0] In,En,
                   output [3:0] d_Out);
  
    reg [3:0] outMe;
    always @(En or In)
    begin
        if (En)
        begin
            if (In == 2'b00)
                outMe= 4'b0001;
            else if (In == 2'b01)
                outMe = 4'b0010;
            else if (In == 2'b10)
                outMe = 4'b0100;
            else if (In == 2'b11)
                outMe = 4'b1000;
            else
                $display("Error!");
        end
    end
	assign d_Out = outMe;
endmodule


