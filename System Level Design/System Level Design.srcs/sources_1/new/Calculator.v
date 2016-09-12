`timescale 1ns / 1ps

module Calculator(input CLK,
                  input clk100MHz,
                  input RST,
                  input GO,
                  input [1:0] OPC,
                  input [2:0] in1,
                  input [2:0] in2,
                  output [2:0] out,
                  output [3:0] CS,
                  output DONE);
                  
                

wire we;
wire rea;
wire reb;
wire s2;
wire [1:0] s1;
wire [1:0] wa;
wire [1:0] raa;
wire [1:0] rab;
wire [1:0] c;

CU U0(.CLK(CLK),
      .RST(RST),
      .GO(GO),
      .OPC(OPC),
      .CS(CS),
      .S1(s1),
      .WA(wa),
      .WE(we),
      .RAA(raa),
      .REA(rea),
      .RAB(rab),
      .REB(reb),
      .C(c),
      .S2(s2),
      .DONE(DONE));
      
DP U1(.clk(CLK),
      .in1(in1),
      .in2(in2),
      .s1(s1),
      .wa(wa),
      .we(we),
      .raa(raa),
      .rea(rea),
      .rab(rab),
      .reb(reb),
      .c(c),
      .s2(s2));


endmodule





