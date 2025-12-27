iverilog -g2012 \
  ../../basic_circuits/mux21.sv \
  ../../basic_circuits/nmux21.sv \
  ../../basic_circuits/full_adder.sv \
  ../../alu/nadder.sv \
  ../../alu/nincrementer.sv \
  ../bslc.sv \
  ../slc.sv \
  ../srlc.sv \
  ../testbenches/tb_srlc.sv \
  -o tb_srlc.out

vvp tb_srlc.out
