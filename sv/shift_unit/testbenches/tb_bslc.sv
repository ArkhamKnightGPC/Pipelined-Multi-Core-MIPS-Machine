`timescale 1ns/1ps
module tb_bslc;

    parameter int N = 32;
    logic [N-1:0] a;
    logic s;

    genvar i;
    logic [N-1:0] z [1:N-1]; //we generate bslc for each value of b
    generate
        for (i = 1; i < N; i++) begin : GEN_BSLC
            bslc #(
                .N(N),
                .b(i)
            ) dut (
                .a(a),
                .s(s),
                .z(z[i])
            );
        end
    endgenerate

    function automatic logic [N-1:0] golden(
        input logic [N-1:0] a,
        input int b,
        input logic s
    );
        if (!s)
            golden = a;
        else
            golden = (a << b) | (a >> (N - b));
    endfunction


    initial begin
        s = 0;
        a = 32'h00000000;
        #1;
        for (int b = 1; b < N; b++) begin
            assert (z[b] == golden(a, b, s))
                else $error("FAIL: s=0 b=%0d a=%b z=%b", b, a, z[b]);
        end

        repeat(5) begin
            a = $random;
            s = 1;
            #1;
            for (int b = 1; b < N; b++) begin
                assert (z[b] == golden(a, b, s))
                    else $error("FAIL: s=1 b=%0d a=%b z=%b exp=%b",
                                b, a, z[b], golden(a, b, s));
            end
        end

        $display("ALL TESTS PASSED");
        $finish;
    end

endmodule
