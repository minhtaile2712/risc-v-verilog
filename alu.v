module alu (aluop, alumux1_out, alumux2_out, aluout);
input [3:0] aluop;
input [31:0] alumux1_out, alumux2_out;
output reg [31:0] aluout = 0;

wire [4:0] shamt = alumux2_out[4:0]; // Shift amount

always @(aluop, alumux1_out, alumux2_out) begin
    case (aluop)
        4'b0000: aluout <= (alumux1_out + alumux2_out) & -2; // addspecial
        4'b0001: aluout <= alumux1_out + alumux2_out; // add
        4'b0010: aluout <= alumux1_out - alumux2_out; // sub
        4'b0011: aluout <= alumux1_out & alumux2_out; // and
        4'b0100: aluout <= alumux1_out | alumux2_out; // or
        4'b0101: aluout <= alumux1_out ^ alumux2_out; // xor
        4'b0110: aluout <= alumux1_out << shamt; // shiftleftlogical
        4'b0111: aluout <= alumux1_out >> shamt; // shiftrightlogical
        4'b1000: aluout <= $signed(alumux1_out) >>> $signed(shamt); // shiftrightarithm
        4'b1001: aluout <= alumux2_out; // passthrough
        4'b1010: aluout <= $signed(alumux1_out) < $signed(alumux2_out); // compareless
        4'b1011: aluout <= alumux1_out < alumux2_out; // comparelessunsign
        default: aluout <= 32'hDEADBEEF; // Error!!!
    endcase
end
endmodule
