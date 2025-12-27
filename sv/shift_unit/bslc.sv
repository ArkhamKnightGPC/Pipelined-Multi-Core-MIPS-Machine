module bslc #(
    parameter N=32,
    parameter b=1
    ) (
    output logic [N-1:0] z,
    input logic [N-1:0] a,
    input logic s
);

logic [N-1:0] with_shift;
logic [b-1: 0] a_suf;
logic [N-b-1:0] a_pref;
assign a_pref =  a[N-b-1:0];
assign a_suf = a[N-1:N-b];
assign with_shift = {a_pref, a_suf};

nmux21 #(.N(N)) g1 (
    .z(z),
    .a(a), // no shift
    .b(with_shift),
    .s(s)
);

endmodule
