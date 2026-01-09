# Memory models

*Note:* the RAM memory model presented here is for simulation purposes only. For synthesis on FPGA, please use the vendor appropriate primitives.

## Two-port RAM (two_port_ram.sv)

- Port **a** is used exclusively for instruction fetch (instruction port) and port **b** is used exclusively for load/store operations (data port).

- A .hex file for initialization is provided for running the simulation script (*/sim/two_port_ram_init.hex*).