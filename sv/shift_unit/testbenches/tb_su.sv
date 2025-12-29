`timescale 1ns/1ps
module tb_su;

parameter int N = 32;
parameter int K = $clog2(N);
logic [N-1:0] sures, a;
logic [K-1:0] b;
logic [1:0] sf;

su #(.N(N)) dut (
    .sures(sures),
    .a(a),
    .b(b),
    .sf(sf)
);

initial begin
    a = 32'h01010101;
    b = 5'b00111;
    sf = 2'b00;
    #1;
    $display("sll a=%h b=%b | sures=%h", a, b, sures);
    assert(sures == 32'h80808080)
        else $fatal(1, "TEST 1 FAIL");
    sf = 2'b10;
    #1;
    $display("srl a=%h b=%b | sures=%h", a, b, sures);
    assert(sures == 32'h02020202)
        else $fatal(1, "TEST 2 FAIL");
    sf = 2'b11;
    #1;
    $display("sra a=%h b=%b | sures=%h", a, b, sures);
    assert(sures == 32'h00020202)
        else $fatal(1, "TEST 3 FAIL");
    $display("ALL TESTS PASSED");
    $finish;
end
endmodule
