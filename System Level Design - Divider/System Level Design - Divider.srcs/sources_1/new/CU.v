module CU(input CLK,
		  input RST,
		  input GO,
		  input R_lt_Y,
		  input [2:0] cnt_out,
		  input zero,
		  
		  output reg MUX1,
		  output reg MUX2,
		  output reg MUX3,
		  
		  output  reg LD_R,
		  output  reg SL_R,
		  output  reg SR_R,
		  output  reg LI_R,
		  output  reg RI_R,
		  
		  output  reg LD_X,
		  output  reg SL_X,
		  output  reg LI_X,
		  output  reg SR_X,
		  output  reg RI_X,
		  
		   output  reg LD_Y,
           output  reg SL_Y,
           output  reg SR_Y,
           output  reg LI_Y,
           output  reg RI_Y,
		  // UP DOWN COUNTER CONTROL SIGNALS
		  output reg UD_RST,
		  output reg [2:0] cnt_in,
		  output  reg cnt_load,
		  output  reg cnt_enable,
		  output reg UD,
		  output wire [2:0] debugcs,
		  //FINAL OUTPUTS OF CONTROL UNIT
		  output  reg DONE,
          output  reg ERR
		  );
		  
reg [2:0] CS;
reg [2:0] NS;


assign debugcs = CS;

always@(CS, GO, R_lt_Y, cnt_out)
begin
    case(CS)
		3'b000: NS = ((GO) ? 3'b001 : 3'b000);
		3'b001: NS = 3'b010;
		3'b010: NS = 3'b011;
        3'b011: NS = ((R_lt_Y) ? 3'b101 : 3'b100);
        3'b100: NS = ((cnt_out == 3'b000) ? 3'b110 : 3'b011);
        3'b101: NS = ((cnt_out == 3'b000) ? 3'b110 : 3'b011);
        3'b110: NS = 3'b111;
        3'b111: NS = 3'b000;
        default: NS = 3'b000;
	endcase
end                      

always@(posedge CLK,posedge RST)
begin
	CS <= ((RST) ? 3'b000 : NS);
end					  

always@(CS, R_lt_Y)
begin
	case(CS)
		3'b000: begin
					MUX1 = 1'b0;
					MUX2 = 1'b0;
					MUX3 = 1'b0;
					
					LD_R = 1'b0;
					SL_R = 1'b0;
					SR_R = 1'b0;
					LI_R = 1'b0; // new
                    RI_R = 1'b0;
					
					LD_X = 1'b0;
					SL_X = 1'b0;
					LI_X = 1'b0;
					SR_X = 1'b0;  // new
                    RI_X = 1'b0;
					
					LD_Y = 1'b0;
                    SL_Y = 1'b0; // new
                    SR_Y = 1'b0;
                    LI_Y = 1'b0;
                    RI_Y = 1'b0;
					cnt_in = 3'b000;
					cnt_load = 1'b0;
					cnt_enable = 1'b0;
					DONE = 1'b0;
					ERR = 1'b0;
				end
		3'b001: begin
					MUX1 = 1'b0;
					MUX2 = 1'b0;
					MUX3 = 1'b0;
				
					LD_R = 1'b1;
					SL_R = 1'b0;
					SR_R = 1'b0;
				    LI_R = 1'b0; // new
                    RI_R = 1'b0;
				    
					LD_X = 1'b1;
					SL_X = 1'b0;
					LI_X = 1'b0;
				    SR_X = 1'b0;  // new
                    RI_X = 1'b0;
				    
					LD_Y = 1'b1;
				    SL_Y = 1'b0; // new
                    SR_Y = 1'b0;
                    LI_Y = 1'b0;
                    RI_Y = 1'b0;
				
					cnt_in = 3'b100;
					cnt_load = 1'b1;
					cnt_enable = 1'b1;
					DONE = 1'b0;
					ERR = 1'b0;
				end
		3'b010: begin
					MUX1 = 1'b0;
					MUX2 = 1'b0;
					MUX3 = 1'b0;
					
					LD_R = 1'b0;
					SL_R = 1'b1;
					SR_R = 1'b0;
					LI_R = 1'b0; // new
                    RI_R = 1'b0;
					
					LD_X = 1'b0;
					SL_X = 1'b1;
					LI_X = 1'b0;
					SR_X = 1'b0;  // new
                    RI_X = 1'b0;
					
					LD_Y = 1'b0;
					SL_Y = 1'b0; // new
                    SR_Y = 1'b0;
                    LI_Y = 1'b0;
                    RI_Y = 1'b0;
					
					cnt_in = 3'b000;
					cnt_load = 1'b0;
					cnt_enable = 1'b0;
					DONE = 1'b0;
					ERR = 1'b0;
				end
        3'b011: begin
					MUX1 = ((R_lt_Y) ? 1'b0 : 1'b1);
					MUX2 = 1'b0;
					MUX3 = 1'b0;
					
					LD_R = ((R_lt_Y) ? 1'b0 : 1'b1);
					SL_R = 1'b0;
					SR_R = 1'b0;
					LI_R = 1'b0; // new
                    RI_R = 1'b0;
					
					LD_X = 1'b0;
					SL_X = 1'b0;
					LI_X = 1'b0;
					SR_X = 1'b0;  // new
                    RI_X = 1'b0;
					
					LD_Y = 1'b0;
					SL_Y = 1'b0; // new
                    SR_Y = 1'b0;
                    LI_Y = 1'b0;
                    RI_Y = 1'b0;
					
					cnt_in = 3'b000;
					cnt_load = 1'b0;
					cnt_enable = 1'b1;
					UD = 1'b0;
					DONE = 1'b0;
					ERR = 1'b0;
				end
        3'b100: begin
					MUX1 = 1'b0;
					MUX2 = 1'b0;
					MUX3 = 1'b0;
					
					
					LD_R = 1'b0;
					SL_R = 1'b1;
					SR_R = 1'b0;
					LI_R = 1'b0; // new
                    RI_R = 1'b0;
					
					LD_X = 1'b0;
					SL_X = 1'b1;
					LI_X = 1'b1;
					SR_X = 1'b0;  // new
                    RI_X = 1'b0;
					
					LD_Y = 1'b0;
					SL_Y = 1'b0; // new
                    SR_Y = 1'b0;
                    LI_Y = 1'b0;
                    RI_Y = 1'b0;
					
					cnt_in = 3'b000;
					cnt_load = 1'b0;
					cnt_enable = 1'b0;
					DONE = 1'b0;
					ERR = 1'b0;
				end
        3'b101: begin
					MUX1 = 1'b0;
					MUX2 = 1'b0;
					MUX3 = 1'b0;
					
					
					LD_R = 1'b0;
					SL_R = 1'b1;
					SR_R = 1'b0;
					LI_R = 1'b0; // new
                    RI_R = 1'b0;
					
					LD_X = 1'b0;
					SL_X = 1'b1;
					LI_X = 1'b0;
					SR_X = 1'b0;  // new
                    RI_X = 1'b0;
					
					LD_Y = 1'b0;
					SL_Y = 1'b0; // new
                    SR_Y = 1'b0;
                    LI_Y = 1'b0;
                    RI_Y = 1'b0;
					
					cnt_in = 3'b000;
					cnt_load = 1'b0;
					cnt_enable = 1'b0;
					DONE = 1'b0;
					ERR = 1'b0;
				end
        3'b110: begin
					MUX1 = 1'b0;
					MUX2 = 1'b0;
					MUX3 = 1'b0;
					
					
					LD_R = 1'b0;
					SL_R = 1'b0;
					SR_R = 1'b1;
					LI_R = 1'b0; // new
                    RI_R = 1'b0;
					
					LD_X = 1'b0;
					SL_X = 1'b0;
					LI_X = 1'b0;
					SR_X = 1'b0;  // new
                    RI_X = 1'b0;
					
					LD_Y = 1'b0;
					SL_Y = 1'b0; // new
                    SR_Y = 1'b0;
                    LI_Y = 1'b0;
                    RI_Y = 1'b0;
					
					cnt_in = 3'b000;
					cnt_load = 1'b0;
					cnt_enable = 1'b0;
					DONE = 1'b0;
					ERR = 1'b0;
				end
        3'b111: begin
					MUX1 = 1'b0;
					MUX2 = 1'b1;
					MUX3 = 1'b1;
					
					
					LD_R = 1'b0;
					SL_R = 1'b0;
					SR_R = 1'b0;
					LI_R = 1'b0; // new
                    RI_R = 1'b0;
					
					LD_X = 1'b0;
					SL_X = 1'b0;
					LI_X = 1'b0;
					SR_X = 1'b0;  // new
                    RI_X = 1'b0;
					
					LD_Y = 1'b0;
					SL_Y = 1'b0; // new
                    SR_Y = 1'b0;
                    LI_Y = 1'b0;
                    RI_Y = 1'b0;
					
					cnt_in = 3'b000;
					cnt_load = 1'b0;
					cnt_enable = 1'b0;
					DONE = 1'b1;
					ERR = 1'b0;
				end
	endcase
end
endmodule