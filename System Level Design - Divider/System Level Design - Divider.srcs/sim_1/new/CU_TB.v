`timescale 1ns / 1ps


module CU_TB;

reg CLK;
reg RST;
reg GO;
reg R_lt_Y;
reg [2:0] cnt_out;
reg zero;

wire MUX1;
wire MUX2;
wire MUX3;

wire LD_R;
wire SL_R;
wire SR_R;
wire LI_R;
wire RI_R;

wire LD_X;
wire SL_X;
wire LI_X;
wire SR_X;
wire RI_X;

wire LD_Y;
wire SL_Y;
wire SR_Y;
wire LI_Y;
wire RI_Y;

wire [2:0] cnt_in;
wire cnt_load;
wire cnt_enable;
wire DONE;
wire ERR;

wire [24:0] temp;
wire [2:0] debugcs;


CU U1(
.CLK(CLK),
.RST(RST),
.GO(GO),
.R_lt_Y(R_lt_Y),
.cnt_out(cnt_out),
.zero(zero),

.MUX1(MUX1),
.MUX2(MUX2),
.MUX3(MUX3),

.LD_R(LD_R),
.SL_R(SL_R),
.SR_R(SR_R),
.LI_R(LI_R),
.RI_R(RI_R),

.LD_X(LD_X),
.SL_X(SL_X),
.LI_X(LI_X),
.SR_X(SR_X),
.RI_X(RI_X),

.LD_Y(LD_Y),
.SL_Y(SL_Y),
.SR_Y(SR_Y),
.LI_Y(LI_Y),
.RI_Y(RI_Y),

.cnt_in(cnt_in),
.cnt_load(cnt_load),
.cnt_enable(cnt_enable),
.DONE(DONE),
.ERR(ERR),
.debugcs(debugcs)
);

integer R =0;
integer Y = 0;
integer CNT = 0;
assign temp = {MUX1, MUX2, MUX3, LD_R, SL_R, SR_R, LI_R, RI_R, LD_X, SL_X, LI_X, SR_X, RI_X, LD_Y, SL_Y, SR_Y, LI_Y, RI_Y, cnt_in, cnt_load, cnt_enable, DONE, ERR};

initial begin

CLK = 0;
RST = 1;
#10;
RST=0;
#10;
GO = 0;
R = 3;
Y = 5;
CNT = 1;
cnt_out = 0;
#50;



//state 0
$display("Checking state 0");
    if (temp != 25'b0000000000000000000000000)
        begin 
        $display("Test Failed in State 0");
        end
$display("debugcs = %d",debugcs);
GO = 1;
#10;
CLK = 1;
#10;
CLK = 0;
#10;

//state 1

$display("Checking state 1");		
    if (temp != 25'b0001000010000100001001100)
        begin 
        $display("Test Failed in State 1(%b,%b)",temp,25'b0001000010000100001001100);
        end
$display("debugcs = %d",debugcs);
CLK = 0;
#10;
CLK = 1;
#10;					

// State 2

$display("Checking state 2");					
    if (temp != 25'b0000100001000000000000000)
        begin 
        $display("Test Failed in State 2");
        end		
$display("debugcs = %d",debugcs);    			

CLK = 0;
#10;
CLK = 1;
#10;	

// State 3

$display("Checking state 3");
$display("debugcs = %d",debugcs);
CNT = CNT - 1;                    
R_lt_Y = 1;
CLK = 0;
#10;
CLK = 1;
#10;	


   

    if (R > Y)
    // Enter State 4
    begin
    $display("Checking state 4");
        if (temp != 25'b0000100001100000000000000)
            begin 
            $display("Test Failed in State 4");
            end
    CLK = 0;
    #10;
    CLK = 1;
    #10;	
    $display("debugcs = %d",debugcs);    
    end
    
    else if (R < Y)
       // Enter State 5
       begin 

       $display("Checking state 5");
       
           if (temp != 25'b0000100001000000000000000)
               begin 
               $display("Test Failed in State 5");
               end    
       $display("debugcs = %d",debugcs);
       CLK = 0;
       #10;
       CLK = 1;
       #10;    
       end



    if (CNT == 0)
        begin   // begin for loop
        // Entering State 6
        $display("Checking state 6");
            if (temp != 25'b0000010000000000000000000)
                begin 
                $display("Test Failed in State 6");
                $display("Temp is %b",temp);
                end
        $display("debugcs = %d",debugcs);  
        CLK = 0;
        #10;
        CLK = 1;
        #10;	
        
        // Entering State 7
        $display("Checking state 7");
            if (temp != 25'b0110000000000000000000010)
                begin 
                $display("Test Failed in State 7");
                end
        $display("debugcs = %d",debugcs);
        CLK = 0;
        #10;
        CLK = 1;
        #10;	
        
        end			//end for loop		

    else
        begin
        // Entering State 3
        CNT = CNT -1;
        CLK = 1;
        #10;
        CLK = 0;
        #10;         
        end					 



CLK = 1;
#10;
CLK = 0;
#10;    
$display("Should loop back to state 0");                     
$display("debugcs = %d",debugcs);                     


$display("All states checked, states successful!");					 


end
endmodule


