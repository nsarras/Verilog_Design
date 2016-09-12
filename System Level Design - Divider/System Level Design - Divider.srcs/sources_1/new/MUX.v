`timescale 1ns / 1ps


module MUX(

input [3:0] D0,
input [3:0] D1,
input sel,
output reg [3:0] Y 
    );
always@ (sel)
begin    
    if (sel == 1'b0)
        begin 
        assign Y = D0;
        end
    else if (sel == 1'b1)
        begin
        assign Y = D1; 
        end    
    
end    
endmodule
