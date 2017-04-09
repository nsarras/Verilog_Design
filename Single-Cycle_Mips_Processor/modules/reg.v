//reg
module REG(
	input [31:0] d,
	input clk, LD_REG,
	output reg [31:0] q
	);
always @ ( posedge clk) begin
	if(LD_REG)begin
		q<= d; //set the output with the input
	end else begin
		q<= q;
	end

end


endmodule