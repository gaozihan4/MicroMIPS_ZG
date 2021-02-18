// Testbench of openmips min sopc
`timescale 1ns/100ps
`include "defines.v"
module openmips_min_sopc_tb();

reg CLOCK_50;
reg rst;

initial begin
  CLOCK_50 = 1'b0;
  forever #10 CLOCK_50 = ~CLOCK_50;
end

initial begin
  rst = `RstEnable;
  #105 rst = `RstDisable;
  #4100 $stop;
end

openmips_min_sopc openmips_min_sopc0(
.clk(CLOCK_50),
.rst(rst)
);

endmodule