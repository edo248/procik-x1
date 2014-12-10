module decoder_comb(out, in, en);

parameter IN_SIZE = 3;

input [IN_SIZE-1 : 0] in;
input en;

output [2**IN_SIZE-1 : 0] out;

reg [2**IN_SIZE-1 : 0] out;

always @ (*)
	if(en)
	begin
		out = 0;
		out[in] = 1;
	end
	else
		out = 0;

endmodule


