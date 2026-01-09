iverilog -g2012 \
  ../../basic_circuits/zero_check.sv \
  ../../basic_circuits/equality_check.sv \
  ../bce.sv \
  ../testbenches/tb_bce.sv \
  -o tb_bce.out

vvp tb_bce.out
