// `timescale 1ns / 1ns

// module Tb_Elevator;

//   // Inputs
//   reg [3:0] F;
//   reg [3:0] S;
//   reg [3:0] D;
//   reg [3:0] U;
//   reg reset;
//   reg clk;

//   // Outputs
//   wire [3:0] clr;
//   wire [1:0] AC;
//   wire [2:0] DISP;
//   wire open;

//   // Instantiate the Unit Under Test (UUT)
//   elveator uut (
//              .F(F),
//              .S(S),
//              .D(D),
//              .U(U),
//              .reset(reset),
//              .clk(clk),
//              .clr(clr),
//              .AC(AC),
//              .DISP(DISP),
//              .open(open)
//            );
 
// always
//   begin
//     #5 clk = ~clk;
//   end

//   initial
//   begin
//     // Initialize Inputs
//     F = 0;
//     S = 0;
//     D = 0;
//     U = 0;
//     reset = 1;
//     clk = 0;

//     // Wait 100 ns for global reset to finish
//     #100;
//     reset = 0;
//     U[2] = 1; 
//     S[2] = 1;
//     U[0] =1; U[1] =1;


//     #30;
//     // F[1] = 1;

//     // #20;
//     // S = 0;
//     // S[1] = 1;
    

//   end
// endmodule

