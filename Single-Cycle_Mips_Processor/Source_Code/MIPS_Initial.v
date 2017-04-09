
//mips_initial.v
//------------------------------------------------
// Source Code for a Single-cycle MIPS Processor (supports partial instruction)
// Developed by D. Hung, D. Herda and G. Gerken,
// based on the following source code provided by
// David_Harris@hmc.edu (9 November 2005):
//    mipstop.v
//    mipsmem.v
//    mips.v
//    mipsparts.v
//------------------------------------------------
 
            /* Main decoder will hold I & J type controls*/ //still need to do JAL.
// Main Decoder
module maindec(
  input   [ 5:0]  op,
  output          memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, JAL,
  output  [ 1:0]  aluop );
 
  reg     [ 9:0]  controls;
 
  assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop, JAL} = controls;
 
  always @(*)
      case(op)
          6'b000000: controls <= 10'b1100000100; //Rtype
          6'b100011: controls <= 10'b1010010000; //LW
          6'b101011: controls <= 10'b0010100000; //SW
          6'b000100: controls <= 10'b0001000010; //BEQ
          6'b001000: controls <= 10'b1010000000; //ADDI
          6'b000010: controls <= 10'b0000001000; //J
          6'b000011: controls <= 10'b1000011001;//jal
 
          default:   controls <= 10'bxxxxxxxxxx; //???
      endcase
endmodule
 
// ALU Decoder
module aludec(
  input       [5:0]   funct,
  input       [1:0]   aluop,
  output reg  [2:0]   alucontrol,
  output           JR, HiLoSel, PWE, MFHILO,
  reg [3:0]       aluDecControls);
  assign {JR, HiLoSel, PWE, MFHILO} = aluDecControls;
 
  always @(*) begin
      case(aluop)
          2'b00: alucontrol <= 3'b010;  // add
          2'b01: alucontrol <= 3'b110;  // sub          
         
          default: alucontrol <= 3'bxxx; //default will be add.  for R types it'll  be 10
      endcase
     if(aluop == 2'b10)begin
      case(funct)          // RTYPE
              6'b100000:begin
                    aluDecControls = 4'b0x00;  //add funct
                    alucontrol <= 3'b010;
                  end
             
              6'b100010:begin
                        aluDecControls = 4'b0x00; //sub
                        alucontrol <= 3'b110;
                     end
 
              6'b100100:begin
                     aluDecControls = 4'b0x00;  //&
                     alucontrol <= 3'b000;
               end
 
              6'b100101:begin
                    aluDecControls = 4'b0x00; //||
                    alucontrol <= 3'b001;
              end
           
              6'b101010:begin
                     aluDecControls = 4'b0x00; //slt
                     alucontrol <= 3'b111;
                end
 
              //below is what I am adding to the program.!!!!!!!!!!!!!THIS IS WHAT I NEED TO DO RIGHT NOW. finish the aludecfcontrols
              6'b011001:aluDecControls = 4'b0x10; //multu
         
              6'b010000:aluDecControls = 4'b0101; //MFHi
           
              6'b010010:aluDecControls = 4'b0001; //MFLo
             
              6'b001000:begin
                 aluDecControls = 4'b1x00; //JR  
                 alucontrol <= 3'b010;
             end
              default:aluDecControls = 4'b0000; //default case
          endcase
       end
       else begin
        aluDecControls = 4'b0000;
       end
      end
endmodule
// ALU
module alu(
    input       [31:0]  a, b,
    input       [ 2:0]  alucont,
    output reg  [31:0]  result,
    output          zero );
 
    wire    [31:0]  b2, sum, slt;
 
    assign b2 = alucont[2] ? ~b:b;
    assign sum = a + b2 + alucont[2];
    assign slt = sum[31];
 
    always@(*)
        case(alucont[1:0])
            2'b00: result <= a & b;
            2'b01: result <= a | b;
            2'b10: result <= sum;
            2'b11: result <= slt;
        endcase
 
    assign zero = (result == 32'b0);
endmodule
 
// Adder
module adder(
    input   [31:0]  a, b,
    output reg  [31:0]  y );
    always@(*)begin
       y = a + b;
    end
endmodule
 
 
// Added Modules-----------------------------------------------------------------------------
 
// Multiplier
module mult(
    input [31:0] a, b,
    output [63:0] y);
    assign y = a * b;
endmodule
 
// AND GATE
module andgate(
    input a, b,
    output y);
    assign y = a & b;
endmodule
 
// OR GATE
module orgate(
    input a, b,
    output y);
    assign y = a | b;
endmodule
 
//-------------------------------------------------------------------------------------------------
 
// Extended jumpshft
module slj(
    input [25:0] a,
    output [27:0] y);
   
    assign y = {a[25:0], 2'b00};
endmodule
 
 
// Two-bit left shifter
module sl2(
    input   [31:0]  a,
    output  [31:0]  y );
 
    // shift left by 2
    assign y = {a[29:0], 2'b00};
endmodule
 
// Sign Extension Unit
module signext(
    input   [15:0]  a,
    output  [31:0]  y );
 
    assign y = {{16{a[15]}}, a};
endmodule
 
// Parameterized Register
module flopr #(parameter WIDTH = 8) (
    input                   clk, reset,
    input       [WIDTH-1:0] d,
    output reg  [WIDTH-1:0] q);
 
    always @(posedge clk, posedge reset)
        if (reset) q <= 0;
        else       q <= d;
endmodule
 
// commented out since flopenr is not used
//module flopenr #(parameter WIDTH = 8) (
//  input                   clk, reset,
//  input                   en,
//  input       [WIDTH-1:0] d,
//  output reg  [WIDTH-1:0] q);
//
//  always @(posedge clk, posedge reset)
//      if      (reset) q <= 0;
//      else if (en)    q <= d;
//endmodule
 
// Parameterized 2-to-1 MUX
module mux2 #(parameter WIDTH = 8) (
    input   [WIDTH-1:0] d0, d1,
    input               s,
    output  [WIDTH-1:0] y );
 
    assign y = s ? d1 : d0;
endmodule
 
// register file with one write port and three read ports
// the 3rd read port is for prototyping dianosis
module regfile(
    input           clk,
    input           we3,
    input   [ 4:0]  ra1, ra2, wa3,
    input   [31:0]  wd3,
    output  [31:0]  rd1, rd2,
    input   [ 4:0]  ra4,
    output  [31:0]  rd4);
 
    reg     [31:0]  rf[31:0];
    integer         n;
   
    //initialize registers to all 0s
    initial begin
        for (n=0; n<32; n=n+1)
            rf[n] = 32'h00;
            rf[29] = 60;
    end
    //write first order, include logic to handle special case of $0
    always @(posedge clk)
        if (we3)
            if (~ wa3[4])
                rf[{0,wa3[3:0]}] <= wd3;
            else
                rf[{1,wa3[3:0]}] <= wd3;
       
            // this leads to 72 warnings
            //rf[wa3] <= wd3;
           
            // this leads to 8 warnings
            //if (~ wa3[4])
            //  rf[{0,wa3[3:0]}] <= wd3;
            //else
            //  rf[{1,wa3[3:0]}] <= wd3;
 
       
    assign rd1 = (ra1 != 0) ? rf[ra1[4:0]] : 0;
    assign rd2 = (ra2 != 0) ? rf[ra2[4:0]] : 0;
    assign rd4 = (ra4 != 0) ? rf[ra4[4:0]] : 0;
endmodule
 
// Product Register
module preg(
    input clk, HiLoSel,
    input PWE,
    input [31:0] WLO,
    input [31:0] WHI,
    output reg [31:0] product);
   
    reg [31:0] hi, lo;
   
    always@(posedge clk)
        begin
            if(PWE)
                begin
                   hi <= WHI;
                   lo <= WLO;
                end
            if(HiLoSel)
            begin
                product <= WHI;
            end
            else
            begin
                product <= WLO;
            end
        end
endmodule
 
// Control Unit
module controller(
  input   [5:0]   op, funct,
  input           zero,
  output          memtoreg, memwrite, alusrc, regdst, regwrite, jump, JAL, JR, HiLoSel, PWE, MFHILO, branch,
  output  [2:0]   alucontrol );
 
  wire    [1:0]   aluop;
  //wire          branch;
 
  maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, JAL, aluop);
  aludec  ad(funct, aluop, alucontrol, JR, HiLoSel, PWE, MFHILO);
 
  //assign pcsrc = branch & zero;
endmodule
 
// Data Path (excluding the instruction and data memories)
module datapath(
    input           clk, reset, jump, jal, JR, MFHILO, memtoreg,  branch, alusrc,  regdst, regwrite, HiLoSel, PWE,
    input   [2:0]   alucontrol,
    output          zero,
    output  [31:0]  pc,
    input   [31:0]  instr,
    output  [31:0]  aluout, writedata,
    input   [31:0]  readdata,
    input   [ 4:0]  dispSel,
    output  [31:0]  dispDat );
   
 
// Not used control signal
// memwrite, PWE,  HiLoSel
    // NEW WIRES
    wire pcsrc, jmp;
    wire [4:0] rgdata, writereg;
    wire [31:0] ldwrd,mx3out, mx2out, pcnext, pcplus4;
    wire [31:0] srca;
    wire[31:0] signimm, signimmsh;
    wire[31:0] aluin;
    wire[31:0] dataout;
    wire[27:0] JTA;
    wire[63:0] multout;
    wire[31:0] product;
    wire[31:0] pcbranch;
    wire[31:0] joined;
    wire[31:0] rfdata;
    //NEW DEFINITION OF DATAPATH
    // -------------------------------------------------------------------------------------------------------
    // Modules start from the leftmost side of the datapath
   
    assign joined = {pcplus4[31:28], JTA};
   
    // PC LOGIC
    mux2 #(32) mx3(.d0(pcplus4), .d1(ldwrd), .s(JR), .y(mx3out));
    mux2 #(32) mx2(.d0(mx3out), .d1(pcbranch), .s(pcsrc), .y(mx2out));
    mux2 #(32) mx1(.d0(mx2out), .d1(joined), .s(jmp), .y(pcnext));
    flopr #(32) pcreg(.clk(clk), .reset(reset), .d(pcnext), .q(pc));
    adder       pcadd1(.a(pc), .b(32'b00000000000000000000000000000100), .y(pcplus4));
    adder       pcadd2(.a(pcplus4), .b(signimmsh), .y(pcbranch));
   
   
   
   
    // RF logic
    regfile     rf(.clk(clk), .we3(regwrite), .ra1(instr[25:21]), .ra2(instr[20:16]), .wa3(rgdata), .wd3(rfdata), .rd1(srca), .rd2(writedata),  .ra4(dispSel), .rd4(dispDat));
    mux2 #(5)   wrmux(.d0(instr[20:16]), .d1(instr[15:11]), .s(regdst), .y(writereg));
    mux2 #(5)  ramux(.d0(writereg), .d1(5'b11111), .s(jal), .y(rgdata));
    //Need to look at this mux
    mux2 #(32) resultmux(.d0(ldwrd), .d1(pcplus4), .s(jal), .y(rfdata));
    signext se(.a(instr[15:0]), .y(signimm));
    sl2 immsh(.a(signimm), .y(signimmsh));
    slj jmpshft(.a(instr[25:0]), .y(JTA));
   
   
   
   
    // ALU LOGIC
    mux2 #(32) srcbmux(.d0(writedata), .d1(signimm), .s(alusrc), .y(aluin));
    alu        alu(.a(srca), .b(aluin), .alucont(alucontrol), .result(aluout), .zero(zero));
    mult       mlt(.a(srca), .b(aluin), .y(multout));
    mux2 #(32) memtoregmux(.d0(aluout), .d1(readdata), .s(memtoreg), .y(dataout));
    mux2 #(32) mxfinal(.d0(dataout), .d1(product), .s(MFHILO), .y(ldwrd));
   
    //AND LOGIC
   
    andgate    nd(.a(branch), .b(zero), .y(pcsrc));
   
    //OR LOGIC
   
    orgate     jor(.a(jal), .b(jump), .y(jmp));
   
    //Product Register
    preg       prodreg(.clk(clk), .HiLoSel(HiLoSel), .PWE(PWE), .WLO(multout[31:0]), .WHI(multout[63:32]), .product(product));
endmodule
 
// The MIPS (excluding the instruction and data memories)
//module mips(
//  input           clk, reset,
//  output  [31:0]  pc,
//  input   [31:0]  instr,
//  output          memwrite,
//  output  [31:0]  aluout, writedata,
//  input   [31:0]  readdata,
//  input   [ 4:0]  dispSel,
//  output  [31:0]  dispDat );
 
//  // deleted wire "branch" - not used
//  wire            memtoreg, pcsrc, zero, alusrc, regdst, regwrite, jump;
//  wire    [2:0]   alucontrol;
 
//  controller c(instr[31:26], instr[5:0], zero,
//              memtoreg, memwrite, pcsrc,
//              alusrc, regdst, regwrite, jump,
//              alucontrol);
//  datapath dp(clk, reset, memtoreg, pcsrc,
//              alusrc, regdst, regwrite, jump,
//              alucontrol, zero, pc, instr, aluout,
//              writedata, readdata, dispSel, dispDat);
//endmodule
 
module MipsTop(
  input           clk, reset,
  output  [31:0]  pc,
  input   [31:0]  instr,
  output          memwrite,
  output  [31:0]  aluout, writedata,
  input   [31:0]  readdata,
  input   [ 4:0]  dispSel,
  output  [31:0]  dispDat );
 
  // deleted wire "branch" - not used
  wire            branch;
  wire            memtoreg, zero, alusrc, regdst, regwrite, jump, JAL, JR, HiLoSel,  MFHILO;
  wire    [2:0]   alucontrol;
  wire            PWE;
 
  controller c(instr[31:26], instr[5:0], zero,
              memtoreg, memwrite,
              alusrc, regdst, regwrite, jump, JAL, JR, HiLoSel, PWE, MFHILO, branch,
              alucontrol);
 
 
  datapath dp(
              clk, reset, jump, JAL, JR, MFHILO, memtoreg,  branch, alusrc,  regdst, regwrite, HiLoSel, PWE,
              alucontrol,
              zero,
              pc,
              instr,
              aluout, writedata,
              readdata,
              dispSel,
              dispDat );
//module controller(
//          input   [5:0]   op, funct,
//          input           zero,
//          output          memtoreg, memwrite, alusrc, regdst, regwrite, jump, JAL, JR, HiLoSel, PWE, MFHILO, branch,
//          output  [2:0]   alucontrol );
 
       
//module datapath(
//            input            clk, reset, jump, jal, JR, MFHILO, memtoreg,  branch, alusrc,  regdst, regwrite, HiLoSel, PWE,
//            input    [2:0]    alucontrol,
//            output            zero,
//            output    [31:0]    pc,
//            input    [31:0]    instr,
//            output    [31:0]    aluout, writedata,
//            input    [31:0]    readdata,
//            input    [ 4:0]    dispSel,
//            output    [31:0]    dispDat );        
       
endmodule
 
 
//// The MIPS (excluding the instruction and data memories)
//module mips(
//  input           clk, reset,
//  output  [31:0]  pc,
//  input   [31:0]  instr,
//  output          memwrite,
//  output  [31:0]  aluout, writedata,
//  input   [31:0]  readdata,
//  input   [ 4:0]  dispSel,
//  output  [31:0]  dispDat );
 
//  // deleted wire "branch" - not used
//  wire            branch;
//  wire            memtoreg, pcsrc, zero, alusrc, regdst, regwrite, jump, JAL, JR, HiLoSel,  MFHILO;
//  wire    [2:0]   alucontrol;
//  wire            PWE;
 
//  controller c(instr[31:26], instr[5:0], zero,
//              memtoreg, memwrite,
//              alusrc, regdst, regwrite, jump, JAL, JR, HiLoSel, PWE, MFHILO, branch,
//              alucontrol);
 
 
//  datapath dp(
//              clk, reset, jump, JAL, JR, MFHILO, memtoreg,  branch, alusrc,  regdst, regwrite, HiLoSel, PWE,
//              alucontrol,
//              zero,
//              pc,
//              instr,
//              aluout, writedata,
//              readdata,
//              dispSel,
//              dispDat );
//endmodule
 
 
 
 
// Instruction Memory
module imem (
    input   [ 5:0]  a,
    output  [31:0]  dOut );
   
    reg     [31:0]  rom[0:63];
   
    //initialize rom from memfile_s.dat
    initial
        $readmemh("memfile_s.dat", rom);
   
    //simple rom
    assign dOut = rom[a];
endmodule
 
// Data Memory
module dmem (
    input           clk,
    input           we,
    input   [31:0]  addr,
    input   [31:0]  dIn,
    output  [31:0]  dOut );
   
    reg     [31:0]  ram[63:0];
    integer         n;
   
    //initialize ram to all FFs
    initial
        for (n=0; n<64; n=n+1)
            ram[n] = 8'hFF;
       
    assign dOut = ram[addr[31:2]];
               
    always @(posedge clk)
        if (we)
            ram[addr[31:2]] = dIn;
endmodule
 
 
// TESTING TOP LEVEL
module TestTop(
           input         clk, reset,
           output [31:0] writedata, dataadr,
           output        memwrite,
           input [4:0] dispSel,
           output [31:0] dispDat
);
//input           clk, reset,
//  output  [31:0]  pc,
//  input   [31:0]  instr,
//  output          memwrite,
//  output  [31:0]  aluout, writedata,
//  input   [31:0]  readdata,
//  input   [ 4:0]  dispSel,
//  output  [31:0]  dispDat
wire [31:0] pc, instr;
wire [31:0] readdata;
MipsTop top(.clk(clk), .reset(reset), .pc(pc), .instr(instr), .memwrite(memwrite), .aluout(dataadr), .writedata(writedata), .readdata(readdata), .dispSel(dispSel), .dispDat(dispDat));
dmem data(.clk(clk), .we(memwrite), .addr(dataadr), .dIn(writedata), .dOut(readdata));
imem ins(.a(pc[7:2]), .dOut(instr));
 
 
// Data Memory
//  input           clk,
//input            we,
//input    [31:0]    addr,
//input    [31:0]    dIn,
//output     [31:0]    dOut
 
// Instruction Memory
//input [ 5:0]  a,
//  output  [31:0]  dOut
 
endmodule



