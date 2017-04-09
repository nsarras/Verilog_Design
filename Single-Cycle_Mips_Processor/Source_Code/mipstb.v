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


module newtb();

  reg         clk;
  reg         reset;

  wire [31:0] writedata, dataadr;
  wire memwrite;
  reg [4:0] dispSel;
  wire [31:0] dispDat;

  // instantiate device to be tested
  TestTop dut(clk, reset, writedata, dataadr, memwrite, dispSel, dispDat);
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
      assign dispSel = 5'b10000;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check that 7 gets written to address 84
  always@(negedge clk)
    begin
        if(dispDat == 24) begin
          $display("Simulation succeeded");
          $stop;
          end
    end
endmodule
