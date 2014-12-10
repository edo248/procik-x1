module cu_test;

reg clk, reset;
reg [0:15] ir_data;
wire [0:3] ra;
wire [0:7] adress;
cu( clk, reset, ir_data,
	data_select, adress_select,
	sram_en, write_en,
	ir_load, gpr_load, ip_increment,
	ra, adress, reset_internal 	   
);

always #5 clk=~clk;
initial begin
		clk=0;reset=0;ir_data=16'h1305;
		#5 reset=1; #7 reset =0;
		#100 $finish();
	end

endmodule



