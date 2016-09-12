`timescale 1ns / 1ps


module CALC_TB;

    reg GO;
    reg [3:0] X; // Dividended
    reg [3:0] Y; // Divisor
    reg rst;
    reg CLK;
    wire DONE;
    wire Err;
    wire [3:0] Q;
    wire [3:0] R;
    wire [2:0] debugcs;

Calculator UUT(

    .GO(GO),
    .X(X), // Dividended
    .Y(Y), // Divisor
    .rst(rst),
    .CLK(CLK),
    .DONE(DONE),
    .Err(Err),
    .Q(Q),
    .R(R),
    .debugcs(debugcs)

);
integer check;
integer i;
integer quotient;
integer remainder;
initial begin
check = 0;
i = 0;
quotient = 0;
remainder = 0;
CLK = 0;
rst = 1;
#10;
rst = 0;
#10;

GO = 0;
X = 10;
Y = 5;

#50;
GO = 1;
quotient = X/Y;
remainder = X % Y;
CLK = 1;
#10;
CLK = 0;

while(DONE == 0)
    begin
    CLK = 0;
    #10;
    CLK = 1;
    #10;
    $display("Current State = %d",debugcs);
    end


if( Q == 4'b0010)
    begin
    $display("Quotient Valid");
    end
else 
    begin
    $display ("Quotient Incorrect, Test Failed..");
    check = 1;
    end

if( Q == 4'b0000)
    begin 
    $display ("Remainder Valid");
    end
else
    begin
    $display ("Remainder Incorrect, Test Failed..");
    check =1;
    end

if(check == 0)
    begin 
    $display("Test Successful");
    end

else if (check ==1)
    begin 
    $display("Test Failed");
    end


$display ("Checking if Quotient is Signed");
if(X[3] == 1'b1 | Y[3] == 1'b1)
    begin
    $display("Expected output is signed");
    end
else
    begin
    $display("Expected output is not signed");
    end
$display("Test Failed");
end
endmodule
