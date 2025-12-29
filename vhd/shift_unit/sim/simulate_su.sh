ghdl -a --std=08 ../../basic_circuits/mux21.vhd
ghdl -a --std=08 ../../basic_circuits/nmux21.vhd
ghdl -a --std=08 ../../basic_circuits/full_adder.vhd
ghdl -a --std=08 ../../alu/nadder.vhd
ghdl -a --std=08 ../../alu/nincrementer.vhd
ghdl -a --std=08 ../bslc.vhd
ghdl -a --std=08 ../slc.vhd
ghdl -a --std=08 ../srlc.vhd
ghdl -a --std=08 ../su.vhd
ghdl -a --std=08 ../testbenches/tb_su.vhd
ghdl -e --std=08 tb_su
ghdl -r --std=08 tb_su --vcd=su.vcd