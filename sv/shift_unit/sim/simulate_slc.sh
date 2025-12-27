iverilog -g2012 \
  ../../basic_circuits/mux21.sv \
  ../../basic_circuits/nmux21.sv \
  ../bslc.sv \
  ../slc.sv \
  ../testbenches/tb_slc.sv \
  -o tb_slc.out

vvp tb_slc.out
