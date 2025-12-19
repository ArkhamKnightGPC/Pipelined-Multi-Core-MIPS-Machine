module nadder #(parameter N = 32)(
    output logic [N-1:0] s,
    output logic cout,
    input logic [N-1:0] a,b,
    input logic cin
);

logic [N-1:0] carry_internal;
full_adder base_case(
    .a(a[0]),
    .b(b[0]),
    .cin(cin),
    .s(s[0]),
    .cout(carry_internal[0])
);
genvar i;

generate
    for (i = 1; i < N; i++) begin
        full_adder inductive_step(
            .a(a[i]),
            .b(b[i]),
            .cin(carry_internal[i-1]),
            .s(s[i]),
            .cout(carry_internal[i])
        );
    end
endgenerate

assign cout = carry_internal[N-1];

endmodule