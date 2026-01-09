module gpr #(
    parameter N=32,
    parameter Nreg=32,
    parameter K=$clog2(Nreg)
) (
    output logic [N-1:0] q,
    input logic [N-1:0] d,
    input logic [K-1:0] address,
    input logic clk, rst, wren
);

logic [Nreg-1:0] wren_gpr;
logic [N-1:0] q_gpr [Nreg-1:0];

genvar i;
generate
    for(i=0; i<Nreg; i=i+1) begin
        assign wren_gpr[i] = wren & (address == i);
        register #(.N(N)) reg_i (
            .clk(clk),
            .rst(rst),
            .wren(wren_gpr[i]),
            .d(d),
            .q(q_gpr[i])
        );
    end
endgenerate

assign q = q_gpr[address];

endmodule
