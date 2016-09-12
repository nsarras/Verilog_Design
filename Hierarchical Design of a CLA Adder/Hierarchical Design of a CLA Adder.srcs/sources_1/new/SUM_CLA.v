`timescale 1ns / 1ps



module SUM_CLA(
    output COUT,
    output [4:0] sum

    );


    reg [3:0] p;
    reg [3:0] C;
    reg [3:0] A;
    reg [3:0] B;


CLA_ADDER UUT(
      .p(p),    
      .a(A),
      .b(B)
    );
    
CLA DUT(
    .p(p),    
    .a(A),
    .b(B),
    .C(C)
        

);

//always @(p,C);
begin

assign sum[0] = p[0]^C[0];
assign sum[1] = p[1]^C[1];
assign sum[2] = p[2]^C[2];
assign sum[3] = p[3]^C[3];

assign COUT = C[4];








end
endmodule
