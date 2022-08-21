`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module PISO16BITS(data_out,
                 clk,
                 data_in,
                 shift_in,
                 load,
                 shift,
                 rst);
parameter m=16;         // multiplier width size  
               
output reg[m-1:0] data_out;
input[m-1:0] data_in;
input load,
      shift,
      shift_in,
      clk,
      rst;
always @(posedge clk)
 begin
  if(rst)
   data_out<=16'b0;
  else if(load)
   data_out<=data_in;
  else if(shift)
   data_out<={shift_in,data_out[15:1]}; 
  else
   data_out<=data_out;
 end                              
endmodule


