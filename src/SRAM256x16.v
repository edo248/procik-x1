`timescale 1ns/100fs

`define numAddr 8
`define numWords 256
`define wordLength 16


module SRAM256x16 (A1,CE1,WEB1,OEB1,CSB1,I1,O1);

input 				CE1;
input 				WEB1;
input 				OEB1;
input 				CSB1;

input 	[`numAddr-1:0] 		A1;
input 	[`wordLength-1:0] 	I1;
output 	[`wordLength-1:0] 	O1;

reg    	[`wordLength-1:0]   	memory[`numWords-1:0];
reg  	[`wordLength-1:0]	data_out1;
reg 	[`wordLength-1:0] 	O1;

wire 				RE1;
wire 				WE1;


and u1 (RE1, ~CSB1,  WEB1);
and u2 (WE1, ~CSB1, ~WEB1);


always @ (posedge CE1) 
	if (RE1)
		data_out1 = memory[A1];
	else 
	   if (WE1)
		memory[A1] = I1;
		

always @ (data_out1 or OEB1)
	if (!OEB1) 
		O1 = data_out1;
	else
		O1 =  16'bz;

///////////////////////////////////////////////////////
//    LOADING MEMORY
///////////////////////////////////////////////////////
initial begin
	//program code
	memory[0] = 16'h110B;  // LOAD R1 A11
	memory[1] = 16'h120C;  // LOAD R2 A12
	memory[2] = 16'h130D;  // LOAD R3 A13
	memory[3] = 16'h210E;  // STORE R1 A14
	memory[4] = 16'h220F;  // STORE R2 A15 
	
	//just data
	memory[11] = 16'h000F;  // 15
	memory[12] = 16'h00F0;  // 240
	memory[13] = 16'hFF00;  // 65280
	
	end

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

endmodule
