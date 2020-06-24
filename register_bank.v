module register_bank (clk, regfilemux_sel, inst, wb_out, rs1_out, rs2_out);
input clk, regfilemux_sel;
input [31:0] inst, wb_out;
output [31:0] rs1_out, rs2_out;

wire [4:0] rsd = inst[11:7], rs1 = inst[19:15], rs2 = inst[24:20];
reg [31:0] registers[0:31];
assign rs1_out = registers[rs1];
assign rs2_out = registers[rs2];

always @(posedge clk) begin
    if (regfilemux_sel)
        if (rsd != 0)
            registers[rsd] <= wb_out;
end
integer i;
initial begin
    for (i = 0; i < 32; i = i + 1) registers[i] = 0;
end
endmodule