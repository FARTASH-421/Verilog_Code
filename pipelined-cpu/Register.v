`define WORD_SIZE 16    // data and address word size

module Register(clk, addr1, addr2, rd, writeData, readData1, readData2, regWrite, reset);
	input clk, reset, regWrite;
	input [1:0] addr1, addr2;
	input [2:0] rd;
	input [`WORD_SIZE-1:0] writeData;
	
	output [`WORD_SIZE-1:0] readData1;
	output [`WORD_SIZE-1:0] readData2;

	reg [`WORD_SIZE-1:0] register[3:0];

	initial begin
		register[0] = 0;
		register[1] = 0;
		register[2] = 0;
		register[3] = 0;
	end

	assign readData1 = register[addr1];
	assign readData2 = register[addr2];

	always @(posedge reset) begin
		register[0] = 0;
		register[1] = 0;
		register[2] = 0;
		register[3] = 0;
	end

	always @(rd or writeData or regWrite) begin
		if(regWrite == 1) begin
			register[rd] = writeData;
		end
		else begin
			register[rd] = register[rd];
		end
	end
endmodule
