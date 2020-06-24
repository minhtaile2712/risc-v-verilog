module DMEM (clk, dmem_sel, aluout, rs2_out, dmem_out);
parameter MEM_DEPTH = 1024; // Depth of memory in units
input clk, dmem_sel;
input [31:0] aluout, rs2_out;
output [31:0] dmem_out;

reg [7:0] registers[MEM_DEPTH-1:0];
integer i;
initial begin
    for (i = 0; i < MEM_DEPTH; i = i + 1) registers[i] = 0;
end
assign dmem_out = {registers[aluout+3], registers[aluout+2], registers[aluout+1], registers[aluout]};

always @(posedge clk) begin
    if (dmem_sel)
        {registers[aluout+3], registers[aluout+2], registers[aluout+1], registers[aluout]} <= rs2_out;
end
endmodule