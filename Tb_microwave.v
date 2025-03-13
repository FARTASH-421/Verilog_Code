`timescale 1ns/1ps
module Tb_microwave;

    reg clk, reset;
    reg Start;
    reg R;
    reg up, down;
    reg [1:0] both;
    wire lamp_door;
    wire [255:0] display;
    wire[3:0] heat;
    reg read_memory;
    wire [255:0] dout_Mem;

    microwave uut(
        .clk(clk),
        .reset(reset),
        .Start(Start),
        .R(R),
        .up(up),
        .down(down),
        .both(both),
        .read_memory(read_memory),
        .lamp_door(lamp_door),
        .dout_Mem(dout_Mem),
        .heat(heat),
        .display(display)
    );
always
  begin
    #5 clk = ~clk;
  end


initial begin
    clk = 1;
    reset = 1;

    Start = 0;
    R =0; up= 0; down = 0; both  = 0;

    #10;
    reset = 0;
    Start = 1;
    read_memory = 0;
    up= 1;
    down = 0;
    both = 0;
    #10 R = 1;
    #10; R = 1;
    #10; R = 0;
    
    #450; 
    reset = 1;
    Start = 0; up= 0; down = 0; both = 0;

    #20 reset =0;
    down = 1;
    Start = 1;
    #160; R = 1;
    #10; R = 0;


    #180; reset = 1;
    Start = 0; up= 0; down = 0; both = 0;
    #20; reset = 0;
    Start =0;
    R = 1;
    # 10 R = 0;
    both[1] = 1;
    #190; read_memory = 1;

    reset = 1;
    #10;
    reset = 0;


end



endmodule
