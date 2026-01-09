`timescale 1ns/1ps
module tb_nadder;

parameter int N = 32;
logic [N-1:0] a,b,s;
logic cin,cout;

nadder #(
    .N(N)
) dut (
    .a(a),
    .b(b),
    .cin(cin),
    .s(s),
    .cout(cout)
);

initial begin
    a = 32'h11111111;
    b = 32'hEEEEEEEE;
    cin = 1'b0;
    #1;
    assert (s == 32'hFFFFFFFF && cout == 1'b0)
        else $fatal(1, "TEST 1 FAIL");

    cin = 1'b1;
    #1;
    assert (s == 32'h00000000 && cout == 1'b1)
        else $fatal(1, "TEST 2 FAIL");

    $display("ALL TESTS PASSED");
    $finish;
end


endmodule