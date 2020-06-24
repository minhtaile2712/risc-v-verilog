module riscv;
parameter FIRST_PC = 32'h00000000; // or 32'h00400000
reg clk = 0;

wire [31:0] alumux1_out, alumux2_out, aluout, dmem_out, imm_out, inst, pc_in, pc_out, pc_plus4_out, rs1_out, rs2_out, wb_out ;
wire [3:0] aluop;
wire [2:0] imm_sel;
wire [1:0] wbmux_sel;
wire alumux1_sel, alumux2_sel, br_eq, br_lt, cmpop, dmem_sel, pcmux_sel, regfilemux_sel;

mux2to1 PCmux (pcmux_sel, pc_plus4_out, aluout, pc_in);
pc #(FIRST_PC) PC (clk, pc_in, pc_out);
add4 pc_plus4 (pc_out, pc_plus4_out);
IMEM #(FIRST_PC) imem (inst, pc_out);
register_bank Register_bank (clk, regfilemux_sel, inst, wb_out, rs1_out, rs2_out);
imm_gen ImmGen (imm_sel, inst, imm_out);
comparator BranchComp (cmpop, rs1_out, rs2_out, br_eq, br_lt);
mux2to1 ALUmux1 (alumux1_sel, rs1_out, pc_out, alumux1_out);
mux2to1 ALUmux2 (alumux2_sel, rs2_out, imm_out, alumux2_out);
alu ALU (aluop, alumux1_out, alumux2_out, aluout);
DMEM dmem (clk, dmem_sel, aluout, rs2_out, dmem_out);
mux4to1 Wbmux (wbmux_sel, dmem_out, aluout, pc_plus4_out,, wb_out);
controll_unit controller(inst, br_eq, br_lt, pcmux_sel, imm_sel, regfilemux_sel, cmpop, alumux1_sel, alumux2_sel, aluop, dmem_sel, wbmux_sel);

initial begin // Clock generator
    forever #10 clk = !clk;
end
initial
    $monitorh($stime,, pc_in,, pc_out,, inst,, pcmux_sel);
endmodule