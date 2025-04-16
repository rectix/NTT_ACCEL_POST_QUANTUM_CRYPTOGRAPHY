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

                    parameter IDLE   = 2'b00,
                    parameter CALC  = 2'b01,
                    parameter CHECK  = 2'b10,
                    parameter ISSUE  = 2'b11
                         
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
    
    
    reg [1:0]  futur;
   
    
    
    
    reg [WIDTH-1:0]  k_shift, n,m;
    reg [WIDTH-1:0]  tmp;
    reg [WIDTH-1:0]  result_rg; 
    
    reg [WIDTH-1:0]  a_rg   ;
    
    //==================================================================
    //      OUTPUT ASSIGNEMENT 
    //==================================================================
    assign res_o = result_rg;
    
    

    //==================================================================
    
    always@(posedge clock_i or negedge nreset_i ) 
    begin
   
  
    
    if(!nreset_i)  begin 
    
        a_rg        <= {WIDTH{1'b0}};
        result_rg   <= {WIDTH{1'b0}};
        tmp         <= q_i;
        k_shift     <= {WIDTH{1'b0}};
        n           <= {WIDTH{1'b0}};
            
        futur       <= IDLE ; 
    
    end else  begin

    case(futur)
    
    IDLE: begin
        result_rg <= 12'b0;  
        
        k_shift     <=  k_shift  + 1'b1; 
        futur  <= CALC; 
        
        end 
        
        
        
                
    CALC : begin
        result_rg <= 12'b0; 

        if((k_shift >> 1) & 1)begin 
            tmp <= (q_i << (k_shift >> 1)) + q_i;
            futur <= CHECK; 
        
        end else begin
            tmp <= (q_i << (k_shift >> 1));
            futur <= CHECK; 
        end 
        

        end 
        
    CHECK: begin
        a_rg <= a_i - tmp;
        result_rg <= 12'b0;
        
        if(a_rg  > (q_i << 1)) begin  futur  <=  IDLE;  end
        else begin result_rg <= a_rg - q_i; end  
      
        end 
 
       

    default: result_rg <= a_i;
    
    endcase
    end
    end //always 
    

    
endmodule
