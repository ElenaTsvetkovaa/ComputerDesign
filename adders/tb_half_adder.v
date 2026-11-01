
module half_adder_tb();
  reg  NumA, NumB;
  wire Sum, Cout;

  half_adder u_half_adder(.NumA(NumA), .NumB(NumB), .Sum(Sum), .Cout(Cout));

  initial begin

    NumA = 0; NumB = 0; #10;
    NumA = 0; NumB = 1; #10;
    NumA = 1; NumB = 0; #10;
    NumA = 1; NumB = 1; #10;

    $finish;
  end
endmodule