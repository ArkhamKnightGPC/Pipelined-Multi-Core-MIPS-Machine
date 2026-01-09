iverilog -g2012 \
  ../two_port_ram.sv \
  ../testbenches/tb_two_port_ram.sv \
  -o tb_two_port_ram.out

vvp tb_two_port_ram.out
