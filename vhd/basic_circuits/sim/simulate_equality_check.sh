ghdl -a --std=08 ../zero_check.vhd
ghdl -a --std=08 ../equality_check.vhd
ghdl -a --std=08 ../testbenches/tb_equality_check.vhd
ghdl -e --std=08 tb_equality_check
ghdl -r --std=08 tb_equality_check --vcd=equality_check.vcd