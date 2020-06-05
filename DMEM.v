module dmem(clk, dmem_sel, aluout, rs2_out, dmem_out);
parameter WIDTH = 32; // Width of input data and output data in bits
parameter MEM_WIDTH = 8; // Width of memory in bits
parameter MEM_DEPTH = 1024; // Depth of memory in units
input clk, dmem_sel;
input [WIDTH-1:0] aluout, rs2_out;
output reg [WIDTH-1:0] dmem_out;

reg [MEM_WIDTH-1:0] registers[MEM_DEPTH-1:0];

always @(posedge clk) begin
    if (dmem_sel) begin
        registers[aluout] <= rs2_out[7:0];
        registers[aluout+1] <= rs2_out[15:8];
        registers[aluout+2] <= rs2_out[23:16];
        registers[aluout+3] <= rs2_out[31:24];
    end
    dmem_out <= {registers[aluout+3], registers[aluout+2], registers[aluout+1], registers[aluout]};
end

// integer i;
// initial begin
//     for (i = 0; i < 1024; i = i + 1)
//         registers[i] = 0;
// end
endmodule
