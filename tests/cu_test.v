`include "states.v"

module cu_test;

reg clk, reset;
reg [0:15] ir_data;
wire [0:3] ra;
wire [0:7] adress;
wire [0:1] data_select;
wire [0:1] address_select;
wire [0:7]  address;

cu dut_cu( clk, reset, ir_data,
	data_select, address_select,
	sram_en, write_en,
	ir_load, gpr_load, ip_increment,
	ra, address, reset_internal 	   
);

always #50 clk=~clk;

initial begin
		$dumpfile("cu_test.vcd");
		$dumpvars(0,cu_test);
		$dumpon();
//		$monitor($time,"clk=%b\treset=%b\tir_data=%b", clk,reset,ir_data);
		
		clk=0;
		reset=0;
		ir_data=16'h130D;  // LOAD R3 A13
		
		#10	
		if( dut_cu.state === 9'bx ) 
			$display($time," ST_ UNKNOWN [OK]");
		else 
			$display($time," ST_ UNKNOWN [FAIL] %b", dut_cu.state);
		
		#10 reset=1; 

		#10		
		if( dut_cu.state == `ST_START ) 
			$display($time," ST_START [OK]");
		else 
			$display($time," ST_START [FAIL] %b", dut_cu.state);
		
		#10 reset =0;
		#20; // here first clock signal comes in

		if( dut_cu.state == `ST_IF1 ) 
			$display($time," ST_IF1 [OK]");
		else 
			$display($time," ST_IF1 [FAIL] %b", dut_cu.state);
		
		#100			
		if( dut_cu.state == `ST_IF2 ) 
			$display($time," ST_IF2 [OK]");
		else 
			$display($time," ST_IF2 [FAIL] %b", dut_cu.state);

		#100			
		if( dut_cu.state == `ST_DECODE ) 
			$display($time," ST_DECODE [OK]");
		else 
			$display($time," ST_DECODE [FAIL] %b", dut_cu.state);
				
				
		#100			
		if( dut_cu.state == `ST_LOAD1 ) 
			$display($time," ST_LOAD1 [OK]");
		else 
			$display($time," ST_LOAD1 [FAIL] %b", dut_cu.state);
				
		#100			
		if( dut_cu.state == `ST_LOAD2 ) 
			$display($time," ST_LOAD2 [OK]");
		else 
			$display($time," ST_LOAD2 [FAIL] %b", dut_cu.state);

		#100			
		if( dut_cu.state == `ST_ICREMENT ) 
			$display($time," ST_ICREMENT [OK]");
		else 
			$display($time," ST_ICREMENT [FAIL] %b", dut_cu.state);
		////////////////////////
		ir_data= 16'h210E;  // STORE R1 A14		

		$display("ir_data= 16'h210E // STORE R1 A14");

		#100
		if( dut_cu.state == `ST_IF1 ) 
			$display($time," ST_IF1 [OK]");
		else 
			$display($time," ST_IF1 [FAIL] %b", dut_cu.state);
		
		#100			
		if( dut_cu.state == `ST_IF2 ) 
			$display($time," ST_IF2 [OK]");
		else 
			$display($time," ST_IF2 [FAIL] %b", dut_cu.state);

		#100			
		if( dut_cu.state == `ST_DECODE ) 
			$display($time," ST_DECODE [OK]");
		else 
			$display($time," ST_DECODE [FAIL] %b", dut_cu.state);
				
		#100			
		if( dut_cu.state == `ST_STORE ) 
			$display($time," ST_STORE [OK]");
		else 
			$display($time," ST_STORE [FAIL] %b", dut_cu.state);
				
		#100			
		if( dut_cu.state == `ST_ICREMENT ) 
			$display($time," ST_ICREMENT [OK]");
		else 
			$display($time," ST_ICREMENT [FAIL] %b", dut_cu.state);
		
		////////////////////////
		ir_data= 16'hFF00;  // HALT		

		$display("ir_data= 16'hFF00 // HALT");			
						
		#400			
		if( dut_cu.state == `ST_HALT ) 
			$display($time," ST_HALT [OK]");
		else 
			$display($time," ST_HALT [FAIL] %b", dut_cu.state);

		////////////////////////
		ir_data= 16'h210E;  // STORE R1 A14				
		$display("ir_data= 16'h210E // STORE R1 A14");
		
		#100			
		if( dut_cu.state == `ST_HALT ) 
			$display($time," ST_HALT [OK]");
		else 
			$display($time," ST_HALT [FAIL] %b", dut_cu.state);
			
		#400			
		if( dut_cu.state == `ST_HALT ) 
			$display($time," ST_HALT [OK]");
		else 
			$display($time," ST_HALT [FAIL] %b", dut_cu.state);		
																		
		#1 $finish();
		$dumpoff();
	end

endmodule



