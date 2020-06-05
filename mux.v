module mux2to1(sel, din0, din1, dout);
parameter WIDTH = 32;
input sel;
input [WIDTH-1:0] din0, din1;
output [WIDTH-1:0] dout;

assign dout = sel? din1 : din0;
endmodule

module mux4to1(sel, din0, din1, din2, din3, dout);
parameter WIDTH = 32;
input [1:0] sel;
input [WIDTH-1:0] din0, din1, din2, din3;
output [WIDTH-1:0] dout;

assign dout = sel[1]? (sel[0]? din3 : din2) : (sel[0]? din1 : din0);
endmodule

module mux8to1(sel, din0, din1, din2, din3, din4, din5, din6, din7, dout);
parameter WIDTH = 32;
input [2:0] sel;
input [WIDTH-1:0] din0, din1, din2, din3, din4, din5, din6, din7;
output [WIDTH-1:0] dout;

wire [WIDTH-1:0] mux0out, mux1out;
mux4to1 mux0(sel[1:0], din0, din1, din2, din3, mux0out);
mux4to1 mux1(sel[1:0], din4, din5, din6, din7, mux1out);
assign dout = sel[2]? mux1out : mux0out;
endmodule