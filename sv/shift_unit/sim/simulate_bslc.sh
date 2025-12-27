iverilog -g2012 \
  ../../basic_circuits/mux21.sv \
  ../../basic_circuits/nmux21.sv \
  ../bslc.sv \
  ../testbenches/tb_bslc.sv \
  -o tb_bslc.out

vvp tb_bslc.out
