module gpr(r_out0, r_out1, r_out2, r_out3, r_out4, r_out5, r_out6, r_out7, d_in, write_select, load, clk, reset);

input [15:0]d_in;
input [2:0]write_select;
input load;
input reset, clk;

wire [7:0]load_inter;

output [15:0]r_out0, r_out1, r_out2, r_out3, r_out4, r_out5, r_out6, r_out7;

decoder_comb decoder(load_inter, write_select, load);
defparam decoder.IN_SIZE=3;

register  register0(r_out0, d_in, reset, clk, load_inter[0]);
defparam register0.SIZE=16;

register  register1(r_out1, d_in, reset, clk, load_inter[1]);
defparam register1.SIZE=16;

register  register2(r_out2, d_in, reset, clk, load_inter[2]);
defparam register2.SIZE=16;

register  register3(r_out3, d_in, reset, clk, load_inter[3]);
defparam register3.SIZE=16;

register  register4(r_out4, d_in, reset, clk, load_inter[4]);
defparam register4.SIZE=16;

register  register5(r_out5, d_in, reset, clk, load_inter[5]);
defparam register5.SIZE=16;

register  register6(r_out6, d_in, reset, clk, load_inter[6]);
defparam register6.SIZE=16;

register  register7(r_out7, d_in, reset, clk, load_inter[7]);
defparam register7.SIZE=16;

endmodule



