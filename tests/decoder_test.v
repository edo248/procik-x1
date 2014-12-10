module DEC_test;

parameter IN_SIZE=3;

reg clk, en;
reg [IN_SIZE-1 : 0]in;
wire [2**IN_SIZE-1 : 0] out;

DEC decoder(out, in, en, clk);

defparam decoder.IN_SIZE=3;

initial begin
clk=0; en=0;
#5 in=2;
#5 en=1;
#5 in=0;
#5 in=7;
#50 $finish;
end
always #5 clk=~clk;
endmodule
