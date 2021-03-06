`timescale 1ns / 1ps

module edge_shifter_tb;

reg CLK;
reg [2:0] Ctrl;
reg [3:0] D_in;

wire [3:0] D_out;
reg [3:0] result;

integer a;
integer b;
reg [3:0] testInput;
reg [2:0] testCtrl;

edge_shifter U1 (.CLK(CLK),
                 .Ctrl(Ctrl),
                 .D_in(D_in),
                 .D_out(D_out));
                 
shifter_behav U2(.clk(CLK), 
                 .in(D_in), 
                 .out(D_out), 
                 .ctrl(Ctrl));                 

initial 
begin

CLK = 0;
Ctrl = 0;
D_in = 0;

for (a = 0; a < 16; a = a + 1) 
    begin
        testInput <= a;
        for (b = 0; b < 8; b = b + 1)
            begin
                testCtrl <= b;
                Ctrl <= b;
                D_in <= a;
                #10;
                case(b)
                    3'b000: result = a;
                    3'b001: result = a >> 1;
                    3'b010: result = a >> 2;
                    3'b011: result = a >> 3;
                    3'b100: result = 4'b0;
                    3'b101: result = {a[0], a[3:1]};
                    3'b110: result = {a[1:0], a[3:2]};
                    3'b111: result = {a[2:0], a[3]};
                    default: result = 4'bz;
                endcase
                
                
                
                #10;
                
                CLK = 1;
                #10;
                CLK = 0;
                #10;
                
                if (D_out != result)
                    begin
                        $display("Test Failed!");
                        $display("Ctrl = %b", b);
                        $display("D_in = %b", a);
                        $display("D_out = %b", D_out);
                        $display("Expected Result = %b", result);
                        
                    end
            end //end of inner for loop
    end //end of outer for loop
                
$display("Test Passed!");                

end

endmodule