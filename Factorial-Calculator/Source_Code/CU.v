`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2016 05:32:05 PM
// Design Name: 
// Module Name: CU
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


module CU(
    input clk,
    input rst, 
    input GO,
    input n_cmp_1,
    output reg SEL,
    output reg CNT_EN,
    output reg LD_CNT,
    output reg LD_REG,
    output reg DONE,
    output wire [3:0] debugcs
    );
    
reg [3:0] CS;
reg [3:0] NS;

assign debugcs = CS;

always@(CS, GO, n_cmp_1)
begin
    case(CS)
        3'b000: NS = ((GO) ? 3'b001 : 3'b000);
        3'b001: NS = 3'b010;
        3'b010: NS = ((n_cmp_1) ? 3'b011 : 3'b100);
        3'b011: NS = 3'b010; 
        3'b100: NS = 3'b000;
    endcase
end

always @(posedge clk, posedge rst)
begin 
    CS = NS;
    if (rst)
    begin
    CS = 3'b000;
    end
end


always@(CS)
begin
    case(CS)
        3'b000: begin
                DONE = 1'b0;
                end
        3'b001: begin
                SEL = 1'b0;
                CNT_EN = 1'b0;
                LD_CNT = 1'b1;
                LD_REG = 1'b1;
                DONE = 1'b0;
                end
        3'b010: begin
                CNT_EN = 1'b0;
                LD_CNT = 1'b0;
                LD_REG = 1'b0;
                DONE = 1'b0;
                end
        3'b011: begin
                SEL = 1'b1;
                CNT_EN = 1'b1;
                LD_CNT = 1'b0;
                LD_REG = 1'b1;
                DONE = 1'b0;
                end
        3'b100: begin
                LD_CNT = 1'b0;
                LD_REG = 1'b0;
                DONE = 1'b1;
                end          
    endcase
 end
endmodule
