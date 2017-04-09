`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2016 08:31:26 PM
// Design Name: 
// Module Name: SoC
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


//This will be the the top level of SoC which includes the mips & the factorial accelerator as well as the GPIO
//issues, still needd to figure out the DMEM & sign extending the 0's. 
module SoC(
    input clk, rst,
    input [31:0] gpI1, gpI2,
    output [31:0] gpO1, gpO2
    );
    
    wire [31:0] pc, aluout, writedata, dispDat;
    wire [31:0] instr, readdata;
    reg [4:0] dispSel;
    wire memwrite;
    wire WE1, WE2, WEM;
    wire [1:0] RdSel;
    wire [31:0] DmRd, FaRd, IORd;
    
    
    MipsTop MipsProcessor(
         clk, rst,
         pc, instr, memwrite,
         aluout, writedata,
         readdata,
         dispSel,
         dispDat
         );
    
    imem instrMem(
        .a(pc[7:2]),
        .dOut(instr)
        );
        
    dmem dataMem(
       clk, 
       WEM,
       {26'b00000000000000000000000000, aluout[7:2]} , //!! this might give me an error. why does schematic says 5 bits but the inst is 32 bits. 
       writedata,
       DmRd
        );
   
    SoCAddrDec AddrDecSoC(
        memwrite,
        aluout,
        WE1, WE2, WEM,
        RdSel
        );
        
    GPIO IO(
        clk, rst, WE2,
        gpI1, gpI2, writedata,
        {aluout[3:2]},//not sure. cacuse A is 32 bits but this takes only 2 bits.
        IORd, gpO1, gpO2
        );
        
    Mux4 MxSoC(
        DmRd, DmRd, FaRd, IORd,
        RdSel, 
        readdata
        );
        
    Factorialaccel Fact(
        clk, rst,
        {aluout [3:2]},
        WE1, 
        {writedata [3:0]},
        FaRd
        );

    
endmodule

module SoCAddrDec(
    input WE,
    input [31:0] A,
    output WE1, WE2, WEM,
    output [1:0] RdSel
    );
    reg [4:0] signals;
    assign {WE1, WE2, WEM, RdSel} = signals;
    
    always @ (*)begin
        if(WE)begin
            
            case(A [11:8])
                4'b0000:begin //0x0xx DM
                    signals <= 5'b00100;
                end
               4'b1000:begin //0x8xx FACT
                    signals <= 5'b10010;
                end
                4'b1001:begin //0x9xx GPIO
                    signals <= 5'b01011;
                end
                default:begin
                    signals <= 5'bxxxxx;
            end
          endcase
        end
        else begin
            case(A [11:8])
                4'b0000:begin //0x0xx DM
                    signals <= 5'b00000;
                end
               4'b1000:begin //0x8xx FACT
                    signals <= 5'b00010;
                end
                4'b1001:begin //0x9xx GPIO
                    signals <= 5'b00011;
                end
                default:begin
                    signals <= 5'bxxxxx;
                    end
            endcase
        
        
        end
    
    end
    
endmodule

