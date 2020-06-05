// module imm_gen (imm_sel, imm_in, imm_out);
// input [2:0] imm_sel;
// input [24:0] imm_in;
// output [31:0] imm_out;

// reg [31:0] imm;
// // 000 I-type
// imm[11:0] = imm_in[24:13];

// // 001 S-type
// imm[11:5] = imm_in[24:18];
// imm[4:0] = imm_in[4:0];

// // 010 B-type
// imm[12] = imm_in[24];
// imm[10:5] = imm_in[23:18];
// imm[4:1] = imm_in[4:1];
// imm[11] = imm_in[0];

// // 011 U-type
// imm[31:12] = imm_in[24:5];

// // 100 J-type
// imm[20] = imm_in[24];
// imm[10:1] = imm_in[23:14];
// imm[11] = imm_in[13];
// imm[19:12] = imm_in[12:5];
// endmodule

module imm_gen (imm_sel, inst, imm_out);
input [2:0] imm_sel;
input [31:0] inst;
output [31:0] imm_out;

assign imm_out = (imm_sel == 3'b000) ? ({{21{inst[31]}}, inst[30:20]}) : // I-immediate
                    (imm_sel == 3'b001) ? {{21{inst[31]}}, inst[30:25], inst[11:7]} :// S-immediate
                    (imm_sel == 3'b010) ? {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0} : // B-immediate
                    (imm_sel == 3'b011) ? {inst[31:12], 12'b0} : // U-immediate
                    (imm_sel == 3'b110) ? {{11{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0} : // J-immediate
                    31'b0; // Error!!!
endmodule