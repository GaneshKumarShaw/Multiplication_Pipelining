`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module MUX17BIT2_1(data_out,
                   data0,
                   data1,
                   sel);
parameter n=16;  // multiplicand bits + 1                  
output[n:0] data_out;
input[n:0] data0,        
            data1;
input sel;

assign  data_out=sel?data1:data0;                   
endmodule