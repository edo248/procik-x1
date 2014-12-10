module DEC(out, in, en, clk);

parameter IN_SIZE = 3;

input [IN_SIZE-1 : 0] in;
input clk, en;

output [2**IN_SIZE-1 : 0] out;

reg [2**IN_SIZE-1 : 0] out;

always @ (posedge clk)
	if(en)
	begin
		out = 0;
		out[in] = 1;
	end
	else
		out = 0;

endmodule


