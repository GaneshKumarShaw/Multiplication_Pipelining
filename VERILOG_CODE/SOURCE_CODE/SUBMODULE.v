`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module SUBMODULE(acc_in,
                 md_in,
                 mr_in,
                 clk,
                 rst,
                 acc_out,
                 md_out,
                 mr_out);
parameter n=16, // multiplicand width size
          m=16; // multiplier width size
output [n-1:0] acc_out;
output [n-1:0] md_out;
output [m-1:0] mr_out;

input clk,
      rst;
input[n-1:0] acc_in;
input[n-1:0] md_in;
input[m-1:0] mr_in;

//adder wire instantiation 
wire[n:0] ad_data_out;
wire[n-1:0] ad_data0,
            ad_data1;
            
// mux wire instantiation 
wire[n:0] mux_data_out,
          mux_data0,
          mux_data1;
wire mux_sel;

///
reg[n-1:0] accumulator,
           multiplicand;
reg[m-1:0] multiplier;


///            
// adder instantaition             
ADDER16BIT ad(.data_out(ad_data_out),
                  .data0(ad_data0),
                  .data1(ad_data1));
assign ad_data0=accumulator;
assign ad_data1=multiplicand;
// mux instantiation 
MUX17BIT2_1 mux(.data_out(mux_data_out),
                   .data0(mux_data0),
                   .data1(mux_data1),
                   .sel(mux_sel)); 
assign mux_data0={1'b0,accumulator};
assign mux_data1=ad_data_out;
assign mux_sel=multiplier[0];
                                   
always @(posedge clk)
begin
if(rst)
begin
 accumulator<=16'b0;
 multiplicand<=16'b0;
 multiplier<=16'b0;
end 
else
begin
 accumulator<=acc_in;
 multiplicand<=md_in;
 multiplier<=mr_in;
end
end 

// out declarattion  
assign acc_out=mux_data_out[16:1];
assign md_out=multiplicand;
assign mr_out={mux_data_out[0],multiplier[15:1]};                          
endmodule
