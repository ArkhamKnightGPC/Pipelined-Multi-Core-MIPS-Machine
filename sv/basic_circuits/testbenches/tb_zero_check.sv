`timescale 1ns/1ns
module tb_zero_check;

localparam int N = 32;
logic [N-1:0] a = '0;
logic zero;
logic nzero;

zero_check #(
    .N(N)
) dut (
    .a(a),
    .zero(zero),
    .nzero(nzero)
);

initial begin
    for (int i = 0; i < N; i++) begin
        a[i] = 1'b1;
        #1;
        assert (zero == 1'b0 && nzero == 1'b1)
            else $fatal(1, "TEST %0d FAIL", 2*i+1);

        a[i] = 1'b0;
        #1;
        assert (zero == 1'b1 && nzero == 1'b0)
            else $fatal(1, "TEST %0d FAIL", 2*i+2);
    end
    $display("ALL TESTS PASSED");
    $finish;
end

endmodule
