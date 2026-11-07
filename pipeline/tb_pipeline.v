module tb_dataPipeline;
  reg [7:0] Icode;
  reg clk = 0;
  reg rst;

  dataPipeline dut (.Icode(Icode), .clk(clk), .rst(rst));

  always #5 clk = ~clk;

  initial begin
    rst = 0; Icode = 0;
    #12 rst = 1;

    #10 Icode = 1;
    #10 Icode = 2;
    #10 Icode = 3;
    #10 Icode = 5;
    #10 Icode = 5;
    #10 Icode = 7;
    #10 Icode = 8;
    #10 Icode = 7;

    #100 $finish;
  end
endmodule