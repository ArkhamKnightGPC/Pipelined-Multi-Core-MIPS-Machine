module half_adder(
    output logic s,cout,
    input logic a,b
);

assign s = (a ^ b);
assign cout = (a & b);

endmodule
