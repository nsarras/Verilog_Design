`timescale 1ns / 1ps

module factorial_calc(
    input clk,
    input GO,
    input rst,
    input [3:0] n,
    output wire DONE,
    output wire [31:0] OUTPUT,
    output wire [3:0] debugcs
    

    );


wire SEL;
wire CNT_EN;
wire LD_CNT;
wire LD_REG;
wire compare;

dp d1(
    .n(n),
    .clk(clk),
    .out(OUTPUT),
    .Done(DONE),
    
    .SEL(SEL),
    .CNT_EN(CNT_EN),
    .LD_CNT(LD_CNT),
    .LD_REG(LD_REG),
    .OE_EN(DONE),
    
    .compare(compare)
    
);  

CU c1(
    .rst(rst),
    .clk(clk),
    .GO(GO),
    .n_cmp_1(compare),
    .SEL(SEL),
    .CNT_EN(CNT_EN),
    .LD_CNT(LD_CNT),
    .LD_REG(LD_REG),
    .DONE(DONE),
    .debugcs(debugcs)
    
);
 
    
    
endmodule
