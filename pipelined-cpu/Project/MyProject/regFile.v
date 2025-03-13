`include "defines.v"

module regFile (clk, reset, read_Reg1, read_Reg2, write_Reg, write_data, writeEn, data_reg1, data_reg2);
  input clk, reset, writeEn;
  input [`REG_FILE_ADDR_LEN-1:0] read_Reg1, read_Reg2, write_Reg;
  input [`WORD_LEN-1:0] write_data;
  output [`WORD_LEN-1:0] data_reg1, data_reg2;

  reg [`WORD_LEN-1:0] regMem [0:`REG_FILE_SIZE-1];
  integer i;

  always @ (negedge clk) begin
      if (reset) begin
        for (i = 0; i < `WORD_LEN; i = i + 1)
          regMem[i] <= i;
	    end else if (writeEn)
            regMem[write_Reg] <= write_data;
    regMem[0] <= 0;
  end

  assign data_reg1 = regMem[read_Reg1];
  assign data_reg2 = regMem[read_Reg2];

endmodule 
