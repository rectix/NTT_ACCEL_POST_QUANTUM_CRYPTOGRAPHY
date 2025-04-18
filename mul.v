`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2025 11:29:26 PM
// Design Name: 
// Module Name: mul
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


module mul#(

                    parameter WIDTH    = 12,
                    parameter STAGE1  = 3'b001,
                    parameter STAGE2  = 3'b010,
                    parameter END  = 3'b011

)(
    input wire          clock_i,
    input wire          nreset_i,
    input wire [11:0]   a_i,
    input wire  [11:0]  b_i,
    output wire [23:0]  res_o
    );
    
//=============================================================================
//INTERNAL SIGNALS 
//=============================================================================

    
    reg [2:0]    futur;
    integer      shift;
    reg [23:0]  prod;

    
    assign res_o = prod;


//=============================================================================
// SYNC LOGIC
//=============================================================================

 always@(posedge clock_i or negedge nreset_i) begin   
    
    if(!nreset_i)  begin 

        prod      <= 0; 
        futur     <= STAGE1 ; 
        shift     <=  0;
         
    
    end else  begin
  
    case(futur)
    
    STAGE1: begin
    if((b_i >> shift) == 0) begin futur <= END;  end 
    else begin
    
    
    if((b_i >> shift) & 1) begin  prod <= prod + (a_i << shift);  end
    
    end
    
     shift <= shift + 1;  
     futur <= STAGE1;

    end 
        
    END: begin 
    end 
    
   default : prod <= b_i;    
        
  endcase 
  end 
  end 
    

endmodule
