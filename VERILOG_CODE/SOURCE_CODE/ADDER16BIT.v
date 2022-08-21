`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module ADDER16BIT(data_out,
                  data0,
                  data1);
parameter n=16;   // multiplicand width size                  
output[n:0] data_out;
input[n-1:0] data0,
            data1;
assign data_out={1'b0,data0}+{1'b0,data1};                        
endmodule
