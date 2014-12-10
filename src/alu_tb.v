 `timescale 1 ns / 1ns

module alu_testbench ();
reg  [3:0] a;
reg  [3:0] b;
reg		   clk;
reg		   rst;
reg  [1:0] ctrl;
reg		   en;
wire [7:0] out;
wire       valid;

initial 
    begin
   		rst = 1'b0;
		clk = 1'b0;  
    	#1 rst = 1'b1;  
		#1 rst = 1'b1; 
		en = 1'b1;
    	a = 4'b1110;
		b = 4'b0111;
    	ctrl = 2'b00;
    	#20 ctrl = 2'b01;
    	#15 ctrl = 2'b10;
    	#20 ctrl = 2'b11;
    	#40 a = 4'b1100;
		b = 4'b0110;
    	#2 ctrl = 2'b00;
		#4 en = 1'b0;
    	#20 ctrl = 2'b01;
		#40 rst = 1'b0; 
		#1 rst = 1'b1; 
    	#15 ctrl = 2'b10;
   		#110 $stop;
	end
	always #10 clk = ~clk;
	
alu my_alu ( 
	.a(a),
	.b(b),
	.clk(clk),
	.rst(rst),
	.ctrl(ctrl),
	.en(en),
	.out(out),
	.valid(valid)
	);

endmodule
