`timescale 1ns / 1ns
module Elevator(
    input  [3:0]F,
    input [3:0]S,
    input [3:0]D,
    input [3:0]U,
    input reset,
    input clk,

    output reg [1:0] AC, // 0 -> stop , 1 -> up , 2 -> down
    output reg [2:0] DISP,
    output reg open
  );
 
  
  reg[3:0] state, nextstate ;
  reg [3:0] s, u, d, f;

  initial begin
        assign s = S;
        assign f = F;
        assign u = U;
        assign d = D;

    end

  always @(posedge clk, posedge reset)
  begin
    if(reset)
    begin
      state = 4'd0;
      s = 4'd0;
      f = 4'd0;
      u = 4'd0;
      d = 4'd0;      
    end else begin
        state <= nextstate;
    end
  end

  always @(posedge clk, f, d, u, s)
  begin

    case(state)
      4'd0:
      begin
          AC = 0 ;
          DISP = 0 ;
          open = 1 ;
          nextstate = 4'd1 ; 
      end
      4'd1:
      begin
          if((f[0] || d[0]|| u[0]) && (s[0] == 1'b1)) begin
            nextstate = 4'd0;
          end
          else if(f[1] || f[2] || f[3] || d[1] || d[2] || d[3] || u[1] || u[2] || u[3]) begin         
            AC = 1 ;
            DISP = 0 ;
            open = 0 ;
            nextstate = 4'd2;
          end
      end
      4'd2:
      begin
          if( (f[1] || d[1]|| u[1]) && (s[1] == 1'b1) ) begin
            nextstate = 4'd3;
          end
          else if(f[2] || f[3] || d[2] || d[3] || u[2] || u[3]) begin
            AC = 1 ;
            DISP = 1 ;
            open = 0 ;
            nextstate = 4'd4;
          end
          else if (f[0] || u[0] || d[0]) begin
            AC = -1 ;
            DISP = 1 ;
            open = 0 ;
            nextstate = 4'b1;
          end
          
      end
      4'd3:
      begin
          AC = 0 ;
          DISP = 1 ;
          open = 1 ;
          nextstate = 4'd2; 
          
      end
      4'd4:
      begin
         if((f[2] || d[2] || u[2]) && (s[2] == 1'b1))begin
            nextstate = 4'd5;
         end
          else if(f[3] || d[3] || u[3]) begin
            AC = 1 ;
            DISP = 2 ;
            open = 0 ;
            nextstate = 4'd6;
          end
          else if (f[0] || f[1] || d[0] || d[1] || u[0] || u[1]) begin
            AC = -1 ;
            DISP = 2 ;
            open = 0 ;
            nextstate = 4'd2;
          end
      end
      4'd5:
      begin 
          AC = 0 ;
          DISP = 2 ;
          open = 1 ;
          nextstate = 4'd4;  
      
      end
      4'd6:
      begin
         if((f[3] || d[3] || u[3]) && (s[3] == 1'b1)) begin
          nextstate = 4'd7;
         end
          else if (f[0] || f[1] || f[2] || d[0] || d[1] || d[2] || u[0] || u[1] || u[2]) begin
            AC = -1;
            DISP = 3 ;
            open = 0 ;
            nextstate = 4'd4;
          end
       
      end
      4'd7:
      begin 
          AC = 0 ;
          DISP = 3 ;
          open = 1 ;
          nextstate = 4'd6;   
      end
    endcase
  end
endmodule

