`timescale 1ns/1ps
module microwave (
    input clk, reset,
    input Start,
    input R,
    input up, down, 
    input [1:0] both,
    input read_memory,
    output reg lamp_door,
    output reg [255:0] dout_Mem,
    output reg [7:0] heat,
    output reg [255:0] display

);

integer fifo_counter = 0;
reg [9:0] buf_mem [255:0];

reg [255:0] Time = 0;
reg [255:0] Temp = 0;
reg [5:0] minent = 60;

reg j, i, p ,q;
reg[3:0] state, nextstate ;
always @(posedge clk, posedge reset)
  begin
    if(reset)begin
        j = 0;
        i = 1;
        p = 1;
        q = 1;
        state = 4'd0;
        display = 0;
        heat = 0;
        buf_mem[fifo_counter] = Time;
        fifo_counter = fifo_counter + 1;
    end else begin
        state <= nextstate;
    end
  end


always @(posedge clk)
  begin
    case(state)
    4'd0:
        if((R | Start) && ~read_memory) begin
            Time = minent;
            if(up) begin
                heat[3] = 1;
            end else if (both[1]) begin
                heat[2] = 1;
            end else if (both[0]) begin
                heat[1] = 1;
            end else if (down) begin
                heat [0] = 1;
            end

            nextstate = 4'd1; 
        end
    4'd1:
        begin
            j <= 0;
            q <= j;
            p <= q;
            i <= p;
            lamp_door <= i;
            if(R) begin
                Time = Time + minent;
            end
            if(~i &&  ~p && ~q ) begin
                nextstate = 4'd2;
            end
      end

    4'd2:
      begin
          if(R) begin
            Time = Time + minent;
          end else begin  
                nextstate = 4'd3;
                display = Time;
                Temp = Time - 5;
          end   
      end

      4'd3:
      begin
            display = Temp;
            Temp = Temp - 5;
            if(Temp <= 0) begin
                i <= 1;
                p <= 1;
                q <= 1;
                nextstate = 4'd4;
            end 
            if (R) begin
                Time = Time + minent;
                Temp = Temp + minent;
            end
      end
    4'd4: begin
            j <= 0;
            q <= j;
            p <= q;
            i <= p;
            lamp_door <= i;
            
    end
    endcase
  end

integer k = 0;
always @(posedge clk) begin
    if(read_memory && k < fifo_counter) begin
        dout_Mem = buf_mem[k];
        k = k + 1;
    end
end


endmodule