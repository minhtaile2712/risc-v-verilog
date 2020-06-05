module pc(clk, reset, pc_in, pc_out);
parameter WIDTH = 32;
input clk, reset;
input [WIDTH-1:0] pc_in;
output reg [WIDTH-1:0] pc_out;

always @(posedge clk) begin
    if (reset == 1)
        pc_out = 0;
    else
        pc_out = pc_in;
end
endmodule