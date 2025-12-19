module zero_check #(parameter N = 32)(
    output logic zero, nzero,
    input logic [N-1:0] a
);

assign nzero = |a;
assign zero = ~nzero;

endmodule