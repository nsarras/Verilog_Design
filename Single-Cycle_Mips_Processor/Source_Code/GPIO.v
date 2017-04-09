`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2016 06:49:59 PM
// Design Name: 
// Module Name: GPIO
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


module GPIO(
    input clk, rst, WE,
    input [31:0] gpI1, gpI2, WD,
    input [1:0] A,
    output [31:0] Rd, gpO1, gpO2
    );
    wire WE2, WE1;
    wire [1:0] RdSel;
    wire [31:0] O1, O2;
    assign O1 = gpO1;
    assign O2 = gpO2; //these are just incase verilog complains about the mux.
gpioAddrDec adrDec(A, WE, WE2, WE1, RdSel);
register reg1(clk,  WE1, rst, WD, gpO1);
register reg2(clk, WE2, rst, WD, gpO2);
Mux4 mx4(gpI1, gpI2, O1, O2, RdSel, Rd);
endmodule
 
 
module gpioAddrDec(
    input [1:0] A,
    input WE,
    output WE2, WE1,
    output [1:0] RdSel
    );
    reg [3:0] signals;
    assign {WE2, WE1, RdSel} = signals;
   
    always @(*)begin
        case(A)
            2'b00:  signals <= 4'b0000; //rd from in1
            2'b01:  signals <= 4'b0001; //rd from in2
            2'b10:begin
                if(WE)begin
                    signals <= 4'b0110; //write on O1 & outputs it
                end
                else begin
                    signals <= 4'b0010; //chooses o1. no write
                end
            end
            2'b11:begin
                if(WE)begin    
                    signals <= 4'b1011; //writes o2 & outputs it
                end
                else begin
                    signals <= 4'b0011; //outputs o2 no write
                end
            end
            default: signals <= 4'b0000;
        endcase
    end
 
 
endmodule
 
 
module register(
    input clk, En, rst,
    input [31:0] dIn,
    output reg [31:0] dout
    );
    reg [31:0] hold;
 
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
 
module Mux4(
    input [31:0] gpI1, gpI2, gpO1, gpO2,
    input [1:0] sel,
    output reg [31:0] Rd
    );
   
    always @ (*)begin
        case(sel)
        2'b00:  Rd = gpI1;
        2'b01:   Rd = gpI2;
        2'b10:   Rd = gpO1;
        2'b11:   Rd = gpO2;
        default:  Rd = gpI1; //result case i'll just link it to input 1.       
        endcase
    end
 
endmodule