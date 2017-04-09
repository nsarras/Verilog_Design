`timescale 1ns / 1ps

module FPGA_factorial_calc(
   input clk100MHz,
   input pb,
   input rst,    
  
   output wire [7:0] LEDSEL,
   output wire [7:0] LEDOUT,
  
    input GO,
    input [3:0] n,
    output wire DONE
 );
 
 wire pb_debounced;
 wire clk_5KHz;
 wire NOT_USED;
 
 wire [3:0] dig0;
 wire [3:0] dig1;
 wire [3:0] dig2;
 wire [3:0] dig3;
 wire [3:0] dig4;
 wire [3:0] dig5;
 wire [3:0] dig6;
 wire [3:0] dig7;
 
 wire a0, a1, a2, a3, a4, a5, a6;
 wire b0, b1, b2, b3, b4, b5, b6;
 wire c0, c1, c2, c3, c4, c5, c6;
 wire d0, d1, d2, d3, d4, d5, d6;
 wire e0, e1, e2, e3, e4, e5, e6;
 wire f0, f1, f2, f3, f4, f5, f6;
 wire g0, g1, g2, g3, g4, g5, g6;
 wire h0, h1, h2, h3, h4, h5, h6;
 
 wire [31:0] OUTPUT;
 wire [3:0] debugcs;
 
factorial_calc f1( 
    .clk(pb_debounced),
    .GO(GO),
    .rst(rst),
    .n(n),
    .DONE(DONE),
    .OUTPUT(OUTPUT),
    .debugcs(debugcs)
    );
    
clk_gen cuu1(
    .clk100MHz(clk100MHz), 
    .rst(rst), 
    .clk_4sec(NOT_USED), 
    .clk_5KHz(clk_5KHz)
    );

debounce duu1(
        .pb_debounced(pb_debounced), 
        .pb(pb), 
        .clk(clk_5KHz)
        );    
    
bin2bcd32 buu1(
         .value(OUTPUT),
         .dig0(dig0),
         .dig1(dig1),
         .dig2(dig2),
         .dig3(dig3),
         .dig4(dig4),
         .dig5(dig5),
         .dig6(dig6),
         .dig7(dig7)
         );   
         
        bcd_to_7seg DUT1(
                .BCD(dig0), 
                .s0(a0), 
                .s1(a1), 
                .s2(a2), 
                .s3(a3), 
                .s4(a4), 
                .s5(a5), 
                .s6(a6)
                );   
        bcd_to_7seg DUT2(
                .BCD(dig1), 
                .s0(b0), 
                .s1(b1), 
                .s2(b2), 
                .s3(b3), 
                .s4(b4), 
                .s5(b5), 
                .s6(b6)
                );   
        
        bcd_to_7seg DUT3(
                .BCD(dig2), 
                .s0(c0), 
                .s1(c1), 
                .s2(c2), 
                .s3(c3), 
                .s4(c4), 
                .s5(c5), 
                .s6(c6));   
        
        bcd_to_7seg DUT4(
                .BCD(dig3), 
                .s0(d0), 
                .s1(d1), 
                .s2(d2), 
                .s3(d3), 
                .s4(d4), 
                .s5(d5), 
                .s6(d6));   
                
        bcd_to_7seg DUT5(
                .BCD(dig4), 
                .s0(e0), 
                .s1(e1), 
                .s2(e2), 
                .s3(e3), 
                .s4(e4), 
                .s5(e5), 
                .s6(e6));    
        
        bcd_to_7seg DUT6(
                .BCD(dig5), 
                .s0(f0), 
                .s1(f1), 
                .s2(f2), 
                .s3(f3), 
                .s4(f4), 
                .s5(f5), 
                .s6(f6));   
                
        bcd_to_7seg DUT7(
                .BCD(dig6), 
                .s0(g0), 
                .s1(g1), 
                .s2(g2), 
                .s3(g3), 
                .s4(g4), 
                .s5(g5), 
                .s6(g6));   
                        
        bcd_to_7seg DUT8(
                .BCD(dig7), 
                .s0(h0), 
                .s1(h1), 
                .s2(h2), 
                .s3(h3), 
                .s4(h4), 
                .s5(h5), 
                .s6(h6));   
     
                        
led_mux MUXDUT(
        .clk(clk_5KHz),
        .rst(rst),
        .LED0({1'b0,h6,h5,h4,h3,h2,h1,h0}), // leftmost digit
        .LED1({1'b0,g6,g5,g4,g3,g2,g1,g0}),
        .LED2({1'b0,f6,f5,f4,f3,f2,f1,f0}),
        .LED3({1'b0,e6,e5,e4,e3,e2,e1,e0}),
        .LED4({1'b0,d6,d5,d4,d3,d2,d1,d0}),
        .LED5({1'b0,c6,c5,c4,c3,c2,c1,c0}),
        .LED6({1'b0,b6,b5,b4,b3,b2,b1,b0}),
        .LED7({1'b0,a6,a5,a4,a3,a2,a1,a0}), // rightmost digit
        .LEDSEL(LEDOUT),
        .LEDOUT(LEDSEL)
        );                        
                        
endmodule
