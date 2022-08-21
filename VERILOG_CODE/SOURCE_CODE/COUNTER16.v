`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module COUNTER16(count16done, // one bit output
                 count16set,  // one bit input
                 count16reset,
                 rst,
                 clk);
output  count16done;  
input count16set,
      count16reset,
      rst,
      clk;
reg[4:0] count;
assign count16done=count[4];
always @(posedge clk)
begin
 if(rst)
  count<=5'b00001;
 else if(count16reset) 
  count<=5'b00001;
 else if(count16set)
  count<=count+1;
 else
  count<=count;
end               
endmodule
