module test_comparator;
parameter WIDTH = 32;
reg cmpop;
reg [WIDTH-1:0] rs1_out, rs2_out;
wire br_eq, br_lt;

comparator dut(cmpop, rs1_out, rs2_out, br_eq, br_lt);

initial begin
    #0 cmpop = 0;  rs1_out = 0; rs2_out = 0;
    #10 rs1_out = 32'hFFFFFFFF; rs2_out = 32'hFFFFFFFF;
    #10 rs1_out = 32'hFFFFFFFF; rs2_out = 32'hFFFFFFF0;
    #10 rs1_out = 32'hFFFFFFF0; rs2_out = 32'hFFFFFFFF;
    #10 rs1_out = 32'h0FFFFFFF; rs2_out = 32'hFFFFFFFF;
    #10 rs1_out = 32'hFFFFFFFF; rs2_out = 32'h0FFFFFFF;
    #10 cmpop = 1; rs1_out = 0; rs2_out = 0;
    #10 rs1_out = 32'hFFFFFFFF; rs2_out = 32'hFFFFFFFF;
    #10 rs1_out = 32'hFFFFFFFF; rs2_out = 32'hFFFFFFF0;
    #10 rs1_out = 32'hFFFFFFF0; rs2_out = 32'hFFFFFFFF;
    #10 rs1_out = 32'h0FFFFFFF; rs2_out = 32'hFFFFFFFF;
    #10 rs1_out = 32'hFFFFFFFF; rs2_out = 32'h0FFFFFFF;
end

initial
    $monitorh($time,, cmpop,, rs1_out,, rs2_out,, br_eq,, br_lt);
endmodule