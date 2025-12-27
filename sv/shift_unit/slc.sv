module slc #(parameter N=32) (
    output logic [N-1:0] r,
    input logic [N-1:0] a,
    input logic [$clog2(N)-1:0] b
);

localparam int K = $clog2(N);
logic [N-1:0] shift_res [0:K-1];

bslc #(
    .N(N),
    .b(1)
) shift_0 (
    .z(shift_res[0]),
    .a(a),
    .s(b[0])
);

genvar i;
generate
    for(i=1; i<K; i++) begin
        bslc #(
            .N(N),
            .b(2**i)
        ) shift_i (
            .z(shift_res[i]),
            .a(shift_res[i-1]),
            .s(b[i])
        );
    end
endgenerate

assign r = shift_res[K-1];

endmodule