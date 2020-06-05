module test_cpu();
reg clk, reset;

cpu dut(clk, reset);

initial begin // Clock generator
    clk = 0;
    forever #10 clk = !clk;
end

initial begin
    reset = 1;
    #20 reset = 0;
end

initial
    $monitorh($stime,, clk,, reset);

endmodule