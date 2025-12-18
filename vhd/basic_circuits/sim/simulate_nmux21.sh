ghdl -a --std=08 ../mux21.vhd
ghdl -a --std=08 ../nmux21.vhd
ghdl -a --std=08 ../testbenches/tb_nmux21.vhd
ghdl -e --std=08 tb_nmux21
ghdl -r --std=08 tb_nmux21 --vcd=nmux21.vcd