`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2016 04:03:44 PM
// Design Name: 
// Module Name: FPGA_TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FPGA_TOP(
    input	clk, reset, 
	output	[ 7:0] 	LEDSEL, 
	output 	[ 7:0]	LEDOUT,
	input	[ 3:0]	switches,
	output Err,
	output DONE 
    );
    
    wire     clksec;
    reg        [31:0]     reg_hex;
    
    wire clk_5KHz;
    
        clk_gen top_clk(
        .clk100MHz(clk),
        .rst(reset),
        .clk_sec(clksec),
        .clk_5KHz(clk_5KHz)
        );
        
   wire [31:0] gpI1, gpI2, gpO1, gpO2;
    
   
    SoC top (clksec, reset, gpI1, gpI2, gpO1, gpO2);    
        
    assign gpI1 = {28'b0, switches[3:0]};
    assign Err = gpO1[1];
    assign DONE = gpO1[0];
    
    
    wire [7:0] digit0;
    wire [7:0] digit1;
    wire [7:0] digit2;
    wire [7:0] digit3;
    wire [7:0] digit4;
    wire [7:0] digit5;
    wire [7:0] digit6;
    wire [7:0] digit7;
    
    bcd_to_7seg bcd0 (reg_hex[31:28], digit0);
    bcd_to_7seg bcd1 (reg_hex[27:24], digit1);
    bcd_to_7seg bcd2 (reg_hex[23:20], digit2);
    bcd_to_7seg bcd3 (reg_hex[19:16], digit3);
    
    bcd_to_7seg bcd4 (reg_hex[15:12], digit4);
    bcd_to_7seg bcd5 (reg_hex[11:8], digit5);
    bcd_to_7seg bcd6 (reg_hex[7:4], digit6);
    bcd_to_7seg bcd7 (reg_hex[3:0], digit7);
   
    LED_MUX disp_unit (
        clk_5KHz,
        reset,
        digit0,
        digit1,
        digit2,
        digit3,
        digit4,
        digit5,
        digit6,
        digit7,
        LEDOUT,
        LEDSEL        
        );
    
/*
    7:5 = 000 : Display LSW of register selected by DSW 4:0
    7:5 = 001 : Display MSW of register selected by DSW 4:0
    7:5 = 010 : Display LSW of instr
    7:5 = 011 : Display MSW of instr
    7:5 = 100 : DIsplay LSW of dataaddr
    7:5 = 101 : Display MSW of dataaddr
    7:5 = 110 : Display LSW of writedata
    7:5 = 111 : Display MSW of writedata
*/    
    
    always @ (posedge clk) 
    begin
       reg_hex = gpO2;
    end        

endmodule
