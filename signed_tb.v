//*********************************
//
// test banch signed adder 
// abdul qadir Fartash
//
//**********************************

module signed_tb;
    // Inputs
    reg [3:0] a ;
    reg [3:0] b ;
    // Outputs
    wire [3:0] sum;
    integer i;
    // Instantiate the Unit Under Test (UUT)
    signed_addition uut (
        .a(a) , 
        .b(b) , 
        .sum(sum)
    );
    initial begin
       #100;
       a = 4'h0;
       b = 4'h0;
       for(i=0; i<15; i=i+1) begin
        // Initialize Inputs
        a = a + 4'h1 ;
        b = b + 4'h2;
            // Wait 10 ns for global reset to finish
        #100;
        end
            //Add stimulus here
    end
endmodule