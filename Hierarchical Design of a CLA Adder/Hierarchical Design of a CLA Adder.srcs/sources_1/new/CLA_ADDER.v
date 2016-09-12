`timescale 1ns / 1ps



module CLA_ADDER(  // Half Adder
    input co,
    input [3:0] a,
    input [3:0] b,
    output [3:0] p,
    output [3:0] g);

    

//always @(a,b,co);
begin

assign p[0]= a[0] ^ b[0];
assign p[1]= a[1] ^ b[1];
assign p[2]= a[2] ^ b[2];
assign p[3]= a[3] ^ b[3];

assign g[0]= a[0] * b[0];
assign g[1]= a[1] * b[1];
assign g[2]= a[2] * b[2];
assign g[3]= a[3] * b[3];




end
endmodule
