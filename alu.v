module alu (aluop, alumux1_out, alumux2_out, aluout);
parameter OP_WIDTH = 4;
input [OP_WIDTH-1:0] aluop;
input [31:0] alumux1_out, alumux2_out;
output [31:0] aluout;

wire [31:0] shifteddata;
shifter shift(alumux1_out, alumux2_out, shifteddata);

wire [4:0] shamt = alumux2_out[4:0]; // Shift amount
assign aluout =
    (aluop == 4'b0000) ? ((alumux1_out + alumux2_out) & 32'hFFFFFFFE) : // 0
    // JALR

    (aluop == 4'b0001) ? (alumux1_out + alumux2_out) : // 1
    // JAL (Jump And Link)
    // ADDI (ADD Immediate)
    // ADD
    // AUIPC (Add Upper Immediate to PC)
    // BEQ (Branch if EQual)
    // BNE (Branch if Not Equal)
    // BLT (Branch if Less Than)
    // BGE (Branch if Greater than or Equal)
    // BLTU (Branch if Less Than Unsigned)
    // BGEU (Branch if Greater than or Equal Unsigned)
    // LB (Load Byte)
    // LH (Load Half word)
    // LW (Load Word)
    // LBU (Load Byte)
    // LHU (Load Half word Unsigned)
    // SB (Store Byte)
    // SH (Store Half word)
    // SW (Store Word)

    (aluop == 4'b0010) ? (alumux1_out - alumux2_out) : // 2
    // SUB

    (aluop == 4'b0011) ? (alumux1_out & alumux2_out) : // 3
    // ANDI (AND Immediate)
    // AND

    (aluop == 4'b0100) ? (alumux1_out | alumux2_out) : // 4
    // ORI (OR Immediate)
    // OR

    (aluop == 4'b0101) ? (alumux1_out ^ alumux2_out) :// 5
    // XORI (eXclusive-OR Immediate)
    // XOR

    (aluop == 4'b0110) ? (alumux1_out << shamt) : // 6
    // SLLI - Shift Left Logical Immediate (Logical left shift)
    // SLL

    (aluop == 4'b0111) ? (alumux1_out >> shamt) : // 7
    // SRLI - Shift Right Logical Immediate (Logical right shift)
    // SRL

    (aluop == 4'b1000) ? (shifteddata) : // 8
    // SRAI - Shift Right Arithmetic Immediate (Arithmetic right shift)
    // SRA

    (aluop == 4'b1001) ? (alumux2_out) : // 9
    // LUI - Load Upper Immediate

    (aluop == 4'b1010) ? 1'b0 : // br_lt == 0 // 10
    (aluop == 4'b1011) ? 1'b1 : // br_lt == 1 // 11
    // SLTI (Set if Less Than Immediate)
    // SLTIU (Set if Less Than Immediate Unsigned)
    // SLT (Set if Less Than)
    // SLTU (Set if Less Than Unsigned)

    32'hDEADBEEF; // Error!!!
endmodule