module register #(parameter N=32) (
    output logic [N-1:0] q,
    input logic [N-1:0] d,
    input logic clk, rst, wren
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        q <= '0;
    end else if (wren) begin
        q <= d;
    end else begin
        q <= q;
    end
end

endmodule
