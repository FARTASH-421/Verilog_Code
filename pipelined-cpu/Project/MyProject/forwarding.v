`include "defines.v"

module forwarding_EXE (src1_EXE, src2_EXE, ST_src_EXE, dest_MEM, dest_WB, WB_EN_MEM, WB_EN_WB, val1_sel, val2_sel, ST_val_sel);
  input [`REG_FILE_ADDR_LEN-1:0] src1_EXE, src2_EXE, ST_src_EXE;
  input [`REG_FILE_ADDR_LEN-1:0] dest_MEM, dest_WB;
  input WB_EN_MEM, WB_EN_WB;
  output reg [`FORW_SEL_LEN-1:0] val1_sel, val2_sel, ST_val_sel;

  always @ ( * ) begin
    {val1_sel, val2_sel, ST_val_sel} <= 0;

    if (WB_EN_MEM && ST_src_EXE == dest_MEM) begin
        ST_val_sel <= 2'd1;
    end else if (WB_EN_WB && ST_src_EXE == dest_WB) begin
      ST_val_sel <= 2'd2;
    end

    if (WB_EN_MEM && src1_EXE == dest_MEM) begin
     val1_sel <= 2'd1;
    end else if (WB_EN_WB && src1_EXE == dest_WB)begin 
      val1_sel <= 2'd2;
    end


    if (WB_EN_MEM && src2_EXE == dest_MEM) begin 
        val2_sel <= 2'd1;
    end else if (WB_EN_WB && src2_EXE == dest_WB) begin 
       val2_sel <= 2'd2;
    end
  end
endmodule 
