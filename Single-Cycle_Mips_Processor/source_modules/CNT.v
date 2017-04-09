//CNT


module CNT(
	input clk, CNT_EN, LD_CNT,
	input [3:0] n,
	output reg [31:0] N
	);

always@(posedge clk)begin
	if(LD_CNT)
	begin
		N<= n;
	end 
	else 
	begin
		if(CNT_EN)
		begin
			N<= N -1;
			// N= N-1;
		end 
		if(!CNT_EN) 
		begin
			N<= N;
		end
	end
end

endmodule


