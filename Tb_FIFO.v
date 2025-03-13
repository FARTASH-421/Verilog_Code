module Tb_FIFO;
reg clk, rst;
reg [9:0] Din;
reg wr_en, rd_en;

wire [9:0] Dout;
wire empty;
wire full;


FIFO tb(
    .clk(clk),
    .rst(rst),
    .Din (Din),
    .Dout(Dout),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .empty(empty),
    .full(full)
    );
reg [7:0] test_datas;

initial begin
    clk = 1;
    Din = 0;
    wr_en = 0;
    rd_en = 0;
    rst = 1;
end

always
#10 clk = ~clk;
always begin
#10 rst = 0;
    for(test_datas =0; test_datas < 5; test_datas = test_datas +1) begin
        #10 wr_en = 1; 
         Din = test_datas;
        #10 wr_en = 0;
    end

    for(test_datas=0; test_datas < 4; test_datas = test_datas + 1) begin
       #10 rd_en = 1; 
       #10 rd_en = 0;
    end
    #20 wr_en = 1;
    Din = 62;
    #10 wr_en = 1;
    #10 rd_en = 1;
    #10 rd_en= 0;

end
endmodule
