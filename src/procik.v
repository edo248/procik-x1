module procik (clock,reset);
input clock,reset;

wire [0:7] addr_bus_out;
wire [0:7] addr_to_bus;
wire [0:1] adress_select;
wire [0:7] ip_data;
wire [0:15] data_bus_out;
wire [0:15] data_bus_in1;
wire [0:15] gpr_mux_out;  
wire [0:15] r0,r1,r2,r3,r4,r5,r6,r7;
wire [0:3] ra;
wire [0:7] cu_addr_out;
wire [0:1] data_select;
wire [0:15] ir_data;

register  #(8)  IP  (.Out(ip_data), .Reset(reset_internal), 
	        .Clk(clock) , .Increment(ip_inc)
   	        /*.In(0), .Load(0)*/
	    );
mux1x8 addr_bus (
      .select({1'b0,adress_select}),
      .data1(ip_data),
      .data2(cu_addr_out),
      .data3(8'd0),
      .data4(8'd0),
      .out(addr_bus_out) /*,data5,data6,data7, data8, */ 
      );

SRAM256x16 memory (.A1(addr_bus_out),.CE1(clock),
               .WEB1(write_en),.OEB1(1'b0),.CSB1(sram_en),
              .I1(data_bus_out), .O1(data_bus_in1));

mux1x8 #(.N(16)) data_bus (
      .select({1'b0,data_select}),
      .data1(data_bus_in1),
      .data2(gpr_mux_out),
      .data3(16'd0),
      .data4(16'd0),
      .out(data_bus_out)  /*,data5,data6,data7, data8, */
      );

register #(16)  IR  (
       .Out(ir_data), .In(data_bus_out), 
       .Reset(reset_internal), .Clk(clock), 
       .Load(ir_load), .Increment(1'b0)
       );

cu (    .clk(clock), .reset(reset), .ir_data(ir_data),
	.data_select(data_select), .adress_select(adress_select),
	.sram_en(sram_en), .write_en(write_en),
	.ir_load(ir_load), .gpr_load(gpr_load), 
	.ip_increment(ip_inc),
	.ra(ra), .adress(cu_addr_out), 
	.reset_internal(reset_internal) 	   
   );

gpr  (
      .r_out0(r0), .r_out1(r1), .r_out2(r2), .r_out3(r3), .r_out4(r4), .r_out5(r5), .r_out6(r6), .r_out7(r7),
      .d_in(data_bus_out), .write_select(ra[1:3]), 
      .load(gpr_load), .clk(clock), .reset(reset_internal)
      );
      
mux1x8 #(.N(16)) gpr_mux (
      .select(ra[1:3]),
      .data1(r0),
      .data2(r1),
      .data3(r2),
      .data4(r3),
      .data5(r4),
      .data6(r5),
      .data7(r6), 
      .data8(r7), 
      .out(gpr_mux_out) 
      );


endmodule
