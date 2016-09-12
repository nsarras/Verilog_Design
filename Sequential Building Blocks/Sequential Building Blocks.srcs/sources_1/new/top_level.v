`timescale 1ns / 1ps


module top_level(
 input btn,
 input [3:0] in,
 input [2:0] ctrl,
 input clk100MHz,
 input reset,
 output [3:0] out);
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

shifter_behav U3(
.in(in),
.ctrl(ctrl),
.reset(reset),
.out(out),
.clk(pb_clk)
);




endmodule