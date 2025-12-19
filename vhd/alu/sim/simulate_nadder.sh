ghdl -a --std=08 ../../basic_circuits/full_adder.vhd
ghdl -a --std=08 ../nadder.vhd
ghdl -a --std=08 ../testbenches/tb_nadder.vhd
ghdl -e --std=08 tb_nadder
ghdl -r --std=08 tb_nadder --vcd=nadder.vcd