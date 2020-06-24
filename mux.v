module mux2to1 (sel, din0, din1, dout);
input sel;
input [31:0] din0, din1;
output [31:0] dout;

assign dout = sel? din1 : din0;
endmodule

module mux4to1 (sel, din0, din1, din2, din3, dout);
input [1:0] sel;
input [31:0] din0, din1, din2, din3;
output [31:0] dout;

assign dout = sel[1]? (sel[0]? din3 : din2) : (sel[0]? din1 : din0);
endmodule