`timescale 1ns/1ps
module gpr_tb;

    parameter N = 32;
    parameter Nreg = 32;
    parameter K = $clog2(Nreg);

    logic [N-1:0] q, d;
    logic [K-1:0] address;
    logic clk, rst, wren;

    gpr #(.N(N), .Nreg(Nreg)) dut (
        .q(q),
        .d(d),
        .address(address),
        .clk(clk),
        .rst(rst),
        .wren(wren)
    );

    always #5 clk = ~clk; //100MHz clock

    task write_reg(input [K-1:0] addr, input [N-1:0] data);
        begin
            @(negedge clk);
            address = addr;
            d = data;
            wren = 1;
            @(posedge clk);
            #1;
            wren = 0;
        end
    endtask

    initial begin
        clk = 0;
        rst = 1;
        wren = 0;
        address = 0;
        d = 0;

        // Test 1: reset
        repeat (2) @(posedge clk);
        rst = 0;
        $display("Reset released at %t", $time);

        // Test 2: write to multiple registers
        write_reg(5, 32'hDEADBEEF);
        write_reg(10, 32'hCAFEBABE);
        write_reg(31, 32'h12345678);

        // Test 3: read back and verify
        address = 5;
        #1;
        $display("Reading Addr 5: Expected DEADBEEF, Got %H", q);
        if (q !== 32'hDEADBEEF) $fatal(1, "FAIL: Mismatch at Addr 5");

        address = 10;
        #1;
        $display("Reading Addr 10: Expected CAFEBABE, Got %H", q);
        if (q !== 32'hCAFEBABE) $fatal(1, "FAIL: Mismatch at Addr 10");

        // Test 4: "No Write" (wren = 0)
        @(negedge clk);
        address = 5;
        d = 32'hAAAAAAAA;
        wren = 0;
        @(posedge clk);
        #1;
        $display("Reading Addr 5 after 'No Write': Expected DEADBEEF, Got %H", q);
        if (q !== 32'hDEADBEEF) $fatal(1, "FAIL: Register updated while wren was low!");

        $display("ALL TESTS PASSED!");
        $finish;
    end

endmodule