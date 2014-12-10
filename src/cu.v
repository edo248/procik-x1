module cu( clk, reset, ir_data,
	data_select, adress_select,
	sram_en, write_en,
	ir_load, gpr_load, ip_increment,
	ra, adress, reset_internal 	   
);
parameter 
 	START=0, IF1 = 1, IF2 = 10, DECODE =20,  
	LOAD1 =30, LOAD2=40, 
	ICREMENT=50, STORE =60, HALT=70;

parameter MEM_WRITE=0, MEM_READ=1, MEM_ENABLE=0, MEM_DISABLE=1;
parameter DBUS_MEM=2'b00, DBUS_GPR=2'b01;
parameter ABUS_IP=2'b00, ABUS_CU=2'b01;

reg [0:8] state;

input clk, reset;
input [0:15] ir_data;
output reg [0:1] data_select, adress_select;
output reg 
	sram_en, write_en,
	ir_load, gpr_load, ip_increment,	
	reset_internal;

reg [0:3] opcode;
output reg [0:3] ra;
output reg [0:7] adress;


//always @(posedge reset) 
//	state=START;

always @(posedge clk or posedge reset) 
 if (reset) 
	state = START;
 else
  case (state) 
    START:	begin
    			reset_internal = 0; 
 			state=IF1;
		end

    IF1  :	begin
			reset_internal = 1; 
			adress_select = ABUS_IP;
			sram_en  = MEM_ENABLE;  
			write_en = MEM_READ;
			ip_increment =0;
			state = IF2; 
		end

    IF2  :	begin
			sram_en  = MEM_DISABLE;
			ir_load = 1; 
			data_select = DBUS_MEM;
			state = DECODE;
		end  
               
    DECODE:	begin
			{opcode, ra, adress}  = ir_data;
			ir_load = 0;			 
			case (opcode) 
				4'b0001: state = LOAD1;
				4'b0010: state = STORE;
				4'b1111: state = HALT;			
			endcase
		end  

    LOAD1:	begin
			sram_en=0; 
			write_en = MEM_READ; 
			adress_select= ABUS_CU; 
			data_select = DBUS_MEM;	 
			state = LOAD2;		
		end
		  
    LOAD2:	begin
			gpr_load =1; 
			sram_en=1;  
			state = ICREMENT;	
		end  
		
    STORE:	begin
			data_select   = DBUS_GPR;
			adress_select = ABUS_CU;
			
			sram_en=   MEM_ENABLE;  
			write_en = MEM_WRITE;
			state = ICREMENT;			
		end  
				
    ICREMENT:	begin
			gpr_load =0;
			ip_increment =1;  
			state = IF1;	
		end      
		      
    HALT:	begin
			state = HALT;		
		end  		
  endcase
  
endmodule


