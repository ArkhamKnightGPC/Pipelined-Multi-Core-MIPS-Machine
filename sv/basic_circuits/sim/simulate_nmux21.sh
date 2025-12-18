iverilog -g2012 \
  ../mux21.sv \
  ../nmux21.sv \
  ../testbenches/tb_nmux21.sv \
  -o tb_nmux21.out

vvp tb_nmux21.out
