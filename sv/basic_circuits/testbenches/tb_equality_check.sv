`timescale 1ns/1ns
module tb_equality_check;

localparam int N = 32;
logic[N-1:0] a = '0;
logic[N-1:0] b = '0;
logic zero;
logic nzero;

equality_check #(
    .N(N)
) dut (
    .a(a),
    .b(b),
    .eq(eq),
    .neq(neq)
);

initial begin
    for (int i = 0; i < N; i++) begin
        a[i] = 1'b1;
        b[i] = 1'b1;
        #1;
        assert (eq == 1'b1 && neq == 1'b0)
            else $fatal(1, "TEST %0d FAIL", 3*i+1);

        b[i] = 1'b0;
        #1;
        assert (eq == 1'b0 && neq == 1'b1)
            else $fatal(1, "TEST %0d FAIL", 3*i+2);

        a[i] = 1'b0;
        #1;
        assert (eq == 1'b1 && neq == 1'b0)
            else $fatal(1, "TEST %0d FAIL", 3*i+3);
    end
    $display("ALL TESTS PASSED");
    $finish;
end

endmodule
