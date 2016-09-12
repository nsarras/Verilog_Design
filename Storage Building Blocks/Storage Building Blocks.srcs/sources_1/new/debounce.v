module debounce #(parameter width = 16) (
	output reg pb_debounced, 
	input wire pb, 
	input wire clk
	);

localparam shift_max = (2**width)-1;

reg [width-1:0] shift;

always @ (posedge clk)
begin
	shift[width-2:0] <= shift[width-1:1];
	shift[width-1] <= pb;
	if (shift == shift_max)
		pb_debounced <= 1'b1;
	else
		pb_debounced <= 1'b0;
end
endmodule
