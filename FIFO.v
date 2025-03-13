module FIFO(
    input clk, 
    input rst,
    input wr_en,
    input rd_en,
    input [9:0] Din,
    output reg [9:0] Dout,
    output reg empty,
    output reg full 
);

reg [9:0] fifo_counter;
reg [9:0] rd_ptr, wr_ptr;
reg [9:0] buf_mem [8:0];

always @(fifo_counter) begin
    empty = (fifo_counter == 0);
    full = (fifo_counter == 256);

end

always @(posedge clk or posedge rst) begin
    if(rst)
        fifo_counter <= 0;
    else if ((!full && wr_en) && (!empty && rd_en))
        fifo_counter <= fifo_counter;
    else if(wr_en && !full)
        fifo_counter <= fifo_counter + 1;
    else if(rd_en && !empty)
        fifo_counter <= fifo_counter -1;
    else
        fifo_counter <= fifo_counter;

end

always @(posedge clk or posedge rst) begin
    if(rst)
        Dout <= 0;
    else begin
            if(rd_en && !empty)
                Dout <= buf_mem[rd_ptr];
            else
                Dout <= Dout;
    end
end

always @(posedge clk) begin
    if(wr_en && !full)
        buf_mem[wr_ptr] <= Din;
    else 
        buf_mem[wr_ptr] <= buf_mem[wr_ptr];
end
always @(posedge clk or posedge rst) begin
    if(rst) begin
        rd_ptr <= 0;
        wr_ptr <= 0;
    end
    else begin
        if(wr_en && !full)
            wr_ptr <= wr_ptr + 1;
        else
            wr_ptr <= wr_ptr;
        if(rd_en && !empty)
            rd_ptr <= rd_ptr + 1;
        else
            rd_ptr <= rd_ptr;
    end
end

endmodule