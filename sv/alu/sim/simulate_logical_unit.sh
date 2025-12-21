iverilog -g2012 \
  ../../basic_circuits/mux21.sv \
  ../../basic_circuits/nmux21.sv \
  ../logical_unit.sv \
  ../testbenches/tb_logical_unit.sv \
  -o tb_logical_unit.out

vvp tb_logical_unit.out
