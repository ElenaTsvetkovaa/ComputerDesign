module full_adder_tb();
  reg  NumA, NumB, Cin;
  wire Sum, Cout;

  full_adder u_full_adder(
    .NumA(NumA), .NumB(NumB), .Cin(Cin), .Sum(Sum), .Cout(Cout)
  );

  initial begin

    NumA = 0; NumB = 0; Cin = 0; #10;
    NumA = 0; NumB = 0; Cin = 1; #10;
    NumA = 0; NumB = 1; Cin = 0; #10;
    NumA = 0; NumB = 1; Cin = 1; #10;
    NumA = 1; NumB = 0; Cin = 0; #10;
    NumA = 1; NumB = 0; Cin = 1; #10;
    NumA = 1; NumB = 1; Cin = 0; #10;
    NumA = 1; NumB = 1; Cin = 1; #10;

    $finish;
  end
endmodule
