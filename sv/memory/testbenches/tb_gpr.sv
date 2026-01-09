`timescale 1ns/1ps
module gpr_tb;

    parameter N = 32;
    parameter Nreg = 32;
    parameter K = $clog2(Nreg);

    logic [N-1:0] q_read_port1, q_read_port2, d;
    logic [K-1:0] read_port1_address, read_port2_address, write_port_address;
    logic clk, rst, wren;

    gpr #(.N(N), .Nreg(Nreg)) dut (
        .q_read_port1(q_read_port1),
        .q_read_port2(q_read_port2),
        .d(d),
        .read_port1_address(read_port1_address),
        .read_port2_address(read_port2_address),
        .write_port_address(write_port_address),
        .clk(clk),
        .rst(rst),
        .wren(wren)
    );

    always #5 clk = ~clk; //100MHz clock

    task write_reg(input [K-1:0] addr, input [N-1:0] data);
        begin
            @(negedge clk);
            write_port_address = addr;
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
        read_port1_address = 0;
        read_port2_address = 0;
        write_port_address = 0;
        d = 0;

        // reset
        repeat (2) @(posedge clk);
        rst = 0;
        $display("Reset released at %t", $time);

        // Test: write to multiple registers
        write_reg(5, 32'hDEADBEEF);
        write_reg(10, 32'hCAFEBABE);

        // read back and verify
        read_port1_address = 5;
        read_port2_address = 10;
        #1;
        $display("Reading Addr 5: Expected DEADBEEF, Got %H", q_read_port1);
        $display("Reading Addr 10: Expected CAFEBABE, Got %H", q_read_port2);
        if (q_read_port1 !== 32'hDEADBEEF | q_read_port2 !=32'hCAFEBABE) $fatal(1, "FAIL: Mismatch at Read");

        // Test 4: "No Write" (wren = 0)
        @(negedge clk);
        write_port_address = 5;
        d = 32'hAAAAAAAA;
        wren = 0;
        read_port1_address = 5;
        @(posedge clk);
        #1;
        $display("Reading Addr 5 after 'No Write': Expected DEADBEEF, Got %H", q_read_port1);
        if (q_read_port1 !== 32'hDEADBEEF) $fatal(1, "FAIL: Register updated while wren was low!");

        $display("ALL TESTS PASSED!");
        $finish;
    end

endmodule