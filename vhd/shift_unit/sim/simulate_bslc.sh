ghdl -a --std=08 ../../basic_circuits/mux21.vhd
ghdl -a --std=08 ../../basic_circuits/nmux21.vhd
ghdl -a --std=08 ../bslc.vhd
ghdl -a --std=08 ../testbenches/tb_bslc.vhd
ghdl -e --std=08 tb_bslc
ghdl -r --std=08 tb_bslc --vcd=bslc.vcd