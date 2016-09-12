`timescale 1ns / 1ps



module TB_CLA;
    reg [3:0] A;
    reg [3:0] B;
    wire [4:0] exp_sum;
   // reg co;
    
    
//     CLA_ADDER DUT (   
//          .a(A),
//          .b(B)
          
//          );
          
//     CLA DUT (
//        .co(co)
//     );     
          
     SUM_CLA DUT(
        .sum(exp_sum),
        .A(A),
        .B(B)
             );
    
    
    
    integer countA=0;
    integer countB=0;
    integer exp_solution=0;
    integer check =0;
    
    initial begin
    
    
    
    for(countA = 0; countA<16; countA = countA+1)     // Nested for loops test every possible input 
    begin
        A = countA;
    for(countB = 0; countB<16; countB= countB+1)
    begin 
        B = countB;
        exp_solution = A + B;
        if(exp_solution > 15)                       // Check to see if a carry bit is required
        begin 
        check = exp_sum +32;                        // Add 32 if there is a carry bit to represent 2^5
        end
        
        if(check != exp_solution)                  // Final check of expected solution versus actual sum
        begin 
        $display("Sum does not match! Error");
        $stop; 
        end
    
    end
    end
    
    
end  

endmodule

