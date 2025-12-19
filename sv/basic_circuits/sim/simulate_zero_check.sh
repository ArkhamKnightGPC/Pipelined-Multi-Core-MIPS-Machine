iverilog -g2012 \
  ../zero_check.sv \
  ../testbenches/tb_zero_check.sv \
  -o tb_zero_check.out

vvp tb_zero_check.out
