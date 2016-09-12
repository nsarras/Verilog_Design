`timescale 1ns / 1ps



module shifter_behav(
    input [3:0] in,
    output reg [3:0] out,
    input [2:0] ctrl,
    input reset,
    input clk);
 
    
    
always@(posedge clk, posedge reset)
begin 
    if(reset)
    begin
    out = 4'b0;
    end
    else
    begin
    case (ctrl)
    
    3'b000: out = in;
    3'b001: out = in >> 1;
    3'b010: out = in >> 2;
    3'b011: out = in >> 3;
    3'b100: out = in >> 4;
    3'b101: 
    begin 
    out [2:0] = in[3:1];
    out = in [0];
    
    end
    3'b110: 
    begin 
    out [3:2] = in[1:0];
    out [1:0] = in[3:2];
   
    end
    3'b111:
    begin
    out [0] = in [3];
    out [3:1] = in [2:0];
 
    end
    
    endcase
    end

end
endmodule
