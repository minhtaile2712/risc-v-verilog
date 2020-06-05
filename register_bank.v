module register_bank(clk, regfilemux_sel, rs1, rs2, rsd, wb_out, rs1_out, rs2_out);
parameter WIDTH = 32;
input clk, regfilemux_sel;
input [4:0] rs1, rs2, rsd;
input [WIDTH-1:0] wb_out;
output reg [WIDTH-1:0] rs1_out, rs2_out;

reg [WIDTH-1:0] registers[31:0];

always @(posedge clk) begin
    if (regfilemux_sel)
        if (rsd != 0)
            registers[rsd] = wb_out;
    rs1_out <= registers[rs1];
    rs2_out <= registers[rs2];
end

integer i;
initial begin
    for (i = 0; i < 32; i = i + 1)
        registers[i] = 0;
end
endmodule