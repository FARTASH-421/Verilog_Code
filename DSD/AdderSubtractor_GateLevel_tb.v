`timescale 1ns / 1ps

module AdderSubtractor_GateLevel_tb();
    parameter n = 8;
    
    reg  [n-1:0] A, B;
    reg  mode;
    wire [n-1:0] S;
    wire Cout;
    
    AdderSubtractor_GateLevel #(n) DUT (
        .A(A),
        .B(B),
        .mode(mode),
        .S(S),
        .Cout(Cout)
    );
    
    initial begin
        $monitor("Time=%0t | A=%b B=%b Mode=%b | S=%b Cout=%b", $time, A, B, mode, S, Cout);
        
        A = 8'b00000001; B = 8'b00000010; mode = 0; #10; // 1 + 2 = 3
        
        A = 8'b01111111; B = 8'b00000001; mode = 0; #10; // 127 + 1 = 128
        
        A = 8'b10001001; B = 8'b00000011; mode = 1; #10; // 137 - 3 = 134
        
        A = 8'b00000100; B = 8'b00001010; mode = 1; #10; // 4 - 10 = -6 (Two's complement)
        
        A = 8'b11111111; B = 8'b11111111; mode = 0; #10; // 255 + 255 = 510 (Overflow expected)
        
        A = 8'b11111111; B = 8'b00000001; mode = 1; #10; // 255 - 1 = 254
        
        A = 8'b10101010; B = 8'b10101010; mode = 1; #10; // 170 - 170 = 0
        
        $stop;
    end
endmodule