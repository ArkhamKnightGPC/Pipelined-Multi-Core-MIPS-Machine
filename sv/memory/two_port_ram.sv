module two_port_ram #(parameter address_length=32, parameter word_length=64) (
    output logic [word_length-1:0] q_a, q_b,
    input logic [address_length-1:0] address_a, address_b,
    input logic [word_length-1:0] data_a, data_b,
    input logic wren_a, wren_b, clk
);

localparam num_words = 2**address_length;
logic [word_length-1:0] mem [0:num_words-1];

initial begin
    $readmemh("two_port_ram_init.hex", mem);
end

always_ff @(posedge clk) begin
    if (wren_a)
    begin
        mem[address_a] <= data_a;
        q_a <= data_a;
    end else
    begin
        q_a <= mem[address_a];
    end

    if (wren_b)
    begin
        mem[address_b] <= data_b;
        q_b <= data_b;
    end else
    begin
        q_b <= mem[address_b];
    end
end

endmodule
