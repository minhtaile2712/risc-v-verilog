module test_alu;
reg [3:0] aluop;
reg [31:0] alumux1_out, alumux2_out;
wire [31:0] aluout;

alu dut(aluop, alumux1_out, alumux2_out, aluout);

initial begin
    aluop = 0; alumux1_out = 0; alumux2_out = 0;
    #10 aluop = 0; alumux1_out = 3; alumux2_out = 2; // add bit0 set to 0
    #10 aluop = 1; alumux1_out = 3; alumux2_out = 2; // add
    #10 aluop = 2; alumux1_out = 3; alumux2_out = 2; // sub
    #10 aluop = 3; alumux1_out = 32'h000FFFFF; alumux2_out = 32'hFFFF00FF; // and
    #10 aluop = 4; alumux1_out = 32'h000FFFFF; alumux2_out = 32'hFFFF00FF; // or
    #10 aluop = 5; alumux1_out = 32'h000000FF; alumux2_out = 32'hFF0000FF; // xor
    #10 aluop = 6; alumux1_out = 1; alumux2_out = 1; // shift left logical
    #10 aluop = 7; alumux1_out = 32'hFFFF0000; alumux2_out = 8; // shift right logical
    #10 aluop = 8; alumux1_out = 32'hFFF00000; alumux2_out = 8; // shift right arithmetic
    #10 aluop = 9; alumux1_out = 32'hFFFF0000; alumux2_out = 4; // = alumux2_out
    #10 aluop = 10; alumux1_out = 2; alumux2_out = 7; // = 0
    #10 aluop = 11; alumux1_out = 1; alumux2_out = 2; // = 1
end

initial
    $monitorh($stime,, aluop,, alumux1_out,, alumux2_out,, aluout);
endmodule