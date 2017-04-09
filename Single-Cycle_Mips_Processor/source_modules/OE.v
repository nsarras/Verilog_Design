//OE

module OE(
	input [31:0] a, 
	input en,
	output reg [31:0] b
	);


	always@ (*)begin
		if(en)begin
			b=a;
		end else begin
			b= 32'bz;
		end
	end

endmodule