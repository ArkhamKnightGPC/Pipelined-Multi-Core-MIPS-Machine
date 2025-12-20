module nincrementer #(parameter N=32) (
    output logic [N-1:0] s,
    output logic cout,
    input logic [N-1:0] a,
    input logic cin
);

nadder #(
    .N(N)
) add_inc (
    .a(a),
    .b('0),
    .cin(cin),
    .s(s),
    .cout(cout)
);

endmodule