module Tb_Encoder4to2;
reg a,b,c,d;
wire x,y,v;

EnCoder4to2 F1(a,b,c,d,x,y,v);
initial
    begin
        #000 a=0; b=0;c=0;d=1;
        #100 a=0; b=0;c=1;d=0;
        #100 a=0; b=1;c=0;d=0;
        #100 a=1; b=0;c=0;d=0;
        #100 a=0; b=1;c=0;d=1; 
    
    end

endmodule
