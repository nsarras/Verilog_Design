`timescale 1ns / 1ps

module Calculator(

      input GO,
	  input [3:0] X, // Dividended
	  input [3:0] Y, // Divisor
      input rst,
      input CLK,
      output wire DONE,
      output wire Err,
      output wire [3:0] Q,
      output wire [3:0] R,
      output wire [2:0] debugcs
    );
    
wire R_lt_Y;

    
wire MUX1;
wire MUX2;
wire MUX3;
		  
wire LD_R;
wire SL_R;
wire SR_R;
wire LI_R;
wire RI_R;
		  
wire LD_X;
wire SL_X;
wire LI_X;
wire SR_X;
wire RI_X;
		  
wire LD_Y;
wire SL_Y;
wire SR_Y;
wire LI_Y;
wire RI_Y;    

wire [3:0] Input1;
wire [3:0] Zeroed_Input1;

wire [3:0] Input2;
wire [3:0] Zeroed_Input2;

wire [3:0] Input3;
wire [3:0] Zeroed_Input3;  

//Up Down Counter Signals
wire UD_RST;
wire [2:0] D;
wire LD;
wire UD;
wire CE;
wire [2:0] cnt_Q; // Output of up down counter


CU UU2 (           // Control Unit Module
   .CLK(CLK),
    .RST(rst),
// Control Unit Variables     
    .GO(GO),
    //Inputs * Need to be extracted from Data Path *
    .R_lt_Y(R_It_Y),
    
    //--------------------
    .zero(zero),
    // Outputs
    .MUX1(MUX1),
    .MUX2(MUX2),
    .MUX3(MUX3),
    
    .LD_R(LD_R),
    .SL_R(SL_R),
    .SR_R(SR_R),
    .LI_R(LI_R),
    .RI_R(RI_R),
    
    .LD_X(LD_X),
    .SL_X(SL_X),
    .LI_X(LI_X),
    .SR_X(SR_X),
    .RI_X(RI_X),
    
    .LD_Y(LD_Y),
    .SL_Y(SL_Y),
    .SR_Y(SR_Y),
    .LI_Y(LI_Y),
    .RI_Y(RI_Y),
    //UP DOWN COUNTER CONTROL SIGNALS
    . UD_RST(UD_RST),
    .cnt_in(D),
    .cnt_load(LD),
    .cnt_enable(CE),
    .UD(UD),
    .cnt_out(cnt_Q),
    //.cnt_flag(cnt_flag),
    .DONE(DONE),
    .ERR(Err),
    .debugcs(debugcs) 
);        
    
    
    
TOP_LEVEL UU1 (    // Data Path Module
   
    .R(R),    // Remainder
    .X(X),    // Dividend
    .Y(Y),    // Divisor
    
    .clk(CLK),
    // X Shift Register Control Signals
    .x_RST(rst),
    .x_SR(SR_X),
    .x_SL(SL_X),
    .x_LD(LD_X),
    .x_LeftIn(LI_X),
    .x_RightIn(RI_X),   
    
    // Y Shift Register Control Signals   
    .y_RST(rst),
    .y_SR(SR_Y),
    .y_SL(SL_Y),
    .y_LD(LD_Y),
    .y_LeftIn(LI_Y),
    .y_RightIn(RI_Y),  
    
    // R Shift Register Control Signals
    .R_RST(rst),
    .R_SR(SR_R),
    .R_SL(SL_R),
    .R_LD(LD_R),
    .R_LeftIn(LI_R),
    .R_RightIn(RI_R),  
    
    // Mux 1 Controls Signals    
    .Input1(Input1),
    .Zeroed_Input1(4'b0000),
    .Sel1(MUX1),
    
    // Mux 2 Controls Signals    
    .Input2(Input2),
    .Zeroed_Input2(4'b0000),
    .Sel2(MUX2),    
    
    // Mux 3
    .Input3(Input3),
    .Zeroed_Input3(4'b0000),
    .Sel3(MUX3), 
    
    // Comparator
        .R_It_Y(R_It_Y),     
    
    // Up Down Counter
    .D(D),
    .LD(LD),
    .UD(UD),
    .CE(CE),
   // .cnt_flag(cnt_flag),
    .Q(cnt_Q),    
    
    // Final Output    
    .remainder(R),
    .quotient(Q)
);
    
endmodule
