module comparator (cmpop, rs1_out, rs2_out, br_eq, br_lt);
parameter WIDTH = 32;
input cmpop;
input [WIDTH-1:0] rs1_out, rs2_out;
output br_eq, br_lt;

assign br_eq = rs1_out == rs2_out;
assign br_lt = cmpop?  ($signed(rs1_out) < $signed(rs2_out)) : (rs1_out < rs2_out);
endmodule