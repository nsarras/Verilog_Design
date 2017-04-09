//MUX

module MUX(
	input [31:0] a, b,
	input sel,
	output reg [31:0] x);

always @ (*) begin
	if(sel)begin
	 	x =b;
	 end else begin
	 	x= a;
	 end
end
endmodule