`timescale 1ns/1ns
module tb_slc;

parameter int N = 32;
parameter int K = $clog2(N);
logic [N-1:0] a,r;
logic [K-1:0] b;

slc #(
    .N(N)
) dut (
    .r(r),
    .a(a),
    .b(b)
);

initial begin
    a = 32'h00000001;

    b = 5'b00001;
    #1;
    $display("a=%h | b=%b | r=%h", a, b, r);
    assert(r == 32'h00000002)
        else $fatal(1, "TEST 1 FAIL");

    b = 5'b00011;
    #1;
    $display("a=%h | b=%b | r=%h", a, b, r);
    assert(r == 32'h00000008)
        else $fatal(1, "TEST 2 FAIL");

    b = 5'b00111;
    #1;
    $display("a=%h | b=%b | r=%h", a, b, r);
    assert(r == 32'h00000080)
        else $fatal(1, "TEST 3 FAIL");

    b = 5'b01111;
    #1;
    $display("a=%h | b=%b | r=%h", a, b, r);
    assert(r == 32'h00008000)
        else $fatal(1, "TEST 4 FAIL");

    b = 5'b11111;
    #1;
    $display("a=%h | b=%b | r=%h", a, b, r);
    assert(r == 32'h80000000)
        else $fatal(1, "TEST 5 FAIL");

    $display("ALL TESTS PASSED");
    $finish;
end

endmodule