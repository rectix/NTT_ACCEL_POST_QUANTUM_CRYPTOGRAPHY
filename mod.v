`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2025 10:09:54 PM
// Design Name: 
// Module Name: mod
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


module mod#(
                    parameter WIDTH    = 12,
                    parameter STAGE1  = 3'b000,
                    parameter STAGE2  = 3'b001,
                    parameter END  = 3'b010

)(
    input        clock_i,
    input        nreset_i,
    
    input [11:0] a_i,
    input [11:0] q_i,
    output [11:0] amodq_o
    );
    
    
      
    reg      [11:0]     result_reg , out_reg, tmp;
    integer             count;
    reg      [2:0]      futur;
    
    
    assign  amodq_o = out_reg;
    
    always@(posedge clock_i or negedge nreset_i ) 
    begin
   
  
    
    if(!nreset_i)  begin 

        result_reg      <= 0; 
        out_reg         <= 0; 
        tmp             <= 0; 
        count           <= 0;
        futur           <= STAGE1 ; 
    
    end else  begin
  
    case(futur)
    
    STAGE1: begin
       if(a_i < q_i) begin out_reg <= a_i; futur <= END; end
       else begin
       result_reg <= tmp;
       tmp         <=       tmp + q_i; 
       count       <=       count + 1 ;  
       futur       <=       STAGE2; 
        end 
        end 
        
    STAGE2: begin
        
        if(tmp < a_i) begin futur <= STAGE1; end 
        else begin out_reg <=a_i-result_reg ;  futur <= END; end 
    
    end 
    
    END: begin
    
        
    
    end 
    
       
    default : result_reg <= a_i;    
        
  endcase 
  end 
  end 
    
    
    
    
    
    
 
    
endmodule
