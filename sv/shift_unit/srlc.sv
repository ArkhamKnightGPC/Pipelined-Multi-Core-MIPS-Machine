module srlc #(parameter N=32) (
    output logic [N-1:0] r,
    input logic [N-1:0] a,
    input logic[$clog2(N)-1:0] b,
    input logic f
);

localparam K = $clog2(N);
logic [K-1:0] not_b, neg_b, shift_dist;
assign not_b = ~b;

nincrementer #(
    .N(K)
) convert_to_neg (
    .s(neg_b),
    .cout(),
    .a(not_b),
    .cin('1)
);

nmux21 #(
    .N(K)
) select_b(
    .z(shift_dist),
    .a(b),
    .b(neg_b),
    .s(f)
);

slc #(
    .N(N)
) perform_shift (
    .r(r),
    .a(a),
    .b(shift_dist)
);

endmodule