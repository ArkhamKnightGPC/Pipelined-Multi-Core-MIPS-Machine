ghdl -a --std=08 ../../basic_circuits/full_adder.vhd
ghdl -a --std=08 ../../basic_circuits/mux21.vhd
ghdl -a --std=08 ../../basic_circuits/nmux21.vhd
ghdl -a --std=08 ../nadder.vhd
ghdl -a --std=08 ../au.vhd
ghdl -a --std=08 ../logical_unit.vhd
ghdl -a --std=08 ../alu.vhd
ghdl -a --std=08 ../testbenches/tb_alu.vhd
ghdl -e --std=08 tb_alu
ghdl -r --std=08 tb_alu --vcd=alu.vcd