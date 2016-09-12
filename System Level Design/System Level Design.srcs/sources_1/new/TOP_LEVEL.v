`timescale 1ns / 1ps



module TOP_LEVEL(
    input btn,
    input clk_btn,
    input rst,
    input clk100MHz,
    output [7:0] LEDOUT,
    output [7:0] LEDSEL,
    input GO,
    input [1:0] OPC,
    input [2:0] in1,
    input [2:0] in2,
    output [2:0] out,
    output [3:0] CS,
    output DONE
    );
    
wire clk;
wire pb_clk;
wire dont_use;    
    


supply1[7:0] vcc;
wire s0, s1, s2, s3, s4, s5, s6, s7;
wire r0, r1, r2, r3, r4, r5, r6, r7;
assign s7 = 1'b1;
assign r7 = 1'b1;    
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

Calculator U3(
.CLK(pb_clk),
.CS(CS),
.out(out),   
.RST(rst),
.GO(GO),
.OPC(OPC),
.in1(in1),
.in2(in2),
.DONE(DONE)
    );
    
bcd_to_7seg U4(

.BCD(CS),
.s0(s0),
.s1(s1),
.s2(s2),
.s3(s3),
.s4(s4),
.s5(s5),
.s6(s6)

);   

bcd_to_7seg2 U5(

.BCD(out),
.s0(r0),
.s1(r1),
.s2(r2),
.s3(r3),
.s4(r4),
.s5(r5),
.s6(r6)
);

LED_MUX U6(
.clk(clk),
.rst(rst),
.LED0({s7, s6, s5, s4, s3, s2, s1, s0}),
.LED1(vcc),
.LED2(vcc),
.LED3(vcc),
.LED4(vcc),
.LED5(vcc),
.LED6(vcc),
.LED7({r7, r6, r5, r4, r3, r2, r1, r0}),
.LEDOUT(LEDOUT),
.LEDSEL(LEDSEL)
);
    
endmodule

//`timescale 1ns / 1ps

//module FPGA_FIFO(
//input btn,
//input clk100MHz,
//input rst,
//input WNR,
//input enable,
//input [3:0] D_in,
//output [3:0] D_out,
//output full,
//output empty);



//wire clk;
//wire pb_clk;
//wire dont_use;

//clk_gen U1(
//.clk_5KHz(clk),
//.clk100MHz(clk100MHz),
//.rst(reset),
//.clk_4sec(dont_use)
//);

//debounce U2(
//.clk(clk),
//.pb(btn),
//.pb_debounced(pb_clk)
//);    
  
//FIFO U3(
//.clk(pb_clk),
//.rst(rst),
//.WNR(WNR),
//.enable(enable),
//.D_in(D_in),
//.D_out(D_out),
//.full(full),
//.empty(empty)
//);  
  
    
//endmodule


