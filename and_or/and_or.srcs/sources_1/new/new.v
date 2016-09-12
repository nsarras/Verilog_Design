`timescale 1ns / 1ps
module my_and2(in, out); // an AND gate
input[1:0] in;
output out;
assign out = in[1] & in [0];
endmodule
module my_or2(in, out); // an OR gate
input [1:0] in;
output out;
assign out = in[1] | in[0];
endmodule
module and_or(in_top, out_top); //top-level AND/OR logic
input [3:0] in_top;
output out_top;
wire [1:0] sig;
my_and2 U1(.in(in_top[3:2]), .out(sig[1]));
my_and2 U2(.in(in_top[1:0]), .out(sig[0]));
my_or2 U3(.in(sig), .out(out_top));
endmodule
