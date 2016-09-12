`timescale 1ns / 1ps

module UP_DOWN_Counter(
               input CLK,
               input RST,
               input [2:0] D,
               input LD,
               input UD,
               input CE,
               output reg [2:0] Q);

always @(posedge CLK, posedge RST) 
begin
		if(RST) Q = 3'b000;
		 
		else if(CE) 
		begin
			if(LD) Q = D;
			 
			else if(UD) Q = Q + 3'b001;
		end 
		
		else 
		begin
			Q = Q - 3'b001;
		end

end
endmodule