module au #(parameter N=32) (
    output logic [N-1:0] s,
    output logic ovf, neg,
    input logic [N-1:0] a,b,
    input logic u, sub
);

logic [N-1:0] b_checked;
logic cout;

assign b_checked = (b ^ {N{sub}});
nadder #(
    .N(N)
) add_sub (
    .a(a),
    .b(b_checked),
    .cin(sub),
    .s(s),
    .cout(cout)
);
assign neg = (~u & (a[N-1] ^ b_checked[N-1] ^ cout)) | (u & sub & ~cout);
assign ovf = (~u & ((s[N-1] ^ a[N-1]) & ~(a[N-1] ^ b[N-1])));

endmodule
