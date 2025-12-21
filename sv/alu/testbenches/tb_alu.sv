module tb_alu;

parameter int N = 32;
logic [N-1:0] alures,a,b;
logic [3:0] af;
logic ovfalu, i;

alu #(.N(N)) dut(
    .alures(alures),
    .ovfalu(ovfalu),
    .a(a),
    .b(b),
    .af(af),
    .i(i)
);

initial begin
    a = 32'h11111111;
    b = 32'hEEEEEEEE;
    af = 4'b0001; //unsigned addition
    i = 1'b0;
    #1;
    $display("Unsigned ADD");
    $display("a=%h b=%h af=%b i=%b | alures=%h ovfalu=%b",
              a, b, af, i, alures, ovfalu);
    assert(alures == 32'hFFFFFFFF && ovfalu == 1'b0)
        else $fatal(1, "TEST 1 FAIL");

    af = 4'b0000; //signed addition
    #1;
    $display("Signed ADD");
    $display("a=%h b=%h af=%b i=%b | alures=%h ovfalu=%b",
              a, b, af, i, alures, ovfalu);
    assert(alures == 32'hFFFFFFFF && ovfalu == 1'b0)
        else $fatal(1, "TEST 2 FAIL");

    af = 4'b0010; //signed subtraction
    #1;
    $display("Signed SUB");
    $display("a=%h b=%h af=%b i=%b | alures=%h ovfalu=%b",
              a, b, af, i, alures, ovfalu);
    assert(alures == 32'h22222223 && ovfalu == 1'b0)
        else $fatal(1, "TEST 3 FAIL");

    af = 4'b0011; //unsigned subtraction
    #1;
    $display("Unsigned SUB");
    $display("a=%h b=%h af=%b i=%b | alures=%h ovfalu=%b",
              a, b, af, i, alures, ovfalu);
    assert(alures == 32'h22222223 && ovfalu == 1'b0)
        else $fatal(1, "TEST 4 FAIL");

    a = 32'hAAAA5555;
    b = 32'h99996666;
    af = 4'b0100;
    #1;
    $display("Logical AND");
    $display("a=%h b=%h af=%b i=%b | alures=%h ovfalu=%b",
              a, b, af, i, alures, ovfalu);
    assert(alures == 32'h88884444 && ovfalu == 1'b0)
        else $fatal(1, "TEST 5 FAIL");

    af = 4'b0101;
    #1;
    $display("Logical OR");
    $display("a=%h b=%h af=%b i=%b | alures=%h ovfalu=%b",
              a, b, af, i, alures, ovfalu);
    assert(alures == 32'hBBBB7777 && ovfalu == 1'b0)
        else $fatal(1, "TEST 6 FAIL");

    af = 4'b0110;
    #1;
    $display("Logical XOR");
    $display("a=%h b=%h af=%b i=%b | alures=%h ovfalu=%b",
              a, b, af, i, alures, ovfalu);
    assert(alures == 32'h33333333 && ovfalu == 1'b0)
        else $fatal(1, "TEST 7 FAIL");

    af = 4'b0111;
    #1;
    $display("Logical NOR");
    $display("a=%h b=%h af=%b i=%b | alures=%h ovfalu=%b",
              a, b, af, i, alures, ovfalu);
    assert(alures == 32'h44448888 && ovfalu == 1'b0)
        else $fatal(1, "TEST 8 FAIL");

    i = 1'b1;
    #1;
    $display("B LSBS");
    $display("a=%h b=%h af=%b i=%b | alures=%h ovfalu=%b",
              a, b, af, i, alures, ovfalu);
    assert(alures == 32'h66660000 && ovfalu == 1'b0)
        else $fatal(1, "TEST 9 FAIL");

    i = 1'b0;
    af = 4'b0000;
    a = 32'h7FFFFFFF;
    b = 32'h7FFFFFFF;
    #1;
    $display("TEST FOR OVERFLOW");
    $display("a=%h b=%h af=%b i=%b | alures=%h ovfalu=%b",
              a, b, af, i, alures, ovfalu);
    assert(alures == 32'hFFFFFFFE && ovfalu == 1'b1)
        else $fatal(1, "TEST 10 FAIL");


    $display("ALL TESTS PASSED");
    $finish;
end

endmodule
