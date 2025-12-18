module mux21(
    output logic z,
    input logic a,b,s
);

assign z = (a & ~s) | (b & s);

endmodule
