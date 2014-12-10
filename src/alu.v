 `timescale 1 ns / 1ns

module alu (a, b, clk, rst, ctrl, en, out, valid);

input  [3:0] a;
input  [3:0] b;
input        clk;
input        rst;
input  [1:0] ctrl;
input        en;
output wire [7:0] out;
output wire      valid;
reg    [7:0] out_r, out_nxt;
reg    valid_r, valid_nxt;
	
always @ (posedge clk or negedge rst)		
  begin
 	if (!rst)
	begin  
		out_r <= 8'b0;
		valid_r <= 1'b0;
	end
	else 
 begin

	case (ctrl)
		2'd0 : begin
				out_nxt <= a+b;
				valid_nxt <=1'b1;
			 end
		2'd1 : begin
				out_nxt <= a-b;
				valid_nxt <=1'b1;
			 end
		2'd2 : begin
				out_nxt <= a*b;
				valid_nxt <=1'b1;
			 end
		2'd3 : begin
				out_nxt <= a/b;
				valid_nxt <=1'b1;
			 end
        default : begin
				out_nxt <= 8'b0;
				valid_nxt <=1'b0;
			 end
	endcase


if (en)
		begin
		out_r <= out_nxt;
		valid_r <= valid_nxt;
		end
	else
		begin
		out_r <= out_r;
		valid_r <= valid_r;
		end
  end
 end 
assign out = out_r;
assign valid = valid_r;

endmodule
