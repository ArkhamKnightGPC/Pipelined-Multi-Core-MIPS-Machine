`timescale 1ns/1ps

module two_port_ram_tb;

    parameter address_length = 4;
    parameter word_length = 64;

    logic [word_length-1:0] q_a, q_b;
    logic [address_length-1:0] address_a, address_b;
    logic [word_length-1:0] data_a, data_b;
    logic wren_a, wren_b, clk;

    two_port_ram #(
        .address_length(address_length),
        .word_length(word_length)
    ) dut (
        .q_a(q_a),
        .q_b(q_b),
        .address_a(address_a),
        .address_b(address_b),
        .data_a(data_a),
        .data_b(data_b),
        .wren_a(wren_a),
        .wren_b(wren_b),
        .clk(clk)
    );

    initial clk = 0;
    always #5 clk = ~clk;// 100MHz clock

    initial begin
        wren_a = 0; wren_b = 0;
        address_a = 4'h0; address_b = 4'h0;
        data_a = 64'h0000000000000000;
        data_b = 64'h0000000000000000;
        repeat(2) @(posedge clk);

        // TEST 0: Verify Hex Initialization (Address 0)
        address_a = 4'h0;
        @(posedge clk);
        assert (q_a == 64'hFEEDFACECAFEBABE)
            else $fatal(1, "HEX INIT FAILED: Expected FEED...BABE, got %H", q_a);

        // TEST 1 & 2: Write and Read back
        $display("Running Write/Read Tests...");
        wren_a = 1; address_a = 4'hA; data_a = 64'hAAAAAAAAAAAAAAAA;
        @(posedge clk);
        wren_a = 0; address_a = 4'hA;
        @(posedge clk);
        assert (q_a === 64'hAAAAAAAAAAAAAAAA)
            else $fatal(1, "ASSERTION FAILED at addr 0xA: Expected AAAA..., got %H", q_a);

        // TEST 3: Simultaneous Write
        $display("Running Simultaneous Write Test...");
        wren_a = 1; address_a = 4'h1; data_a = 64'h1111111111111111;
        wren_b = 1; address_b = 4'h2; data_b = 64'h2222222222222222;
        @(posedge clk);
        wren_a = 0; wren_b = 0;

        // Verify Port B Write
        address_b = 4'h2;
        @(posedge clk);
        assert (q_b === 64'h2222222222222222)
            else $fatal(1, "SIMULTANEOUS WRITE FAILED: Port B mismatch!");

        $display("ALL TESTS PASSED");
        $finish;
    end

endmodule