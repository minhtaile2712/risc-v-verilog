module test_shift;
reg [31:0] alumux1_out, alumux2_out;
wire [31:0] aluout;

shifter dut(alumux1_out, alumux2_out, aluout);

initial begin
    alumux1_out = 0; alumux2_out = 0;
    #10 alumux1_out = 1; alumux2_out = 1; // shift left logical
    #10 alumux1_out = 32'hFFFF0000; alumux2_out = 8; // shift right logical
    #10 alumux1_out = -2; alumux2_out = 8; // shift right arithmetic
end

initial
    $monitorh($stime,, alumux1_out,, alumux2_out,, aluout);
endmodule