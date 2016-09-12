`timescale 1ns / 1ps

module FIFO (D_in, D_out, empty, full, clk, rst, WNR, enable);
parameter bus_width = 8;
parameter addr_width = 3;
parameter fifo_depth = 8; // 2^addr_width = fifo_depth
input clk; // clock
input rst; // Asynchronous reset
input WNR; // read (1) or write (0) control
input enable; // enables the FIFO
input [bus_width-1:0] D_in; // Data input to the FIFO
output [bus_width-1:0] D_out; // Data output from the FIFO
output full; // Asserted when the FIFO is full
output empty; // Asserted when the FIFO is empty

reg [bus_width-1:0] D_out;
reg full, empty;
reg [addr_width:0] r_ptr, w_ptr; // read and write pointers
// Pay attention on their size!!!
reg [bus_width-1:0] mem [fifo_depth -1:0]; // memory used by the FIFO

always @ (posedge clk, posedge rst)
begin
if (rst)
begin r_ptr = 0; w_ptr = 0; D_out = 0; end

else if (!enable)
begin D_out = 'bz; end

else if (WNR && !empty) // start reading
begin D_out = mem[r_ptr[addr_width-1:0]]; r_ptr = r_ptr + 1; end

else if (!WNR && !full) // start writing
begin mem[w_ptr[addr_width-1:0]] = D_in; w_ptr = w_ptr + 1; end

else
begin D_out = 'bz; end
end

always @ (r_ptr, w_ptr) // update the flags based on the read/write pointers
begin

if (r_ptr == w_ptr)
begin empty = 1; full = 0; end

else if (r_ptr[addr_width -1:0] == w_ptr[addr_width-1:0])
begin empty = 0; full = 1; end

else
begin empty = 0; full = 0; end

end
endmodule
    

