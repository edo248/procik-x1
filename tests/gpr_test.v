module gpr_test;
reg clk, reset, load;
reg [3:0]write_select;
reg [15:0]d_in;
wire [15:0]r_out0, r_out1, r_out2, r_out3, r_out4, r_out5, r_out6, r_out7;
gpr GPR1(r_out0, r_out1, r_out2, r_out3, r_out4, r_out5, r_out6, r_out7, d_in, write_select, load, clk, reset);
initial begin
clk=0; reset=0; load=0;
#5 reset=1;
#5 d_in=23; write_select=2;
#5 load=1;
#5 d_in=18; write_select=6;
#15 #5 d_in=23; write_select=0;
#50 $finish;
end
always #5 clk=~clk;
endmodule
