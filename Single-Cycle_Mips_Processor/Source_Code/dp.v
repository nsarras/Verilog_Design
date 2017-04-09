module dp(
	input [3:0] n,
	input clk, SEL, CNT_EN, LD_CNT, LD_REG, OE_EN,
	output [31:0] out,
	output compare, Done
	);

wire [31:0] mulOut;
wire [31:0] muxOut;
wire [31:0] regOut;
wire [31:0] cntOut;


MUX m1(
	.a(1'b1), .b(mulOut),
	.sel(SEL),
	.x(muxOut)
	);

REG r1(
	.d(muxOut), 
	.clk(clk), .LD_REG(LD_REG), 
	.q(regOut)
	);

MUL mul1(
	.x(regOut), .y(cntOut),
	.z(mulOut)
	);

CNT c1(
	.clk(clk), .CNT_EN(CNT_EN), .LD_CNT(LD_CNT),
	.n(n),
	.N(cntOut)
	);

OE o1(
	.a(regOut), .en(OE_EN),
	.b(out)
	);

CMP comp1(
	.A(cntOut), .B(1'b1),
	.GT(compare));

endmodule


