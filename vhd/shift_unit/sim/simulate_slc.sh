ghdl -a --std=08 ../../basic_circuits/mux21.vhd
ghdl -a --std=08 ../../basic_circuits/nmux21.vhd
ghdl -a --std=08 ../bslc.vhd
ghdl -a --std=08 ../slc.vhd
ghdl -a --std=08 ../testbenches/tb_slc.vhd
ghdl -e --std=08 tb_slc
ghdl -r --std=08 tb_slc --vcd=slc.vcd