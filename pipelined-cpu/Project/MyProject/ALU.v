`include "defines.v"

module ALU (A, B, ALUOp, AluOut);
  input [`WORD_LEN-1:0] A, B;
  input [`EXE_CMD_LEN-1:0] ALUOp;
  output reg [`WORD_LEN-1:0] AluOut;

  always @ ( * ) begin
    case (ALUOp)
      `EXE_ADD: AluOut <= A + B;
      `EXE_SUB: AluOut <= A - B;
      `EXE_AND: AluOut <= A & B;
      `EXE_OR:  AluOut <= A | B;
      `EXE_NOR: AluOut <= ~(A | B);
      `EXE_XOR: AluOut <= A ^ B;
      `EXE_SLA: AluOut <= A << B;
      `EXE_SLL: AluOut <= A <<< B;
      `EXE_SRA: AluOut <= A >> B;
      `EXE_SRL: AluOut <= A >>> B;
       default: AluOut <= 0;
    endcase
  end
endmodule // ALU
