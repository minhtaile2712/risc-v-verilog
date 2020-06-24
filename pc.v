module pc (clk, pc_in, pc_out);
parameter FIRST_PC = 32'h00000000;
input clk;
input [31:0] pc_in;
output reg [31:0] pc_out = FIRST_PC; // PC after reset

always @(posedge clk) begin
    pc_out <= pc_in;
end
endmodule