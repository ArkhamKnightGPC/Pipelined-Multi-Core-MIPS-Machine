module nmux21 #(parameter N = 32)(
    output logic [N-1:0] z,
    input logic [N-1:0] a,b,
    input logic s
);

genvar i;

generate
  for (i = 0; i < N; i++) begin
    mux21 mux_i(
      .a(a[i]),
      .b(b[i]),
      .s(s),
      .z(z[i])
    );
  end
endgenerate

endmodule
