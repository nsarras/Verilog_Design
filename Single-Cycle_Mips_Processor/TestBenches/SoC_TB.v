//newmipstop tb
 
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/15/2016 08:06:24 PM
// Design Name:
// Module Name: newtb
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
 
 
module Soc_TB();
 
    reg clk, rst;
    reg [31:0] gpI1 = 5; //not too sure if this is how to hardwire. 
    reg [31:0] gpI2 = 5; //hardwire 
    wire [31:0] gpO1, gpO2;
 
  // instantiate device to be tested
  SoC dut(clk, rst, gpI1, gpI2, gpO1, gpO2);
 
   //initialize test
  initial
    begin
      rst <= 1; # 12; rst <= 0;
    end
 
  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
//      if(gpI1 >12 || gpI2 > 12 )begin
//        gpO1 [0] = 1; 
//      end else begin
//        gpO1 [0] = 0;
//      end
    end
 
  // check that 7 gets written to address 84
  always@(negedge clk)
    begin
        if(gpO2 == 120) begin
          $display("Simulation succeeded");
          $stop;
          end
    end
endmodule