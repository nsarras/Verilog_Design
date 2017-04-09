`timescale 1ns / 1ps


module calc_tb;

reg clk;
reg GO;
reg rst;
reg [3:0] n;
wire DONE;
wire [31:0] OUTPUT;
wire [3:0] debugcs;

factorial_calc DUT(.clk(clk), .GO(GO), .rst(rst), .n(n), .DONE(DONE), .OUTPUT(OUTPUT), .debugcs(debugcs));

integer i, j;
reg [31:0] testOut;

initial
begin

	clk = 1'b0;
	rst = 1'b1;
	#5;
	rst = 1'b0; //cycles thru reset
	GO= 1'b0;
end

initial forever #5 clk = ~clk;


initial begin
	#5; //waiting GO isn't set yet.

	for(i=0; i<11; i=i+1)begin
		#5;
		n <= i;	
		GO <= 1'b1; //allows system to go to s1.

		$display("Pushing %d into n", n);
		// $display("Currently in State: %i", CS);
		#10;

		while(!DONE)begin
		    
		    if(n == 4'b0100)
		    begin
		    $display("You are currently in n = 4");
		    $display("%d",debugcs); 
		    end
		    #10;
			//this is waiting for the circuit to be done. ASM s0->s4; when s4 DONE should be 1 & the loop will break.
		end

		testOut = 1'b1;
		for(j= 0; j<n; j=j+1)begin
			testOut = testOut * (n-j); //ex. 5-0, 5-1, 5-2, ..., 5-4
		end
			
		if(OUTPUT != testOut)begin
			$display("Your output is wrong. You got %i when it's suppose to be %i", OUTPUT, testOut);
			$stop;
		end

		GO = 1'b0;

	end
	$display("All cases ran successfully");
	$finish;
end

endmodule