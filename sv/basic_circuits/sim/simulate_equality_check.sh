iverilog -g2012 \
  ../zero_check.sv \
  ../equality_check.sv \
  ../testbenches/tb_equality_check.sv \
  -o tb_equality_check.out

vvp tb_equality_check.out
