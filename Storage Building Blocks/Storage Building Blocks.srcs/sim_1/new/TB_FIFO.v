//`timescale 1ns / 1ps

//parameter bus_width = 8;
//parameter addr_width = 4;
//parameter fifo_depth = 8; // 2^addr_width = fifo_depth


//reg [bus_width-1:0] D_in;
//reg clk;
//reg rst; 
//reg WNR;
//reg enable; 

//wire [bus_width-1:0] D_out;
//wire full;
//wire empty;

//reg [addr_width:0] r_ptr, w_ptr; // read and write pointers
//reg [bus_width-1:0] mem [fifo_depth -1:0]; // memory used by the FIFO

//integer i = 0;

//module TB_FIFO(
//    .D_in(D_in),
//    .clk(clk),
//    .rst(rst),
//    .WNR(WNR),
//    .enable(enable),
//    .D_out(D_out),
//    .full(full),
//    .empty(empty),
//    .r_ptr(r_ptr),
//    .w_ptr(w__ptr)
//    );
    
//initial 
//begin

//D_in = 0;
//clk = 0;
//rst = 0;
//WNR = 0;
//enable =0;


//#50;

//rst = 1;
//clk =1;
//#10;

//clk =0;
//rst =0;

//enable =1;
//#10;

//WNR = 0;
//clk = 1;






    
//end
//endmodule
