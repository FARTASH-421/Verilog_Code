`timescale 1ns/1ps
module ALU_pro(
    input [7:0] aluA,
    input [7:0] aluB,
    input [4:0] alufunc,
    output [7:0] aluz,
    output reg SF, CF, ZF, OF
);

reg [15:0] temp;
reg sf, cf, zf, of;
integer i;
always @(*) begin
    case (alufunc)
        5'd1:  begin
                    temp = aluA + aluB;
                    of = (aluA[7] && aluB[7] && ~temp[7]) || (~aluA[7] && ~aluB[7] && temp[7]);
                    cf = (temp[8]);
                    sf = (temp[7]);
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of;
                end
         5'd2:  begin
                    temp = aluA & aluB;
                    of = 0;
                    cf = 0;
                    sf = (temp[7]);
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of;
                end
         5'd3:  begin
                    temp = aluA - aluB;
                    of = (aluA[7] && aluB[7] && ~temp[7]) || (~aluA[7] && ~aluB[7] && temp[7]);
                    cf = (temp[8]);
                    sf = (temp[7]);
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of;
                end
         5'd4:  begin
                   temp = aluA | aluB;
                    of = 0;
                    cf = 0;
                    sf = (temp[7]);
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of;
                end
         5'd5:  begin
                    temp = aluA ^ aluB;
                    of = 0;
                    cf = 0;
                    sf = (temp[7]);
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of;
                end

         5'd6:  begin
                    temp[7:0] = aluB;
                    // aluz = temp[7:0];    
                end
        5'd7:  begin
                    temp[7:0] = aluA;
                    temp[15:8] = aluB;   
                end 
         5'd8:  begin
                    temp[7:0] = ~aluA;
                    // aluz  = temp[7:0];   
                end 
        5'd9:  begin
                    temp[7:0] = aluA >>> aluB;
                    of = (temp[7] == aluA[7]) ? 0: 1;
                    cf = aluA[aluB-1];
                    sf = temp[7];
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of; 
                end 
        5'd10:  begin
                    temp[7:0] = aluA >> aluB;
                    of = (temp[7] == aluA[7]) ? 0: 1;
                    cf = aluA[aluB-1];
                    sf = temp[7];
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of; 
                end
        5'd11:  begin
                    temp[7:0] = aluA <<< aluB;
                    of = (temp[7] == aluA[7]) ? 0: 1;
                    cf = aluA[aluB-1];
                    sf = temp[7];
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of; 
                end
        5'd12:  begin
                    temp[7:0] = aluA << aluB;
                    of = (temp[7] == aluA[7]) ? 0: 1;
                    cf = aluA[aluB-1];
                    sf = temp[7];
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of; 
                end
        5'd15:  begin
                    temp = aluA +1;
                    of = (aluA[7] && 0 && ~temp[7]) || (~aluA[7] && 1 && temp[7]);
                    cf = temp[8];
                    sf = temp[7];
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of; 
         end
         5'd16:  begin
                    temp = aluA - 1;
                    of = (aluA[7] && 0 && ~temp[7]) || (~aluA[7] && 1 && temp[7]);
                    cf = temp[8];
                    sf = temp[7];
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    // aluz = temp[7:0];
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of; 
         end
        5'd0:   begin
                end
        5'd20:   begin
                    temp = aluA - aluB;
                    of = (aluA[7] && aluB[7] && ~temp[7]) || (~aluA[7] && ~aluB[7] && temp[7]);
                    cf = temp[8];
                    sf = temp[7];
                    if (temp == 0) zf = 1;
                    else zf = 0;
                    SF = sf;
                    ZF = zf;
                    CF = cf;
                    OF = of; 
                end
    endcase 
end

assign aluz = temp[7:0];
endmodule
