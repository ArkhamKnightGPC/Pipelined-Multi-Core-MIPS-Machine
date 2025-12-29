module su #(parameter N=32) (
    output logic [N-1:0] sures,
    input logic [N-1:0] a,
    input logic [$clog2(N)-1:0] b,
    input logic [1:0] sf
);

localparam K = $clog2(N);

logic [N-1:0] srlc_out;
srlc #(
    .N(N)
) logic_shifts (
    .r(srlc_out),
    .a(a),
    .b(b),
    .f(sf[1])
);

logic [N-1:0] sra_out;
assign sra_out = $signed(a) >>> b;

nmux21 #(
    .N(N)
) select_srlc_sra(
    .z(sures),
    .a(srlc_out),
    .b(sra_out),
    .s(sf[1]&sf[0])
);


endmodule
