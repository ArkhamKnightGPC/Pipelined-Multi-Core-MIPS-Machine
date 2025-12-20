`timescale 1ns/1ns
module tb_au;

parameter int N = 32;
logic [N-1:0] s,a,b;
logic ovf, neg, u, sub;

au #(.N(N)) dut(
    .s(s),
    .ovf(ovf),
    .neg(neg),
    .a(a),
    .b(b),
    .u(u),
    .sub(sub)
);

initial begin
    a = 32'h11111111;
    b = 32'hEEEEEEEE;
    u = 1'b1; //unsigned
    sub = 1'b0; //addition
    #1;
    $display("Unsigned ADD");
    $display("a=%h b=%h u=%b sub=%b | s=%h ovf=%b neg=%b",
              a, b, u, sub, s, ovf, neg);
    assert(s == 32'hFFFFFFFF && ovf == 1'b0 && neg == 1'b0)
        else $fatal(1, "TEST 1 FAIL");

    u = 1'b0; //signed addition
    #1;
    $display("Signed ADD");
    $display("a=%h b=%h u=%b sub=%b | s=%h ovf=%b neg=%b",
              a, b, u, sub, s, ovf, neg);
    assert(s == 32'hFFFFFFFF && ovf == 1'b0 && neg == 1'b1)
        else $fatal(1, "TEST 2 FAIL");

    sub = 1'b1; //signed subtraction
    #1;
    $display("Signed SUB");
    $display("a=%h b=%h u=%b sub=%b | s=%h ovf=%b neg=%b",
              a, b, u, sub, s, ovf, neg);
    assert(s == 32'h22222223 && ovf == 1'b0 && neg == 1'b0)
        else $fatal(1, "TEST 3 FAIL");

    u = 1'b1; //unsigned subtraction
    #1;
    $display("Unsigned SUB");
    $display("a=%h b=%h u=%b sub=%b | s=%h ovf=%b neg=%b",
              a, b, u, sub, s, ovf, neg);
    assert(s == 32'h22222223 && ovf == 1'b0 && neg == 1'b1)
        else $fatal(1, "TEST 4 FAIL");

    $display("ALL TESTS PASSED");
    $finish;
end

endmodule