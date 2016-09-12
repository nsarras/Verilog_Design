`timescale 1ns / 1ps

module TOP_LEVEL(

   
    input [3:0] Y,    // Divisor
    input [3:0] R,    // Remainder
    input [3:0] X,    // Dividend


    input clk,
// X Shift Register Control Signals
    input x_RST,
    input x_SR,
    input x_SL,
    input x_LD,
    input x_LeftIn,
    input x_RightIn,   

// Y Shift Register Control Signals   
    input y_RST,
    input y_SR,
    input y_SL,
    input y_LD,
    input y_LeftIn,
    input y_RightIn,  
  
// R Shift Register Control Signals
    input R_RST,
    input R_SR,
    input R_SL,
    input R_LD,
    input R_LeftIn,
    input R_RightIn,  
    
// Mux 1 Controls Signals    
    output wire [3:0] Input1,
    input [3:0] Zeroed_Input1,
    input Sel1,

// Mux 2 Controls Signals    
    output wire [3:0] Input2,
    input [3:0] Zeroed_Input2,
    input Sel2,    

// Mux 3
   output wire [3:0] Input3,
   input [3:0] Zeroed_Input3,
   input Sel3, 
   
// Comparator
    output R_It_Y,           
    
// Up Down Counter
    input UD_RST,
    input [2:0] D,
    input LD,
    input UD,
    input CE,
  //  output cnt_flag,
    output [2:0] Q,    
    
// Final Output    
    output [3:0] remainder,
    output [3:0] quotient
  
    );
    
wire [3:0] x_out;  
wire [3:0] y_out;  
wire [3:0] R_out;
wire [3:0] Mux1_out;

reg R_in;
    
Shift_Reg XUUT(
    .D(X),
    .clk(clk),
    .RST(x_RST),
    .SR(x_SR),
    .SL(x_SL),
    .LD(x_LD),
    .LeftIn(x_LeftIn),
    .RightIn(x_RightIn),
    .Q(Input3)
);
Shift_Reg YUUT(
    .D(Y),
    .clk(clk),
    .RST(y_RST),
    .SR(y_SR),
    .SL(y_SL),
    .LD(y_LD),
    .LeftIn(y_LeftIn),
    .RightIn(y_RightIn),
    .Q(y_out)
);
Shift_Reg RUUT(
        .D(Mux1_out), 
        .clk(clk),
        .RST(R_RST),
        .SR(R_SR),
        .SL(R_SL),
        .LD(R_LD),
        .LeftIn(R_LeftIn),
        .RightIn(X[3]), // Leftmost of X is RightIn of R
        .Q(R_out)
);    
   
MUX UU1(
    .D0(4'b0000),
    .D1(Input1),
    .sel(Sel1),
    .Y(Mux1_out) 
);

MUX UU2(
    .D0(4'b0000),
    .D1(R_out),
    .sel(Sel2),
    .Y(remainder) 
);

MUX UU3(
    .D0(4'b0000),
    .D1(Input3),
    .sel(Sel3),
    .Y(quotient) 
);

Comparator UU4(
    .A(R_out),
    .B(y_out),
    .t(R_It_Y)
);   

Subtractor UU5(
    .A(R_out),
    .B(y_out),
    .C(Input1)    
);    
    
UP_DOWN_Counter UU6(
    .CLK(clk),
    .RST(UD_RST),
    .D(D),
    .LD(LD),
    .UD(UD),
    .CE(CE),
    .Q(Q)  
);    
    
endmodule
