`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

module PIPELINED_MUL(Product,
                   //done,
                     clk,
                     rst,
                     multiplicand,
                     multiplier);
parameter n=16,   // multiplicand width size
          m=16;  //  multiplier  width size 
output[n+m-1:0] Product;
//output done
input[n-1:0] multiplicand;
input[m-1:0] multiplier;
input clk,
      rst;
// submodule wire instantiation  
wire[n-1:0] m0_acc_in,
            m0_md_in,
            m0_acc_out,
            m0_md_out;
wire[m-1:0] m0_mr_in,
            m0_mr_out;
wire m0_clk,
     m0_rst;  
     
// wire for loop      
wire[0:m-1] m_acc_out[n-1:0];
wire[0:m-1] m_md_out[n-1:0];
wire[0:m-1] m_mr_out[m-1:0];   

                     
SUBMODULE m0(.acc_in(m0_acc_in),
                 .md_in(m0_md_in),
                 .mr_in(m0_mr_in),
                 .clk(m0_clk),
                 .rst(m0_rst),
                 .acc_out(m0_acc_out),
                 .md_out(m0_md_out),
                 .mr_out(m0_mr_out)); 
assign m0_acc_in=16'b0;
assign m0_md_in=multiplicand;
assign m0_mr_in=multiplier;
assign m0_clk=clk;
assign m0_rst=rst;  


assign m_acc_out[0]=m0_acc_out;
assign m_md_out[0]=m0_md_out;
assign m_mr_out[0]=m0_mr_out;

genvar i;
generate 
 for(i=1;i<m;i=i+1)
  begin
   SUBMODULE m( m_acc_out[i-1], //acc_in,
                m_md_out[i-1], //md_in,
                m_mr_out[i-1], //mr_in,
                clk,           //clk,
                rst,           //rst,
                m_acc_out[i],  //acc_out,
                m_md_out[i],   // md_out,
                m_mr_out[i]);   // mr_out);
                
  end
endgenerate  

// output initialization 
assign Product = {m_acc_out[m-1],m_mr_out[m-1]};   
           
endmodule
