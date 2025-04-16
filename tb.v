`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2025 05:15:47 PM
// Design Name: 
// Module Name: tb
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


module modulo_12b_tb;

  // Parameters
  localparam WIDTH = 12;

  // Testbench signals
  reg clock_i;
  reg nreset_i;
  reg [WIDTH-1:0] q_i;
  reg [WIDTH-1:0] a_i;
  wire [WIDTH-1:0] res_o;

  // Instantiate the DUT (Device Under Test)
  modulo_12b #(.WIDTH(WIDTH)) uut (
    .clock_i(clock_i),
    .nreset_i(nreset_i),
    .q_i(q_i),
    .a_i(a_i),
    .res_o(res_o)
  );

  // Clock generation
  always #10 clock_i = ~clock_i; 

  // Test sequence
  initial begin
    // Init signals
    clock_i   = 0;
    nreset_i  = 0;
    q_i       = 0;
    a_i       = 0;

    // Apply reset
    #40;
    nreset_i = 1;

    // Test case 1: a = 91, q = 17 → 91 % 17 = 6
    #10;
    a_i = 12'd91;
    q_i = 12'd17;

   #500;

    $display("Test Case 1: a = %d, q = %d, result = %d", a_i, q_i, res_o);

 
    $finish;
  end

endmodule

