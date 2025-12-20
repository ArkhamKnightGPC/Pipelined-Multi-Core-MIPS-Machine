ghdl -a --std=08 ../../basic_circuits/full_adder.vhd
ghdl -a --std=08 ../nadder.vhd
ghdl -a --std=08 ../au.vhd
ghdl -a --std=08 ../testbenches/tb_au.vhd
ghdl -e --std=08 tb_au
ghdl -r --std=08 tb_au --vcd=au.vcd