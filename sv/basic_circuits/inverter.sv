module inverter #(parameter N = 32)(
    output logic[N-1:0] z,
    input logic[N-1:0] a
);

assign z = ~a;

endmodule
