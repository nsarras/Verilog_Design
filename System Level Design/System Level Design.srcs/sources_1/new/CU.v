`timescale 1ns / 1ps

module CU(input CLK,
          input RST,
          input GO,
          input [1:0] OPC,
          output reg [3:0] CS,
          output reg [1:0] S1,
          output reg [1:0] WA,
          output reg WE,
          output reg [1:0] RAA,
          output reg REA,
          output reg [1:0] RAB,
          output reg REB,
          output reg [1:0] C,
          output reg S2,
          output reg DONE);

reg [3:0] NS;

initial
begin
    CS = 4'b0000;
    NS = 4'b0000;
end

always@(CS, GO)
begin
    case(CS)
        4'b0000:    NS = ((GO) ? 4'b0001 : 4'b0000);
        4'b0001:    NS = 4'b0010;
        4'b0010:    NS = 4'b0011;
        4'b0011:    begin
                        case(OPC)
                            2'b00:  NS = 4'b0111;
                            2'b01:  NS = 4'b0110;
                            2'b10:  NS = 4'b0101;
                            2'b11:  NS = 4'b0100;
                            default:    NS = 4'b0000;
                        endcase
                    end
        4'b0100:    NS = 4'b1000;
        4'b0101:    NS = 4'b1000;
        4'b0110:    NS = 4'b1000;
        4'b0111:    NS = 4'b1000;
        4'b1000:    NS = 4'b0000;
        default:    NS = 4'b0000;    
    endcase
end

always@(posedge CLK, posedge RST)
begin
    CS <= ((RST) ? 4'b0000 : NS);
end

always@(CS)
begin
    case(CS)
        4'b0000:    begin
                        S1 = 2'b01;
                        WA = 2'b00;
                        WE = 1'b0;
                        RAA = 2'b00;
                        REA = 1'b0;
                        RAB = 2'b00;
                        REB = 1'b0;
                        C = 2'b00;
                        S2 = 1'b0;
                        DONE = 1'b0;
                    end
        4'b0001:    begin
                        S1 = 2'b11;
                        WA = 2'b01;
                        WE = 1'b1;
                        RAA = 2'b00;
                        REA = 1'b0;
                        RAB = 2'b00;
                        REB = 1'b0;
                        C = 2'b00;
                        S2 = 1'b0;
                        DONE = 1'b0;
                    end
        4'b0010:    begin
                        S1 = 2'b10;
                        WA = 2'b10;
                        WE = 1'b1;
                        RAA = 2'b00;
                        REA = 1'b0;
                        RAB = 2'b00;
                        REB = 1'b0;
                        C = 2'b00;
                        S2 = 1'b0;
                        DONE = 1'b0;
                    end
        4'b0011:    begin
                        S1 = 2'b01;
                        WA = 2'b00;
                        WE = 1'b0;
                        RAA = 2'b00;
                        REA = 1'b0;
                        RAB = 2'b00;
                        REB = 1'b0;
                        C = 2'b00;
                        S2 = 1'b0;
                        DONE = 1'b0;
                    end
        4'b0100:    begin
                        S1 = 2'b00;
                        WA = 2'b11;
                        WE = 1'b1;
                        RAA = 2'b01;
                        REA = 1'b1;
                        RAB = 2'b10;
                        REB = 1'b1;
                        C = 2'b00;
                        S2 = 1'b0;
                        DONE = 1'b0;
                    end
        4'b0101:    begin
                        S1 = 2'b00;
                        WA = 2'b11;
                        WE = 1'b1;
                        RAA = 2'b01;
                        REA = 1'b1;
                        RAB = 2'b10;
                        REB = 1'b1;
                        C = 2'b01;
                        S2 = 1'b0;
                        DONE = 1'b0;
                    end
        4'b0110:    begin
                        S1 = 2'b00;
                        WA = 2'b11;
                        WE = 1'b1;
                        RAA = 2'b01;
                        REA = 1'b1;
                        RAB = 2'b10;
                        REB = 1'b1;
                        C = 2'b10;
                        S2 = 1'b0;
                        DONE = 1'b0;
                    end
        4'b0111:    begin
                        S1 = 2'b00;
                        WA = 2'b11;
                        WE = 1'b1;
                        RAA = 2'b01;
                        REA = 1'b1;
                        RAB = 2'b10;
                        REB = 1'b1;
                        C = 2'b11;
                        S2 = 1'b0;
                        DONE = 1'b0;
                    end
        4'b1000:    begin
                        S1 = 2'b01;
                        WA = 2'b00;
                        WE = 1'b0;
                        RAA = 2'b11;
                        REA = 1'b1;
                        RAB = 2'b11;
                        REB = 1'b1;
                        C = 2'b10;
                        S2 = 1'b1;
                        DONE = 1'b1;
                    end
    endcase
end
endmodule