`timescale 1ns / 1ps


module CLA(
    output [4:0] C
    );
 reg [3:0] a;
 reg [3:0] p;
 reg [3:0] g;
 reg [3:0] b;
 reg co;   
 CLA_ADDER DUT (
       .co(co),   
       .a(a),
       .b(b),
       .p(p),
       .g(g));
    
  //  always @(p,g,a);
    begin

    
    
 assign   C[0] = co;   
 assign   C[1] = g[0] | (p[0] & C[0]);
 assign   C[2] = g[1] | (p[1] & (g[0] | (p[0]&C[0])));
 assign   C[3] = g[2] | (p[2] &(g[1] | (p[1] &C[1])));
 assign   C[4] = g[3] | (p[3] &(g[2] | (p[2] &C[2])));    
//    C1 = G0 | (P0 & C0);
//    C[count]= g[count] + (p[count]*co);
    
    
    end
endmodule
