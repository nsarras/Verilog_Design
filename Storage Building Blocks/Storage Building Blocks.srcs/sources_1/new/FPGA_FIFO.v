`timescale 1ns / 1ps

module FPGA_FIFO(
input btn,
input clk100MHz,
input rst,
input WNR,
input enable,
input [3:0] D_in,
output [3:0] D_out,
output full,
output empty);



wire clk;
wire pb_clk;
wire dont_use;

clk_gen U1(
.clk_5KHz(clk),
.clk100MHz(clk100MHz),
.rst(reset),
.clk_4sec(dont_use)
);

debounce U2(
.clk(clk),
.pb(btn),
.pb_debounced(pb_clk)
);    
  
FIFO U3(
.clk(pb_clk),
.rst(rst),
.WNR(WNR),
.enable(enable),
.D_in(D_in),
.D_out(D_out),
.full(full),
.empty(empty)
);  
  
    
endmodule

