module tb_nmux21;

parameter int N = 32;
logic [N-1:0] a, b, z;
logic s;

nmux21 #(
  .N(N)
) dut (
  .a(a),
  .b(b),
  .s(s),
  .z(z)
);

initial begin
  a = 32'hAAAAAAAA;
  b = 32'hBBBBBBBB;
  s = 1'b0;

  #1;
  if (z == a)
      $display("TEST s=0 PASS");
  else
      $fatal(1, "TEST s=0 FAIL");

  s = 1'b1;
  #1;
  if (z == b)
      $display("TEST s=1 PASS");
  else
      $fatal(1, "TEST s=1 FAIL");

  $finish;
end

endmodule
