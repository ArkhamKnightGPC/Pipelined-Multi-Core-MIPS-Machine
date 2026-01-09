iverilog -g2012 \
  ../register.sv \
  ../gpr.sv \
  ../testbenches/tb_gpr.sv \
  -o tb_gpr.out

vvp tb_gpr.out
