module comparator (cmpop, rs1_out, rs2_out, br_eq, br_lt);
parameter WIDTH = 32;
input cmpop;
input [WIDTH-1:0] rs1_out, rs2_out;
output br_eq, br_lt;

// br_eq: ==1: A == B, ==0: A != B.
assign br_eq = rs1_out == rs2_out;

// cmpop: ==1: signed compare, ==0: unsigned compare.
// br_lt: ==1: A < B, ==0: A >= B.
assign br_lt = cmpop?  ($signed(rs1_out) < $signed(rs2_out)) : (rs1_out < rs2_out);
endmodule