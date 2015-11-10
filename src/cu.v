`include "states.v"

module cu( clk, reset, ir_data,
	data_select, address_select,
	sram_en, write_en,
	ir_load, gpr_load, ip_increment,
	ra, address, reset_internal 	   
);
/*
parameter 
 	START=0, IF1 = 1, IF2 = 10, DECODE =20,  
	LOAD1 =30, LOAD2=40, 
	ICREMENT=50, STORE =60, HALT=70;
*/

parameter MEM_WRITE=0, MEM_READ=1, MEM_ENABLE=0, MEM_DISABLE=1;
parameter DBUS_MEM=2'b00, DBUS_GPR=2'b01;
parameter ABUS_IP=2'b00, ABUS_CU=2'b01;

reg [0:8] state;

input clk, reset;
input [0:15] ir_data;
output reg [0:1] data_select, address_select;
output reg 
	sram_en, write_en,
	ir_load, gpr_load, ip_increment,	
	reset_internal;

reg [0:3] opcode;
output reg [0:3] ra;
output reg [0:7] address;


//always @(posedge reset) 
//	state=START;

always @(posedge clk or posedge reset) 
 if (reset) 
	state = `ST_START;
 else
  case (state) 
    `ST_START:	begin
    		reset_internal = 0; 
 			state=`ST_IF1;
		end

    `ST_IF1  :	begin
			reset_internal = 1; 
			address_select = ABUS_IP;
			sram_en  = MEM_ENABLE;  
			write_en = MEM_READ;
			ip_increment =0;
			state = `ST_IF2; 
		end

    `ST_IF2  :	begin
			sram_en  = MEM_DISABLE;
			ir_load = 1; 
			data_select = DBUS_MEM;
			state = `ST_DECODE;
		end  
               
   `ST_DECODE:	begin
			{opcode, ra, address}  = ir_data;
			ir_load = 0;			 
			case (opcode) 
				4'b0001: state = `ST_LOAD1;
				4'b0010: state = `ST_STORE;
				4'b1111: state = `ST_HALT;			
			endcase
		end  

    `ST_LOAD1:	begin
			sram_en=MEM_ENABLE; 
			write_en = MEM_READ; 
			address_select= ABUS_CU; 
			data_select = DBUS_MEM;	 
			state = `ST_LOAD2;		
		end
		  
    `ST_LOAD2:	begin
			gpr_load =1; 
			sram_en=MEM_DISABLE;  
			state = `ST_ICREMENT;	
		end  
		
    `ST_STORE:	begin
			data_select   = DBUS_GPR;
			address_select = ABUS_CU;
			
			sram_en=   MEM_ENABLE;  
			write_en = MEM_WRITE;
			state = `ST_ICREMENT;			
		end  
				
    `ST_ICREMENT:	begin
			gpr_load =0;
			ip_increment =1;  
			state = `ST_IF1;	
		end      
		      
    `ST_HALT:	begin
			state = `ST_HALT;		
		end  		
  endcase
  
endmodule


