`timescale 1ns/1ps
module tb_srlc;

parameter int N = 32;
parameter int K = $clog2(N);
logic [N-1:0] r,a;
logic [K-1:0] b;
logic f;

srlc #(
    .N(N)
) dut (
    .r(r),
    .a(a),
    .b(b),
    .f(f)
);

initial begin
    a = 32'h00000001;
    b = 5'b00001;
    f = '0;
    #1;
    $display("a=%h | b=%b | f=%b | r=%h", a, b, f, r);
    assert(r == 32'h00000002)
        else $fatal(1, "TEST 1 FAIL");
    f = '1;
    #1;
    $display("a=%h | b=%b | f=%b | r=%h", a, b, f, r);
    assert(r == 32'h80000000)
        else $fatal(1, "TEST 2 FAIL");
    a = 32'h01010101;
    b = 5'b11111;
    f = '0;
    #1;
    $display("a=%h | b=%b | f=%b | r=%h", a, b, f, r);
    assert(r == 32'h80808080)
        else $fatal(1, "TEST 3 FAIL");
    f = '1;
    #1;
    $display("a=%h | b=%b | f=%b | r=%h", a, b, f, r);
    assert(r == 32'h02020202)
        else $fatal(1, "TEST 4 FAIL");

    $display("ALL TESTS PASSED");
    $finish;
end;


endmodule
