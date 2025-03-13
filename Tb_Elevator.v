`timescale 1ns / 1ns

module Tb_Elevator;

  // Inputs
  reg [3:0] F;
  reg [3:0] S;
  reg [3:0] D;
  reg [3:0] U;
  reg reset;
  reg clk;

  // Outputs
  wire [1:0] AC;
  wire [2:0] DISP;
  wire open;

  // Instantiate the Unit Under Test (UUT)
  Elevator uut (
             .F(F),
             .S(S),
             .D(D),
             .U(U),
             .reset(reset),
             .clk(clk),
             
             .AC(AC),
             .DISP(DISP),
             .open(open)
           );
 
always
  begin
    #5 clk = ~clk;
  end

  initial
  begin
    // Initialize Inputs
    F = 0;
    S = 0;
    D = 0;
    U = 0;
    reset = 1;
    clk = 0;

    #10;
    reset = 0; 
    #10
    U[1] = 1; S[1] = 1;  #20  S[1] = 0; U[1] = 0;
    #20
    D[3] = 1; S[3] = 1; #70 S[3] = 0; D[3] = 0;
    #30
   D[2] = 1; S[2] = 1; #20 S[2] = 0; D[2] = 0;

   #30
   U[0] = 1; S[0] = 1; #50 S[0] = 0; U[0] = 0;

   #30 
    D[2] = 1; S[2] = 1; 
    #20
    F[1] = 1; S[1] = 1; #20 S[1] = 0; F[1] = 0;
    #40 S[2] = 0; D[2] = 0;
  

  end
endmodule
