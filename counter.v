module counter(
  input        clk,
  input        rst,
  output [3:0] Count
);
  wire FirstSum, SecondSum, ThirdSum, ForthSum;
  wire FirstCout, SecondCout, ThirdCout;
  wire FirstDataOut, SecondDataOut, ThirdDataOut, ForthDataOut;

  full_adder first_full_adder (.NumA(1'b1), .NumB(FirstDataOut),  .Cin(1'b0),      .Sum(FirstSum),  .Cout(FirstCout));
  full_adder second_full_adder(.NumA(1'b0), .NumB(SecondDataOut), .Cin(FirstCout), .Sum(SecondSum), .Cout(SecondCout));
  full_adder third_full_adder (.NumA(1'b0), .NumB(ThirdDataOut),  .Cin(SecondCout),.Sum(ThirdSum),  .Cout(ThirdCout));
  full_adder forth_full_adder (.NumA(1'b0), .NumB(ForthDataOut),  .Cin(ThirdCout), .Sum(ForthSum),  .Cout());

  d_flip_flop first_d_flip_flop (.data_in(FirstSum),  .clk(clk), .reset(rst), .data_out(FirstDataOut));
  d_flip_flop second_d_flip_flop(.data_in(SecondSum), .clk(clk), .reset(rst), .data_out(SecondDataOut));
  d_flip_flop third_d_flip_flop (.data_in(ThirdSum),  .clk(clk), .reset(rst), .data_out(ThirdDataOut));
  d_flip_flop forth_d_flip_flop (.data_in(ForthSum),  .clk(clk), .reset(rst), .data_out(ForthDataOut));

  assign Count = {ForthDataOut, ThirdDataOut, SecondDataOut, FirstDataOut};
endmodule
