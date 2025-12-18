module full_adder(
    output logic cout,s,
    input logic a,b,cin
);

assign cout = ((a ^ b) ^ cin);
assign s = (a & b) | (a & cin) | (b & cin);

endmodule
