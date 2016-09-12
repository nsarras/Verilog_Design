`timescale 1ns / 1ps
module tb_new;
reg[3:0] tb_in_top;
wire tb_top_out;
and_or DUT(.in_top(tb_in_top), .out_top(tb_top_out));
initial
begin
tb_in_top = 0;
#5 tb_in_top = 4'b0000;#5 tb_in_top = 4'b0001;
#5 tb_in_top = 4'b0010;#5 tb_in_top = 4'b0011;
#5 tb_in_top = 4'b0100;#5 tb_in_top = 4'b0101;
#5 tb_in_top = 4'b0110;#5 tb_in_top = 4'b0111;
#5 tb_in_top = 4'b1000;#5 tb_in_top = 4'b1001;
#5 tb_in_top = 4'b1010;#5 tb_in_top = 4'b1011;
#5 tb_in_top = 4'b1100;#5 tb_in_top = 4'b1101;
#5 tb_in_top = 4'b1110;#5 tb_in_top = 4'b1111;
#100 $finish;
end
endmodule