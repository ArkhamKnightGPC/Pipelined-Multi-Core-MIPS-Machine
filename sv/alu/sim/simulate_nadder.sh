iverilog -g2012 \
  ../../basic_circuits/full_adder.sv \
  ../nadder.sv \
  ../testbenches/tb_nadder.sv \
  -o tb_nadder.out

vvp tb_nadder.out
