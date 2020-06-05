module add4 (din, dout);
parameter WIDTH = 32;
input [WIDTH-1:0] din;
output [WIDTH-1:0] dout;

assign dout = din + 4;
endmodule
