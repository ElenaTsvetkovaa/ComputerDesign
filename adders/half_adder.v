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


