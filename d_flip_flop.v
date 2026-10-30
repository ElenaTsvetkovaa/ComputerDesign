module d_flip_flop(
  input data_in,
  input clk,
  input reset,
  output reg data_out
);
  always @(posedge clk or negedge reset)
  begin
    if (reset == 1'b0)
      data_out <= 1'b0;
    else
      data_out <= data_in;
  end
endmodule
