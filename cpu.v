module cpu (clk, reset);
parameter OP_WIDTH = 4;
input clk, reset;

wire [31:0] aluout, pc_plus4_out, pc_in;
mux2to1 PCmux (sel, pc_plus4_out, aluout, pc_in);
//
//
//
pc PC (clk, reset, pc_in, pc_out);
//
//
//
add4 pc_plus4 (pc_out, pc_plus4_out);
//
wire [31:0] inst;
IMEM IMEM (inst, pc_out);
//
//
//
wire regfilemux_sel;
wire [4:0] rsd, rs1, rs2;
assign rsd = inst[11:7];
assign rs1 = inst[19:15];
assign rs2 = inst[24:20];
wire [31:0] wb_out, rs1_out, rs2_out;
register_bank Register_bank (clk, regfilemux_sel, rs1, rs2, rsd, wb_out, rs1_out, rs2_out);
//
wire [31:0] imm_out;
wire [2:0] imm_sel;
// wire [24:0] imm_in;
// assign imm_in = inst[31:7];
// imm_gen ImmGen (imm_sel, imm_in, imm_out);
imm_gen ImmGen (imm_sel, inst, imm_out);
//
//
//
wire cmpop, br_eq, br_lt;
comparator BranchComp (cmpop, rs1_out, rs2_out, br_eq, br_lt);
//
//
//
wire alumux1_sel;
wire [31:0] alumux1_out;
mux2to1 ALUmux1 (alumux1_sel, rs1_out, pc_out, alumux1_out);
//
wire alumux2_sel;
wire [31:0] alumux2_out;
mux2to1 ALUmux2 (alumux2_sel, rs2_out, imm_out, alumux2_out);
//
//
//
wire [OP_WIDTH-1:0] aluop;
alu ALU (aluop, alumux1_out, alumux2_out, aluout);
//
//
//
wire dmem_sel;
wire [31:0] dmem_out;
dmem DMEM (clk, dmem_sel, aluout, rs2_out, dmem_out);
//
//
//
wire [1:0] wbmux_sel;
mux4to1 Wbmux (wbmux_sel, dmem_out, aluout, pc_plus4_out,, wb_out);
//
//
//
controller Control();
endmodule
