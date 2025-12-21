iverilog -g2012 \
  ../../basic_circuits/mux21.sv \
  ../../basic_circuits/nmux21.sv \
  ../../basic_circuits/full_adder.sv \
  ../nadder.sv \
  ../au.sv \
  ../logical_unit.sv \
  ../alu.sv \
  ../testbenches/tb_alu.sv \
  -o tb_alu.out

vvp tb_alu.out
