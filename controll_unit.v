module  controll_unit (inst, br_eq, br_lt, pcmux_sel, imm_sel, regfilemux_sel, cmpop, alumux1_sel, alumux2_sel, aluop, dmem_sel, wbmux_sel);
input [31:0] inst;
input br_eq, br_lt;
output pcmux_sel, regfilemux_sel, cmpop, alumux1_sel, alumux2_sel, dmem_sel;
output [2:0] imm_sel;
output [3:0] aluop;
output [1:0] wbmux_sel;

wire [14:0] controll_word;
wire funct7 = inst[30];
wire [2:0] funct3 = inst[14:12];
wire [4:0] opcode = inst[6:2];

assign
    pcmux_sel = controll_word[14],
    imm_sel = controll_word[13:11],
    regfilemux_sel = controll_word[10],
    cmpop = controll_word[9],
    alumux1_sel = controll_word[8],
    alumux2_sel = controll_word[7],
    aluop = controll_word[6:3],
    dmem_sel = controll_word[2],
    wbmux_sel = controll_word[1:0];
    
assign controll_word =
    (opcode == 5'b01101)? 15'b001110011001001 : // LUI
    (opcode == 5'b00101) ? 15'b001110110001001 : // AUIPC
    (opcode == 5'b11011) ? 15'b110010110001010 : // JAL
    (opcode == 5'b11001) ? (
        (funct3 == 3'b000) ? 15'b100010010000010 : 0) : // JALR
    (opcode == 5'b11000) ? (
        (funct3 == 3'b000) ? {br_eq, 14'b01000110001000} : // BEQ
        (funct3 == 3'b001) ? {~br_eq, 14'b01000110001000} : // BNE
        (funct3 == 3'b100) ? {br_lt, 14'b01001110001000} : // BLT
        (funct3 == 3'b101) ? {~br_lt, 14'b01001110001000} : // BGE
        (funct3 == 3'b110) ? {br_lt, 14'b01000110001000} : // BLTU
        (funct3 == 3'b111) ? {~br_lt, 14'b01000110001000} : 0) : // BGEU
    (opcode == 5'b00000) ? (
        (funct3 == 3'b000) ? 15'b000010010001000 : // LB: N/A, implemented as LW
        (funct3 == 3'b001) ? 15'b000010010001000 : // LH: N/A, implemented as LW
        (funct3 == 3'b010) ? 15'b000010010001000 : // LW
        (funct3 == 3'b100) ? 15'b000010010001000 : // LBU: N/A, implemented as LW
        (funct3 == 3'b101) ? 15'b000010010001000 : 0) : // LHU: N/A, implemented as LW
    (opcode == 5'b01000) ? (
        (funct3 == 3'b000) ? 15'b000100010001100 : // SB: N/A, implemented as SW
        (funct3 == 3'b001) ? 15'b000100010001100 : // SH: N/A, implemented as SW
        (funct3 == 3'b010) ? 15'b000100010001100 : 0) : // SW
    (opcode == 5'b00100) ? (
        (funct3 == 3'b000) ? 15'b000010010001001 : // ADDI
        (funct3 == 3'b010) ? 15'b000010011010001 : // SLTI
        (funct3 == 3'b011) ? 15'b000010011011001 : // SLTIU
        (funct3 == 3'b100) ? 15'b000010010101001 : // XORI
        (funct3 == 3'b110) ? 15'b000010010100001 : // ORI
        (funct3 == 3'b111) ? 15'b000010010011001 : // ANDI
        (funct3 == 3'b001) ? (
            (funct7 == 0) ? 15'b000010010110001 : 0) : // SLLI
        (funct3 == 3'b101) ? (
            (funct7 == 0) ? 15'b000010010111001 : // SRLI
                         15'b000010011000001) : 0) : // SRAI
    (opcode == 5'b01100) ? (
        (funct3 == 3'b000) ? (
            (funct7 == 0) ? 15'b000010000001001 : // ADD
                         15'b000010000010001) : // SUB
        (funct3 == 3'b001) ? 15'b000010000110001 : // SLL
        (funct3 == 3'b010) ? 15'b000010001010001 : // SLT
        (funct3 == 3'b011) ? 15'b000010001011001 : // SLTU
        (funct3 == 3'b100) ? 15'b000010000101001 : // XOR
        (funct3 == 3'b101) ? (
            (funct7 == 0) ? 15'b000010000111001 : // SRL
                         15'b000010001000001) : // SRA
        (funct3 == 3'b110) ? 15'b000010000100001 : // OR
        (funct3 == 3'b111) ? 15'b000010000011001 : 0) : 0; // AND
endmodule
