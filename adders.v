// Half Adder module

module half_adder(
  input  NumA,
  input  NumB,
  output Sum,
  output Cout
);
  xor g_sum (Sum,  NumA, NumB);
  and g_cout(Cout, NumA, NumB);
endmodule


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


// Full Adder module

module full_adder(
  input  NumA,
  input  NumB,
  input  Cin,
  output Sum,
  output Cout
);
  wire s1, c1, c2;

  half_adder ha1(.NumA(NumA), .NumB(NumB), .Sum(s1),  .Cout(c1));
  half_adder ha2(.NumA(s1),   .NumB(Cin),  .Sum(Sum), .Cout(c2));
  or g_or(Cout, c1, c2);
endmodule


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
