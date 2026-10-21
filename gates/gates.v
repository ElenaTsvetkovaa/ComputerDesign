
module and_gate(
    input  a,
    input  b,
    output c
);
    assign c = a && b;
endmodule


module or_gate(
    input a,
    input b,
    output c
);
    assign c = a | b;
endmodule

module xor_gate(
    input a,
    input b,
    output c
);
    assign c = a ^ b;
endmodule

module xnor_gate(
    input a,
    input b,
    output c
);
    assign c = a ~^ b;
endmodule

module nand_gate(
    input a,
    input b,
    output c
);
    assign c = ~(a & b);
endmodule

module inv_gate(
    input a,
    output c
);
    assign c = ~a;
endmodule

module buff_gate(
    input a,
    output c
);
    assign c = a;
endmodule
