module logical_unit #(parameter N=32) (
    output logic [N-1:0] res,
    input logic [N-1:0] a,b,
    input logic [1:0] af,
    input logic i
);

logic [N-1:0] a_and_b, a_or_b, a_xor_b, a_nor_b, b_lsbs;
assign a_and_b = (a & b);
assign a_or_b = (a | b);
assign a_xor_b = (a ^ b);
assign a_nor_b = ~a_or_b;
assign b_lsbs = { b[N/2-1:0], { (N/2){1'b0} } };

logic [N-1:0] sel_and_or, sel_nor_lsbs, sel_nor_lsbs_xor;
nmux21 #(.N(N)) g1 (
    .z(sel_and_or),
    .a(a_and_b),
    .b(a_or_b),
    .s(af[0])
);
nmux21 #(.N(N)) g2 (
    .z(sel_nor_lsbs),
    .a(a_nor_b),
    .b(b_lsbs),
    .s(i)
);
nmux21 #(.N(N)) g3 (
    .z(sel_nor_lsbs_xor),
    .a(a_xor_b),
    .b(sel_nor_lsbs),
    .s(af[0])
);
nmux21 #(.N(N)) g4 (
    .z(res),
    .a(sel_and_or),
    .b(sel_nor_lsbs_xor),
    .s(af[1])
);

endmodule
