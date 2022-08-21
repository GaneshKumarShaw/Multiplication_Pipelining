`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2022 05:21:02 PM
// Design Name: 
// Module Name: RPIPO
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


`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module RPIPO16BITS(data_out,
                   clk,
                   data_in,
                   Rrst,
                   load,
                   rst);
parameter n=16;         // multiplier width size  
               
output reg[n-1:0] data_out;
input[n-1:0] data_in;
input load,
      Rrst,
      clk,
      rst;
always @(posedge clk)
 begin
  if(rst)
   data_out<=16'b0;
  else if(Rrst)
   data_out<=16'b0;
  else if(load)
   data_out<=data_in;
  else
   data_out<=data_out;
 end                              
endmodule


