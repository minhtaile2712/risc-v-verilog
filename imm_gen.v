module imm_gen (imm_sel, inst, imm_out);
input [2:0] imm_sel;
input [31:0] inst;
output [31:0] imm_out;

assign imm_out = (imm_sel == 3'b000) ? ({{21{inst[31]}}, inst[30:20]}) : // I-immediate
                    (imm_sel == 3'b001) ? {{21{inst[31]}}, inst[30:25], inst[11:7]} :// S-immediate
                    (imm_sel == 3'b010) ? {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0} : // B-immediate
                    (imm_sel == 3'b011) ? {inst[31:12], 12'b0} : // U-immediate
                    (imm_sel == 3'b100) ? {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0} : // J-immediate
                    32'hDEADBEEF; // Error!!!
endmodule