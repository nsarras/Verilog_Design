module Inf_Adder(
    input [3:0] a,
	input [3:0] b,
	input c_in,
	output [3:0] s,
	output c_out);

always @(a, b, c_in);
	begin
		assign {c_out, s} = a + b + c_in;
	end
endmodule