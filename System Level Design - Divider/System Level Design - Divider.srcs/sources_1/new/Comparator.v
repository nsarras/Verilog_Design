`timescale 1ns / 1ps

module Comparator(
    input [3:0] A,
    input [3:0] B,
    output reg t
    );
    
always@ (A,B)    
begin
    
     if (A < B)
         begin
         t=1'b1;
         end   
     else
         begin
         t=1'b0;
         end 
       
end    
endmodule
