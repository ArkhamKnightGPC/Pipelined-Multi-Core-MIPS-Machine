iverilog -g2012 \
  ../../basic_circuits/full_adder.sv \
  ../nadder.sv \
  ../au.sv \
  ../testbenches/tb_au.sv \
  -o tb_au.out

vvp tb_au.out
