//MUL

module MUL(
	input [31:0] x, y,
	output reg [31:0] z
	);

always @ (*)begin
	z= x*y;
end

endmodule