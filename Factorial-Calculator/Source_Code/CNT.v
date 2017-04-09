`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2016 06:26:00 PM
// Design Name: 
// Module Name: CNT
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


module CNT(
    input clk,
    input CNT_EN,
    input LD_CNT,
    input [3:0] n,
    input [3:0] temp,
    output reg [3:0] cnt_out
    );
    
always @(posedge clk, CNT_EN, LD_CNT)
begin
    
    if(LD_CNT)
        begin
        temp = n;
        end    
    else
        begin

        if (CNT_EN) 
            begin
            cnt_out = temp - 3'b001;
            end
        else
            begin
            cnt_out = temp;
            end
        
        end
        
        
end

endmodule
