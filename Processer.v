`timescale 1ns/1ps
module Processor_core(clk, rst, insaddr, insdata , mem_read, mem_write, data_addr, data_read, data_write);
input clk, rst;
output [7:0] insaddr;
input [15:0] insdata;
output reg mem_read;
output reg mem_write;
output[7:0] data_addr;
output[7:0] data_write;
input [7:0] data_read;

wire [7:0] npc;
reg [7:0] pc;
reg [15:0] instruction;
wire[7:0] regA;
wire[7:0] regB;
wire[7:0] aluA;
wire[7:0] aluB;
wire[7:0] aluZ;
wire[7:0] WB;
wire SF, ZF, CF, OF;

wire MSB;
wire [8:0] OP_MSB;
wire [3:0] OP_MSBZ;
wire [2:0] first_Reg, firstt_Reg, secodn_Reg, immediate_3;
wire [7:0] add_imm_8;

reg reg_write, s1, s2, s3, s4;
reg [4:0] alufunc;

initial begin
    s2 = 0;
end

always @(posedge clk or posedge rst) begin
    if(rst) begin
        pc<= 0;
    end else begin
        pc <= npc;
        reg_write = reg_write;
        mem_read = mem_read;
        s1 = s1;
        s2 = s2;
        s3 = s3;
        s4 = s4;
        mem_write = mem_write;
    end
end
always @(*) begin
    reg_write = 0;
    mem_read = 0;
    mem_write = 0;
    alufunc = 4'b0000;
    s1 = 0;
    s2 = 0;
    s3 = 0;
    s4 = 0;
    case(MSB)
        1'b0: begin
                case(OP_MSB)
                    9'b000000001:  // Add
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b00001;
                            s1 = 1; 
                            s2 = 0;
                        end
                    9'b000000010:   // And
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b00010;
                            s1 = 1; 
                        end
                    9'b000000011: // SUB
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b00011;
                            s1 = 1; 
                        end
                    9'b000000100: // OR
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b00100;
                            s1 = 1; 
                        end
                    9'b000000101: // XOR
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b00101;
                            s1 = 1; 
                        end
                    9'b000000110: // MOVE
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b00110;
                            s1 = 1;   
                        end
                    9'b000000111: //xCHG
                        begin
                            reg_write = 0;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b00111;
                            s1 = 1;
                        end
                    9'b000001000: // NOT_A
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b01000;
                            s1 = 1; 
                        end
                    9'b000001001:  // SLR
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b01001;
                            s1 = 1; 
                        end
                    9'b000001010:  // SLA
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b01010;
                            s1 = 1; 
                        end
                    9'b000001011:  // SAL
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b01011;
                            s1 = 1; 
                        end
                    9'b000001100:  // SLL
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b01100;
                            s1 = 0; 
                        end
                    9'b000001101:  // ROL
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b01101;
                            s1 = 0; 
                        end
                    9'b000001111:  // INC
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b01111;
                        end
                    9'b000010000:  // DEC
                        begin
                            reg_write = 1;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b10000;
                        end
                    9'b000000000:  // NOP
                        begin
                            reg_write = 0;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b00000;
                            s1 = 1; 
                            s2 = 0;
                        end
                    9'b000010100:  // CMP
                        begin
                            reg_write = 0;
                            mem_read = 0;
                            mem_write = 0;
                            alufunc = 5'b10100;
                            s1 = 1; 
                        end
                    endcase
                end
         1'b1: begin
                    case(OP_MSB)
                        4'b0000: // JE
                            begin
                                reg_write = 0;
                                mem_read = 0;
                                mem_write = 0;
                                if(ZF) s2 = 1;
                                else s2 = 0;
                            end
                        4'b0001: // JB
                            begin
                                reg_write = 0;
                                mem_read = 0;
                                mem_write = 0;
                                if(CF) s2 = 1;
                                else s2 = 0;
                            end  
                        4'b0010: // JA
                            begin
                                reg_write = 0;
                                mem_read = 0;
                                mem_write = 0;
                                if(~ZF && ~CF) s2 = 1;
                                else s2 = 0;
                            end  
                        4'b0011: // JL
                            begin
                                reg_write = 0;
                                mem_read = 0;
                                mem_write = 0;
                                if(SF != OF) s2 = 1;
                                else s2 = 0;
                            end    
                        4'b0100: // JG
                            begin
                                reg_write = 0;
                                mem_read = 0;
                                mem_write = 0;
                                if(SF == OF && ~ZF) s2 = 1;
                                else s2 = 0;
                            end 
                        4'b0101: // JMP
                            begin
                                reg_write = 0;
                                mem_read = 0;
                                mem_write = 0;
                                s2 = 1;
                            end  
                        4'b1001: // LM
                            begin
                                reg_write = 1;
                                mem_read = 1;
                                mem_write = 0;
                                alufunc = 5'b00110;
                                s3 = 1;
                                s1 = 0;
                                s4 = 1;
                            end 
                        4'b1000: // LI
                            begin
                                reg_write = 1;
                                mem_read = 0;
                                mem_write = 0;
                                alufunc = 5'b00110;
                                s3 = 1;
                                s1 = 0;
                                s4 = 0;
                            end    
                        4'b1010: // SM
                            begin
                                reg_write = 0;
                                mem_read = 0;
                                mem_write = 1;
                                alufunc = 5'b00110;
                                s3 = 1;
                                s1 = 0;
                            end 
                    endcase  
                end
        endcase    
end

register_file rf(
.clk(clk),
.rst(rst),
.reg_write_en(reg_write),
.reg_read_addr_1(first_Reg),
.reg_read_addr_2(secodn_Reg),
.reg_write_dest(first_Reg),
.reg_write_data(WB),
.reg_read_data_1(regA),
.reg_read_data_2(regB)
);

ALU_pro alu(
.aluA(aluA),
.aluB(aluB),
.alufunc(alufunc),
.aluz(aluZ),
.SF(SF),
.CF(CF),
.ZF(ZF),
.OF(OF)
);


assign npc = s2 ? add_imm_8 : pc + 1;
assign insaddr = pc;
assign MSB = insdata[15];
assign OP_MSB = insdata[14:6];
assign OP_MSBZ = insdata[14:11];
assign first_Reg = s3? insdata[10:8] : insdata[5:3];
assign secodn_Reg = insdata [2:0];
assign immediate_3 = insdata[2:0];
assign add_imm_8 = insdata[7:0];
assign aluA = regA;
assign aluB = s1 ? regB : (s3? add_imm_8 : immediate_3);



assign data_addr = aluZ;
assign data_write = regA;
assign WB = s4 ? data_read : aluZ;

endmodule