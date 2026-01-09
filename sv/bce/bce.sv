module bce #(parameter N=32) (
    output logic bcres,
    input logic [N-1:0] a,b,
    input logic [3:0] bf
);

logic [N-1:0] b_or_zero;
logic eq,neq,a_lt_zero,a_lte_zero;

assign a_lt_zero = a[N-1];
assign a_lte_zero = (eq | a_lt_zero);
assign b_or_zero = b & (bf[3] & (~bf[2]));
equality_check #(.N(N)) compare_ab (
    .eq(eq),
    .neq(neq),
    .a(a),
    .b(b_or_zero)
);

assign bcres = (~bf[3] & ~bf[2] & bf[1] & ~bf[0] & a_lt_zero) | (~bf[3] & ~bf[2] & bf[1] & bf[0] & ~a_lt_zero)
    | (bf[3] & ~bf[2] & ~bf[1] & eq) | (bf[3] & ~bf[2] & bf[1] & neq) | (bf[3] & bf[2] & ~bf[1] & a_lte_zero) | (bf[3] & bf[2] & bf[1] & ~a_lte_zero);

endmodule