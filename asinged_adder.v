//****************************
// singed addition 4 bite
//****************************

module signed_addition(
    input wire [3:0] a, b, 
    output reg [3:0] sum
   );
    reg [3:0] mag_a, mag_b, max, min;
    reg sign_a, sign_b, sign;
 
    always @* begin
      mag_a = a[2:0] ;
      mag_b = b[2:0] ;
      sign_a =a[3] ; 
      sign_b =b[3] ;
         
      if(mag_a > mag_b) begin
        max = mag_a; 
        min = mag_b; 
        sign <= sign_a; 
            end
      else begin 
        max = mag_b; 
        min = mag_a; 
        sign <= sign_b;
        end
         
      if(sign_a == sign_b) begin   
        sum[2:0] = max + min; 
        end
      else begin 
        sum[2:0] = max - min;
        end
         
      sum[3:0] = {sign, sum[2:0]};
    end
endmodule