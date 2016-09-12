`timescale 1ns / 1ps

module TB_Test;

reg [7:0] D_in;
reg clk;
reg rst; 
reg WNR;
reg enable; 

wire [7:0] D_out;
wire full;
wire empty;

//reg r_ptr, w_ptr; // read and write pointers
//reg [7:0] mem [7:0]; // memory used by the FIFO

integer i = 0;
integer check = 0;
FIFO UUT(    
    
    .enable(enable),
    .D_out(D_out),
    .full(full),
    .empty(empty),
    .D_in(D_in),
        .clk(clk),
        .rst(rst),
        .WNR(WNR)        // '1' allows to read '0' allows to write
 //   .r_ptr(r_ptr),
 //   .w_ptr(w__ptr)
    );
    
 initial begin




rst = 0;
clk = 1;
enable = 1;
WNR = 0;
D_in =0;
#50;

rst = 1;
#50;
rst = 0;
#50;
//// --------------------   Writing --------------
//clk = 0;
WNR = 0;
//clk = 1;
#10;

for(i = 0; i<8; i = i+1)
begin
    if (full != 1)
    begin
    D_in = i;
    #10;
    clk = 1;
    #10;
    clk = 0;
    #10;
    end
end

if(full == 1 && empty ==1)
begin 
$display ("invalid");
$stop;
end

if(full == 0 && empty == 0)
begin 
$display ("partially full");
end


//// ------------------  Reading --------------------

//clk = 0;
WNR = 1;
//clk = 1;
#10;

for(i =0; i<8; i = i+1)
begin
    if(empty != 1)
    begin
    check = D_out;
    #10;
    clk = 1;
    #10;
    clk = 0;
    #10;
    $display ("Data out is %d",check);
    end

end

    if (D_out == D_in)
    begin
    $display ("Data Verified");
    end
    else
    begin
    $display ("Data not verified");
    end



    
    
    
end
endmodule
