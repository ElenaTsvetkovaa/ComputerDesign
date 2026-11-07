module dataPipeline(
  input [7:0] Icode,
  input clk,
  input rst
);
  // wires between stages
  wire [7:0] result_reg_to_mem;
  wire [7:0] addr_s4_to_mem;
  wire [7:0] res_keeper_out;   
  wire [7:0] mux_comp_and_s5;    
  wire [7:0] s2_to_s3_data;      
  wire [7:0] Rdata;

  // S1
  wire [7:0] icode_register_to_addr;
  d_flip_flop icode_register (.data_in(Icode), .clk(clk), .reset(rst), .data_out(icode_register_to_addr));

  wire [7:0] addr_s1_to_addr_s2;
  d_flip_flop addr_s1 (.data_in(Icode), .clk(clk), .reset(rst), .data_out(addr_s1_to_addr_s2));

 // compare addr in S1 and addr in S4 ->
 // used in S2 to decide whether to forward result from S4 or read from memory
  wire compare_res;
  assign compare_res = (addr_s1_to_addr_s2 == addr_s4_to_mem);

  wire compare_res_out;
  d_flip_flop_1bit comparison_keeper (.data_in(compare_res), .clk(clk), .reset(rst), .data_out(compare_res_out));

  // S2
  doubleSyncMem Mem(
    .We(1'b0),
    .We1(1'b1),
    .clk(clk),
    .Wdata(8'b0),
    .Wdata1(result_reg_to_mem),
    .Addr(icode_register_to_addr),
    .Addr1(addr_s4_to_mem),
    .Rdata(Rdata),
    .Rdata1()
  );

  assign mux_comp_and_s5 = (compare_res_out == 1'b1) ? res_keeper_out : Rdata;

  wire [7:0] addr_s2_to_addr_s3;
  d_flip_flop addr_s2 (.data_in(addr_s1_to_addr_s2), .clk(clk), .reset(rst), .data_out(addr_s2_to_addr_s3));

  // forwarding mux S2 -> S3
  assign s2_to_s3_data = 
        (addr_s2_to_addr_s3 == addr_s4_to_mem) ?
        result_reg_to_mem : mux_comp_and_s5;

  // S3
  wire [7:0] mem_register_to_addr;
  d_flip_flop mem_register (.data_in(s2_to_s3_data), .clk(clk), .reset(rst), .data_out(mem_register_to_addr));

  wire [7:0] addr_s3_to_addr_s4;
  d_flip_flop addr_s3 (.data_in(addr_s2_to_addr_s3), .clk(clk), .reset(rst), .data_out(addr_s3_to_addr_s4));

  // S4
  wire [7:0] mout_reg_inp_with_one;
  assign mout_reg_inp_with_one = 
    (addr_s3_to_addr_s4 == addr_s4_to_mem) ?
    (result_reg_to_mem + 8'd1) :
    (mem_register_to_addr + 8'd1);

  d_flip_flop result_reg (.data_in(mout_reg_inp_with_one), .clk(clk), .reset(rst), .data_out(result_reg_to_mem));
  d_flip_flop addr_s4    (.data_in(addr_s3_to_addr_s4),    .clk(clk), .reset(rst), .data_out(addr_s4_to_mem));

  // S5
  d_flip_flop result_reg_keeper (.data_in(result_reg_to_mem), .clk(clk), .reset(rst), .data_out(res_keeper_out));
endmodule