ghdl -a --std=08 ../../basic_circuits/mux21.vhd
ghdl -a --std=08 ../../basic_circuits/nmux21.vhd
ghdl -a --std=08 ../logical_unit.vhd
ghdl -a --std=08 ../testbenches/tb_logical_unit.vhd
ghdl -e --std=08 tb_logical_unit
ghdl -r --std=08 tb_logical_unit --vcd=logical_unit.vcd