ghdl -a --std=08 ../zero_check.vhd
ghdl -a --std=08 ../testbenches/tb_zero_check.vhd
ghdl -e --std=08 tb_zero_check
ghdl -r --std=08 tb_zero_check --vcd=zero_check.vcd