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
