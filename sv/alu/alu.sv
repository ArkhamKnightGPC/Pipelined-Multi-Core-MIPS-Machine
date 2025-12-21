module alu #(parameter N=32) (
    output logic [N-1:0] alures,
    output logic ovfalu,
    input logic [N-1:0] a,b,
    input logic[3:0] af,
    input logic i
);

logic [N-1:0] arith_out;
logic ovf,neg,u,sub;
assign u = af[0];
assign sub = af[1];
au #(.N(N)) arith_ops(
    .s(arith_out),
    .ovf(ovf),
    .neg(neg),
    .a(a),
    .b(b),
    .u(u),
    .sub(sub)
);

logic [N-1:0] logic_out;
logical_unit #(.N(N)) logic_ops(
    .res(logic_out),
    .a(a),
    .b(b),
    .af(af[1:0]),
    .i(i)
);

logic [N-1:0] sel_arith_logic;
nmux21 #(.N(N)) g1 (
    .z(sel_arith_logic),
    .a(arith_out),
    .b(logic_out),
    .s(af[2])
);

logic cmp;
logic [N-1:0] cmp_res;
assign cmp = neg;
assign cmp_res = { {(N-1){1'b0}}, cmp };


nmux21 #(.N(N)) g2 (
    .z(alures),
    .a(sel_arith_logic),
    .b(cmp_res),
    .s(af[3])
);
assign ovfalu = (ovf & (~af[3]) & (~af[2]));

endmodule
