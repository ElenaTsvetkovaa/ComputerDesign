module asyncMem(
  input We,
  input [7:0] Wdata,
  input [3:0] Addr,
  output [7:0] Rdata
);

  reg [7:0] AsyncMem [0:15];
  
  always @(*) 
  begin
    if (We) AsyncMem[Addr] <= Wdata;
  end
  
  assign Rdata = AsyncMem[Addr];
  
endmodule


module doubleAsyncmem(
  input We,
  input We1,
  input clk,
  input [7:0] Wdata,
  input [7:0] Wdata1,
  input [3:0] Addr,
  input [3:0] Addr1,
  output [7:0] Rdata,
  output [7:0] Rdata1
);

  reg [7:0] AsyncMem [0:15];
  
  // Ports 0
  always @(posedge clk) 
  begin
    if (We) AsyncMem[Addr] <= Wdata;
  end
  
  assign Rdata = AsyncMem[Addr];
  
  // Ports 1
  always @(posedge clk) 
  begin
    if (We1) AsyncMem[Addr1] <= Wdata1;
  end
  
  assign Rdata1 = AsyncMem[Addr1];
  
endmodule



