`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module tb_PIPELINED_MUL;
parameter n=16,m=16;
wire[n+m-1:0] tb_Product;
reg tb_clk,
    tb_rst;
reg[15:0] tb_multiplicand,
          tb_multiplier;
PIPELINED_MUL DUT(.Product(tb_Product),
                .clk(tb_clk),
                .rst(tb_rst),
                .multiplicand(tb_multiplicand),
                .multiplier(tb_multiplier));     
              
initial tb_clk=1'b0;
always #10 tb_clk=~tb_clk;
integer i;
initial 
begin
tb_rst=1'b1;
#15 tb_rst=1'b0;
$monitor($time,"tb_Product=%b",tb_Product);
for(i=1;i<=25;i=i+1)
 begin
 
 tb_multiplicand={$random}%65000;
 tb_multiplier={$random}%75000;
 #20;
 end 
 
 #500 $finish;
end              
endmodule






`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module tb_PIPELINED_MUL;
parameter n=16,m=16;
wire[n+m-1:0] tb_Product;
reg tb_clk,
    tb_rst;
reg[15:0] tb_multiplicand,
          tb_multiplier;
PIPELINED_MUL DUT(.Product(tb_Product),
                .clk(tb_clk),
                .rst(tb_rst),
                .multiplicand(tb_multiplicand),
                .multiplier(tb_multiplier));     
              
initial tb_clk=1'b0;
always #10 tb_clk=~tb_clk;
integer i;
initial 
begin
tb_rst=1'b1;
#15 tb_rst=1'b0;
$monitor($time,"tb_Product=%b",tb_Product);
for(i=1;i<=25;i=i+1)
 begin
 
 tb_multiplicand={$random}%65000;
 tb_multiplier={$random}%75000;
 #20;
 end 
 
 #500 $finish;
end              
endmodule



