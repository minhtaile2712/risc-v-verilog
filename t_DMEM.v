module test_DMEM();
parameter WIDTH = 32; // Width of input data and output data in bits
parameter MEM_WIDTH = 8; // Width of memory in bits
parameter MEM_DEPTH = 1024; // Depth of memory in units
reg clk, dmem_sel;
reg [WIDTH-1:0] aluout, rs2_out;
wire [WIDTH-1:0] dmem_out;

dmem dut(clk, dmem_sel, aluout, rs2_out, dmem_out);

initial begin // Clock generator
    clk = 0;
    forever #10 clk = !clk;
end

initial begin
    dmem_sel = 0; aluout = 0; rs2_out = 0;
    #5 dmem_sel = 1; aluout = 32'h00000000; rs2_out = 32'hFFFFFFFF;
    #20 dmem_sel = 0;
    #20 dmem_sel = 1; aluout = 32'h00000004; rs2_out = 32'hAAAAAAAA;
    #20 dmem_sel = 0;
    #20 dmem_sel = 1; aluout = 32'h00000008; rs2_out = 32'hDEADBEEF;
    #20 dmem_sel = 0;
    #20 dmem_sel = 1; aluout = 32'h0000000C; rs2_out = 32'hDEAFBACD;
    #20 dmem_sel = 0;
    #20 dmem_sel = 0; aluout = 32'h00000000;
    #20 dmem_sel = 0; aluout = 32'h00000004;
    #20 dmem_sel = 0; aluout = 32'h00000008;
    #20 dmem_sel = 0; aluout = 32'h0000000C;
    #20 dmem_sel = 1; aluout = 32'h00000008; rs2_out = 32'hDDDDAAAA;
    #20 dmem_sel = 0;
end

initial
    $monitorh($stime,, clk,, dmem_sel,, aluout,, rs2_out,, dmem_out); 
endmodule