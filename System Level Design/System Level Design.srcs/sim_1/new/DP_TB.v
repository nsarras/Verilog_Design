`timescale 1ns / 1ps


module DP_TB;

reg [2:0] in1, in2;
reg [1:0] s1, wa, raa, rab, c;
reg we, rea, reb, s2, clk;
wire [2:0] out;

integer state = 0;
integer i = 0;
//wire [2:0] mux1out;
//wire [2:0] douta;
//wire [2:0] doutb;
//wire [2:0] aluout;


//integer i =0;
//integer mux1_check =0;

DP DUT(
    .in1(in1), 
    .in2(in2), 
    .s1(s1), 
    .clk(clk), 
    .wa(wa), 
    .we(we), 
    .raa(raa), 
    .rea(rea), 
    .rab(rab), 
    .reb(reb), 
    .c(c), 
    .s2(s2), 
    .out(out)
    
    
    );

initial begin

in1 = 5;
in2 = 3;

// Initialize
//#20;

clk = 0;
#10;

s1 = 0;
wa = 0;
we = 0;
raa = 0; 
rea = 0;
rab = 0;
reb = 0;
c = 0; 
s2 = 0; 
#20;



clk = 1;
#10;


for (i =0; i<4; i = i+1)
begin

// State 0


clk = 0;
#10;

s1 = 1;
wa = 0;
we = 0;
raa = 0; 
rea = 0;
rab = 0;
reb = 0;
c = 0; 
s2 = 0; 
#10;
clk = 1;
#10;

// State 1


clk =0;
#10;

s1 = 3;
wa = 1;
we = 1;
raa = 0; 
rea = 0;
rab = 0;
reb = 0;
c = 0; 
s2 = 0; 
#10;
clk = 1;
#10; 


// State 2


clk = 0;
#10; 

s1 = 2;
wa = 2;
we = 1;
raa = 0; 
rea = 0;
rab = 0;
reb = 0;
c = 0; 
s2 = 0; 
#10;
clk = 1;
#10;



// State 3

clk = 0;
#10;

s1 = 1;
wa = 0;
we = 0;
raa = 0; 
rea = 0;
rab = 0;
reb = 0;
c = 0; 
s2 = 0; 
#10;
clk = 1;
#10;

c=0;
#10;

// ---------------------------------------Checking for Opcode-----------------------------------

clk =0;
#10;
c = i;
#10;
clk =1;
#10; 
case (c)

2'b00: begin

// State 7



clk = 0;
#10; 

s1 = 0;
wa = 3;
we = 1;
raa = 1; 
rea = 1;
rab = 1;
reb = 1;
c = 3; 
s2 = 0;
#10;
clk = 1;
#10;

        end
2'b01: begin

// State 6

clk = 0;
#10;


s1 = 0;
wa = 3;
we = 1;
raa = 1; 
rea = 1;
rab = 2;
reb = 1;
c = 2; 
s2 = 0; 
#10;
clk = 1;
#10; 

        end

2'b10: begin

// State 5

clk = 0;
#10;



s1 = 0;
wa = 3;
we = 1;
raa = 1; 
rea = 1;
rab = 2;
reb = 1;
c = 1; 
s2 = 0; 
#10;
clk = 1;
#10;         

        end

2'b11: begin
//State 4

clk = 0;
#10; 


s1 = 0;
wa = 3;
we = 1;
raa = 1; 
rea = 1;
rab = 2;
reb = 1;
c = 0; 
s2 = 0; 
#10;
clk = 1;
#10;

        end
default: $display ("Error No Opcode Selected");


endcase




// State 8

clk = 0;
#10; 

s1 = 1;
wa = 0;
we = 0;
raa = 3; 
rea = 1;
rab = 3;
reb = 1;
c = 2; 
s2 = 1;
#10;
clk = 1;
#10;

end

//// ------------------------------------------------------------------------State 4


//clk = 0;
//#10; 


//s1 = 0;
//wa = 3;
//we = 1;
//raa = 1; 
//rea = 1;
//rab = 2;
//reb = 1;
//c = 0; 
//s2 = 0; 

//clk = 1;
//#10;



//// State 5

//clk = 0;
//#10;



//s1 = 0;
//wa = 3;
//we = 1;
//raa = 1; 
//rea = 1;
//rab = 2;
//reb = 1;
//c = 1; 
//s2 = 0; 

//clk = 1;
//#10; 

//// State 6

//clk = 0;
//#10;

//clk = 1;
//#10; 

//s1 = 0;
//wa = 3;
//we = 1;
//raa = 1; 
//rea = 1;
//rab = 2;
//reb = 1;
//c = 2; 
//s2 = 0; 

//// State 7

//clk = 0;
//#10;

//clk = 1;
//#10; 

//s1 = 0;
//wa = 3;
//we = 1;
//raa = 1; 
//rea = 1;
//rab = 1;
//reb = 1;
//c = 3; 
//s2 = 0;

// State 8



//clk = 0;
//#10; 

//s1 = 1;
//wa = 0;
//we = 0;
//raa = 3; 
//rea = 1;
//rab = 3;
//reb = 1;
//c = 2; 
//s2 = 1;

//clk = 1;
//#10;



//case (s1)

//2'b11: mux1out = in1;
//2'b10: mux1out = in2;
//2'b01: mux1out = 0;
//2'b00: mux1out = aluout;
//default: mux1out = aluout;
//endcase

//mux1_check = mux1out;

//$display ("output at mux1 is %d ", mux1_check);



$display ("All outputs expected, Test Successful");



end
endmodule
