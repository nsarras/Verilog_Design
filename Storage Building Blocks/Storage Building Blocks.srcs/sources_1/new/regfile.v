`timescale 1ns / 1ps


module regfile(
 input clk,                  // Clock
 input we1,we2,              // Write enabled control signals
 input [4:0] ra1, ra2, ra3,  // Read address ports 
 input [31:0] wd1,wd2,       // Write data ports
 input [4:0] wa1,wa2,       // Write address for data port
 output [31:0] rd1, rd2, rd3); // Read data ports
    
  
reg [31:0] RF[31:0];    
    
always @(posedge clk)    

begin
    if(we1) RF[wa1] <= wd1;
    if(we2) RF[wa2] <= wd2;
end

    assign rd1 = (ra1 != 0) ? RF[ra1] : 0;
    assign rd2 = (ra2 != 0) ? RF[ra2] : 0;
    
    
    
endmodule
