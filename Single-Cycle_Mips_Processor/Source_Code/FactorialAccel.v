`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2016 06:57:00 PM
// Design Name: 
// Module Name: FactorialAccel
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// Nadim's Modules
// factorial accelarator

module Factorialaccel(

            input clk, reset,
            input [1:0] Addr,
            input we,
            input [3:0] WriteData,
            output [31:0] ReadData
                        );
wire [3:0] debugcs;
wire WE2, WE1;
wire [1:0] RdSel;
wire [3:0] dataout; 
wire controlout;
wire [31:0] input0, input1, input2;
wire GoPulseComb;
wire GoPulse;


//Output from Factorial Calc
wire DONE;
wire [31:0] OUTPUT;
wire Err; 
assign Err = 0;
//Output from JK FlipFlops
wire ResDone;
wire ResErr;

//Output from Result Register
wire [31:0] Result;

assign input0 = {28'b0000000000000000000000000000, dataout};
assign input1 = {31'b0000000000000000000000000000000, controlout};
assign input2 = {30'b000000000000000000000000000000, ResErr, ResDone};



FactAddrDecoder factdec(.A(Addr), .WE(we), .WE2(WE2), .WE1(WE1), .RdSel(RdSel));
factreg DataInput(.clk(clk), .En(WE1), .rst(reset), .dIn(WriteData), .dout(dataout));         
controlreg ControlInput(.clk(clk), .En(WE2), .rst(reset), .dIn(WriteData[0]), .dout(controlout));  
andgate andgo(.a(WE2), .b(WriteData[0]), .y(GoPulseComb));
flipflop Go(.clk(clk), .reset(reset), .d(GoPulseComb), .q(GoPulse));   
factorial_calc Calc(
    .clk(clk),
    .GO(GoPulse),
    .rst(reset),
    .n(dataout),
    .DONE(DONE),
    .OUTPUT(OUTPUT),
    .debugcs(debugcs));

jkflipflop ControlOutput(.clk(clk), .S(DONE), .R(GoPulseComb), .Q(ResDone));
jkflipflop DataOutput(.clk(clk), .S(Err), .R(GoPulseComb), .Q(ResErr));

register rgresult(.clk(clk), .En(DONE), .rst(reset), .dIn(OUTPUT), .dout(Result));         
Mux4 mxout(.gpI1(input0), .gpI2(input1), .gpO1(input2), .gpO2(Result), .sel(RdSel), .Rd(ReadData));

              


endmodule

module FactAddrDecoder(
    input [1:0] A,
    input WE,
    output WE2, WE1,
    output [1:0] RdSel
    );
    reg [3:0] signals;
    assign {WE2, WE1, RdSel} = signals; 
 
    always @(*)begin
        case(A)
            2'b00:  signals <= 4'b0100; //data input
            2'b01:  signals <= 4'b1001; //control input
            2'b10:begin
                if(WE)begin
                    signals <= 4'b1010; //writes to accelerator & outputs control
                end
                else begin
                    signals <= 4'b0010; //chooses port 10. no write
                end
            end
            2'b11:begin
                if(WE)begin    
                    signals <= 4'b1011; //writes to accelerator & outputs data
                end
                else begin
                    signals <= 4'b0011; //outputs port 11. no write
                end
            end
            default: signals <= 4'b0000;
        endcase
    end
     
        
endmodule

module flipflop(
    input        clk, reset,
    input        d,
    output reg   q);
 
    always @(posedge clk, posedge reset)
        if (reset) q <= 0;
        else       q <= d;
endmodule


module jkflipflop(
    input clk,
    input S,
    input R,
    output reg Q
            );
            
    always @(posedge clk)
        if ((S) && (R == 0)) Q <= 1;
        else if ((R) && (S==0)) Q <= 0;
        else if ((S) && (R)) Q <= ~Q;
        else Q <= Q;
endmodule

module factreg(
    input clk, En, rst,
    input [3:0] dIn,
    output reg [3:0] dout
    );
    reg [3:0] hold;
 
    always @ (posedge clk, posedge rst)begin
        if(rst)begin
             hold <= 0;
        end
        else begin
            if(En)begin
                hold <= dIn;
            end
        end
         dout = hold;
    end
 
endmodule



module controlreg(
    input clk, En, rst,
    input  dIn,
    output reg dout
    );
    reg hold;
    
    always @ (posedge clk, posedge rst)begin
            if(rst)begin
                 hold <= 0;
            end
            else begin
                if(En)begin
                    hold <= dIn;
                end
            end
             dout = hold;
        end

endmodule

