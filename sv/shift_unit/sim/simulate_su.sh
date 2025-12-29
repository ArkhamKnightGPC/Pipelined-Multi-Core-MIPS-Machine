iverilog -g2012 \
  ../../basic_circuits/mux21.sv \
  ../../basic_circuits/nmux21.sv \
  ../../basic_circuits/full_adder.sv \
  ../../alu/nadder.sv \
  ../../alu/nincrementer.sv \
  ../bslc.sv \
  ../slc.sv \
  ../srlc.sv \
  ../su.sv \
  ../testbenches/tb_su.sv \
  -o tb_su.out

vvp tb_su.out
