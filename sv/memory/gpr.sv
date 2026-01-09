module gpr #(
    parameter N=32,
    parameter Nreg=32,
    parameter K=$clog2(Nreg)
) (
    output logic [N-1:0] q_read_port1, q_read_port2,
    input logic [N-1:0] d,
    input logic [K-1:0] read_port1_address, read_port2_address, write_port_address,
    input logic clk, rst, wren
);

logic [Nreg-1:0] wren_gpr;
logic [N-1:0] q_gpr [Nreg-1:0];
assign q_gpr[0] = '0; //hardwire register 0 to 0 value
genvar i;
generate
    for(i=1; i<Nreg; i=i+1) begin
        assign wren_gpr[i] = wren & (write_port_address == i);
        register #(.N(N)) reg_i (
            .clk(clk),
            .rst(rst),
            .wren(wren_gpr[i]),
            .d(d),
            .q(q_gpr[i])
        );
    end
endgenerate

assign q_read_port1 = q_gpr[read_port1_address];
assign q_read_port2 = q_gpr[read_port2_address];

endmodule
