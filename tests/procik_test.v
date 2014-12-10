module procik_test;
reg clk, reset;



procik(clk,reset);

always #5 clk = ~clk;

initial 
 begin
   clk=0; reset =0; 
   #4 reset =1;
   #6 reset = 0;
   #450 $finish();

 end



endmodule
