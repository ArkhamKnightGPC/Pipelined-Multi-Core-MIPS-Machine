module equality_check #(parameter N = 32)(
    output logic eq, neq,
    input logic[N-1:0] a,b
);

logic[N-1:0] tmp;
assign tmp = (a ^ b);
zero_check #(
    .N(N)
)check_xor(
    .a(tmp),
    .zero(eq),
    .nzero(neq)
);

endmodule