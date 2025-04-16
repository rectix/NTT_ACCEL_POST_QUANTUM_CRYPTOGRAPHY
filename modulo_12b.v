`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2025 02:53:08 PM
// Design Name: 
// Module Name: modulo_12b
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


module modulo_12b #(parameter WIDTH  =12 ,
            //==================================================================
            //      FSM  STATES
            //==================================================================

                    parameter STAGE1  = 1'b0,
                    parameter STAGE2  = 1'b1

)(
    input wire clock_i,
    input wire nreset_i,


    input       wire  [WIDTH-1:0] q_i,
    input       wire  [WIDTH-1:0] a_i,
    output      wire  [WIDTH-1:0] res_o
    
    
    
    );
    
    //==================================================================
    //     INTERNAL SIGNALS  
    //==================================================================
    
    
    reg   futur;
   
    
    
    
    reg [WIDTH-1:0]  k_shift;  
    reg [WIDTH-1:0]  a_rg   ;
    
    //==================================================================
    //      OUTPUT ASSIGNEMENT 
    //==================================================================
    assign res_o = a_rg;
    
    

    //==================================================================
    
    always@(posedge clock_i or negedge nreset_i ) 
    begin
   
  
    
    if(!nreset_i)  begin 
    
        a_rg        <= {WIDTH{1'b0}};
        k_shift     <= {WIDTH{1'b0}};

            
        futur       <= STAGE1 ; 
    
    end else  begin

    case(futur)
    
    STAGE1: begin
      
        k_shift     <=  k_shift  + 1'b1; 
        futur  <= STAGE2; 
        
        end 
        
        
        
                
    STAGE2 : begin
        a_rg <= a_i - (q_i << (k_shift >> 1)) - q_i;  
        if(a_rg  > q_i ) begin  futur  <=  STAGE1;  end
            
        end 
 

    default: a_rg <= a_i;
    
    endcase
    end  //nreset
    end //always 
    

    
endmodule
