`timescale 1ns/1ps
module tb_logical_unit;

parameter int N = 32;
logic [N-1:0] res,a,b;
logic [1:0] af;
logic i;

logical_unit #(.N(N)) dut (
    .res(res),
    .a(a),
    .b(b),
    .af(af),
    .i(i)
);

initial begin
    a = 32'hAAAA5555;
    b = 32'h99996666;
    af = 2'b00;
    i = 1'b0;
    #1;
    $display("Logical AND");
    $display("a=%h b=%h af=%b i=%b | res=%h",
              a, b, af, i, res);
    assert(res == 32'h88884444)
        else $fatal(1, "TEST 1 FAIL");

    af = 2'b01;
    #1;
    $display("Logical OR");
    $display("a=%h b=%h af=%b i=%b | res=%h",
              a, b, af, i, res);
    assert(res == 32'hBBBB7777)
        else $fatal(1, "TEST 2 FAIL");

    af = 2'b10;
    #1;
    $display("Logical XOR");
    $display("a=%h b=%h af=%b i=%b | res=%h",
              a, b, af, i, res);
    assert(res == 32'h33333333)
        else $fatal(1, "TEST 3 FAIL");

    af = 2'b11;
    #1;
    $display("Logical NOR");
    $display("a=%h b=%h af=%b i=%b | res=%h",
              a, b, af, i, res);
    assert(res == 32'h44448888)
        else $fatal(1, "TEST 4 FAIL");

    i = 1'b1;
    #1;
    $display("B LSBS");
    $display("a=%h b=%h af=%b i=%b | res=%h",
              a, b, af, i, res);
    assert(res == 32'h66660000)
        else $fatal(1, "TEST 5 FAIL");

    $display("ALL TESTS PASSED");
    $finish;
end

endmodule
