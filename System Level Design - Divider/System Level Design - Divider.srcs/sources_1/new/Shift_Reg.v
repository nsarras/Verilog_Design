`timescale 1ns / 1ps



module Shift_Reg(
    input [3:0] D,
    input clk,
    input RST,
    input SR,
    input SL,
    input LD,
    input LeftIn,
    input RightIn,
    output reg [3:0] Q
    );

always @(posedge clk) 
	begin
		if(RST) 
		begin
			Q <= 0;
		end 
		
		else if(LD) 
		begin
			Q <= D;
		end 
		
		else if(SL) 
		begin 
			Q <= {Q[2:0], RightIn};
		end 
		
		else if(SR) 
		begin 
		    Q <= {LeftIn, Q[3:1]};
		end 
		
		else 
		begin
			Q[3:0] <= D[3:0];
		end
	end
endmodule
