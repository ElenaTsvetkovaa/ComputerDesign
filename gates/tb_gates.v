module tb();

    reg tb_a;
    reg tb_b;

    wire out_and;
    wire out_or;
    wire out_xor;
    wire out_xnor;
    wire out_nand;
    wire out_inv;
    wire out_buff;

    and_gate u_and(.a(tb_a), .b(tb_b), .c(out_and));
    or_gate u_or(.a(tb_a), .b(tb_b), .c(out_or));
    xor_gate u_xor(.a(tb_a), .b(tb_b), .c(out_xor));
    xnor_gate u_xnor(.a(tb_a), .b(tb_b), .c(out_xnor));
    nand_gate u_nand(.a(tb_a), .b(tb_b), .c(out_nand));
    inv_gate u_inv(.a(tb_a), .c(out_inv));
    buff_gate u_buff(.a(tb_a), .c(out_buff));   

    initial begin
        tb_a = 0;
        tb_b = 0;
        #20;
        tb_a = 0;
        tb_b = 1;
        #20;
        tb_a = 1;
        tb_b = 0;
        #20;
        tb_a = 1;
        tb_b = 1;
        #20;
    end


endmodule