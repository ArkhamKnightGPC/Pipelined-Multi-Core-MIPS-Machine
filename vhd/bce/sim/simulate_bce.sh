ghdl -a --std=08 ../../basic_circuits/zero_check.vhd
ghdl -a --std=08 ../../basic_circuits/equality_check.vhd
ghdl -a --std=08 ../bce.vhd
ghdl -a --std=08 ../testbenches/tb_bce.vhd
ghdl -e --std=08 tb_bce
ghdl -r --std=08 tb_bce --vcd=bce.vcd