`timescale 1ns/1ns
module tb_bce;

parameter int N = 32;
logic bcres;
logic [N-1:0] a,b;
logic [3:0] bf;

bce #(.N(N)) dut (
    .bcres(bcres),
    .a(a),
    .b(b),
    .bf(bf)
);

function automatic logic golden(
    input logic [N-1:0] a,b,
    input logic [3:0] bf
);
    if(bf == 4'b0010)
        golden = a[N-1];
    else if(bf == 4'b0011)
        golden = ~a[N-1];
    else if(bf == 4'b1000 | bf == 4'b1001)
        golden = (a==b);
    else if (bf == 4'b1010 | bf == 4'b1011)
        golden = ~(a==b);
    else if(bf == 4'b1100 | bf == 4'b1101)
        golden = a[N-1] | (a == '0);
    else if(bf == 4'b1110 | bf == 4'b1111)
        golden = ~a[N-1] & ~(a == '0);
    else
        golden = 1'b0;
endfunction

initial begin
    bf = 4'b0000;
    a = 32'h00000000;
    b = 32'h00000000;
    #1;
    repeat(20) begin
        a = $random;
        b = $random;
        bf = $random;
        #1;
        assert(golden(a,b,bf) == bcres)
            else $fatal(1, "FAIL a=%h b=%h bf=%b | bcres=%b golden=%b", a, b, bf, bcres, golden(a,b,bf));
    end
    $display("ALL TESTS PASSED");
    $finish;
end

endmodule
