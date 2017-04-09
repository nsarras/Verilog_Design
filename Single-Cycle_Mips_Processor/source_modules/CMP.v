//CMP


module CMP (
	input [31:0] A,
	input [31:0] B,
	output reg GT
	);


always @ (*)begin
	//A= n  && B = 1
	if(A>B)begin
		GT = 1'b1;
	end else begin
		GT=1'b0;
	end

end

endmodule