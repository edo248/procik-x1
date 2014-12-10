module mux1x8 (
	 select,data1,data2,data3,data4,data5,data6,data7,data8,out);
parameter N=8;
parameter S=3;
input [0:N-1] data1,data2,data3,data4,
	data5,data6,data7,data8;
input [0:S-1] select;
output reg [0:N-1] out;
always @(*)
begin
	case(select)
		3'd0:	out = data1;
		3'd1:	out = data2;
		3'd2:	out = data3;
		3'd3:	out = data4;
		3'd4:	out = data5;
		3'd5:	out = data6;
		3'd6:	out = data7;
		3'd7:	out = data8;	
	endcase
end 
endmodule