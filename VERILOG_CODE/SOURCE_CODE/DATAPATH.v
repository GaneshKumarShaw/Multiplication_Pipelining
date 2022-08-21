`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


module DATAPATH(Product,
                done,
                clk,
                multiplicand,
                multiplier,
                start,
                rst);
parameter n=16,    //n:multiplicand width
          m=16 ;  // m:multiplier width  
output[m+n-1:0] Product;
output reg done;
input[n:0] multiplicand;
input[m:0] multiplier;
input clk,
      start,
      rst;
                                     
// controller wire instantiation 
wire cr_load,
     cr_loadAC,
     cr_rstAC,
     cr_shift,
     cr_count16set,
     cr_count16reset,
     cr_clk,
     cr_start,
     cr_rst,
     cr_count16done; 
//counter wire instantiation 
wire ct_counter16done,
     ct_count16set,
     ct_count16reset,
     ct_rst,
     ct_clk;
     
// multiplicand register wire instantiation 
wire[n-1:0] md_data_out,
            md_data_in;
wire md_clk,
     md_load,
     md_rst;   
// adder wire instantiation 
wire[n:0] add_data_out;
wire[n-1:0] add_data0,
            add_data1;  
// mux wire instantiatiion 
wire[n:0] mux_data_out,
          mux_data0,
          mux_data1;   
// accumulator wire instantiation 
wire[n-1:0] ac_data_out,
          ac_data_in;  
wire ac_clk,
     ac_rstAC,
     ac_loadAC,
     ac_rst;    
// multiplier wire instantiation 
wire[m-1:0] mr_data_out,
            mr_data_in;
wire mr_clk,
     mr_shift_in,
     mr_load,
     mr_shift,
     mr_rst;                          
// controller instantiation              
CONTROLLER controller(.load(cr_load),
                  .loadAC(cr_loadAC),
                  .rstAC(cr_rstAC),
                  .shift(cr_shift),
                  .count16set(cr_count16set),
                  .count16reset(cr_count16reset),
                  
                  .clk(cr_clk),
                  .start(cr_start),
                  .rst(cr_rst),
                  .count16done(cr_count16done)); 
assign cr_clk=clk;
assign cr_rst=rst;
assign cr_start=start;
assign cr_count16done=ct_count16done;


// counter instantiation 
COUNTER16 ct(.count16done(ct_count16done), // one bit output
                 .count16set(ct_count16set),  // one bit input
                 .count16reset(ct_count16reset),
                 .rst(ct_rst),
                 .clk(ct_clk));
assign ct_count16set=cr_count16set;
assign ct_count16reset=cr_count16reset;
assign ct_rst=rst;
assign ct_clk=clk;


// multiplicand register  instantiation 
PIPO16BITS md(.data_out(md_data_out),
                  .clk(md_clk),
                  .data_in(md_data_in),
                  .load(md_load),
                  .rst(md_rst));  
assign md_clk=clk;                    
assign md_data_in=multiplicand;
assign md_load=cr_load;
assign md_rst=rst;


// adder  instantiation             
ADDER16BIT adder(.data_out(add_data_out),
                  .data0(add_data0),
                  .data1(add_data1));
assign add_data0=md_data_out;
assign add_data1=ac_data_out;


// mux  instantiatiion           
MUX17BIT2_1 mux(.data_out(mux_data_out),
                   .data0(mux_data0),
                   .data1(mux_data1),
                   .sel(mux_sel));
assign mux_data0={1'b0,ac_data_out};
assign mux_data1=add_data_out;
assign mux_sel=mr_data_out[0]; 

         
// accumulator  instantiation 
RPIPO16BITS ac(.data_out(ac_data_out),
                   .clk(ac_clk),
                   .data_in(ac_data_in),
                   .Rrst(ac_rstAC),
                   .load(ac_loadAC),
                   .rst(ac_rst)); 
assign ac_clk=clk;
assign ac_data_in=mux_data_out[n:1];
assign ac_rstAC=cr_rstAC;
assign ac_loadAC=cr_loadAC;
assign ac_rst=rst;

// multiplier  instantiation
PISO16BITS mr(.data_out(mr_data_out),
                 .clk(mr_clk),
                 .data_in(mr_data_in),
                 .shift_in(mr_shift_in),
                 .load(mr_load),
                 .shift(mr_shift),
                 .rst(mr_rst));  
assign mr_clk=clk;
assign mr_data_in=multiplier;
assign mr_shift_in=mux_data_out[0];
assign mr_load=cr_load;
assign mr_shift=cr_shift;
assign mr_rst=rst;   

//outpur declaration 
assign Product={ac_data_out,mr_data_out};

always @(posedge clk)
if(rst)
 done<=1'b0;
else
 done<=ct_count16done; 
                                                                                                                   
endmodule





