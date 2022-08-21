`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module CONTROLLER(load,
                  loadAC,
                  rstAC,
                  shift,
                  count16set,
                  count16reset,
                  
                  clk,
                  start,
                  rst,
                  count16done);
output reg load,
           loadAC,
           rstAC,
           shift,
           count16set,
           count16reset;
input clk,
      rst,
      start,
      count16done;
parameter S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;  
reg[1:0] ps,ns;
always @(posedge clk)
begin
 if(rst)
  ps<=S0;
 else
  ps<=ns;
end    

always @(*)
begin
case(ps)
S0: begin
     rstAC=1'b1;
     loadAC=1'b0;
     load=1'b0;
     shift=1'b0;
     count16set=1'b0;
     count16reset=1'b1;  
     if(start)
      ns=S1;
     else
      ns=S0;
    end
S1: begin
     rstAC=1'b1;
     loadAC=1'b0;
     load=1'b1;
     shift=1'b0;
     count16set=1'b0;
     count16reset=1'b1; 
     
     ns=S2;
    end 
S2: begin
     rstAC=1'b0;
     loadAC=1'b1;
     load=1'b0;
     shift=1'b1;
     count16set=1'b1;
     count16reset=1'b0; 
     if(count16done)
      ns=S3;
     else
      ns=S2; 
    end   
S3: begin
     rstAC=1'b0;
     loadAC=1'b0;
     load=1'b0;
     shift=1'b0;
     count16set=1'b0;
     count16reset=1'b1;
     if(start)
      ns=S1;
     else
      ns=S3;
    end 
default: begin
          rstAC=1'b1;
          loadAC=1'b0;
          load=1'b0;
          shift=1'b0;
          count16set=1'b0;
          count16reset=1'b1;
          
          ns=S0;
         end 
endcase                       
end                             
                                      
endmodule
