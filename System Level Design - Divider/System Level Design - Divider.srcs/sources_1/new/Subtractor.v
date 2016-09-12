`timescale 1ns / 1ps


module Subtractor(

input [3:0] A,
input [3:0] B,
output reg [3:0] C
    );

always@ (A,B) 
begin    
    assign C = A - B;        
end    
endmodule
