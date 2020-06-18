module shifter (alumux1_out, alumux2_out, aluout);
input signed [31:0] alumux1_out, alumux2_out;
output reg [31:0] aluout;

always @(*) begin
    aluout = alumux1_out >>> alumux2_out[4:0];
end
endmodule