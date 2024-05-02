// Code your design here
//---------------------------------------------------------------------------//
//------------------------------FIFO_DESIGN----------------------------------//
//---------------------------------------------------------------------------//

module sync_fifo(clk,reset,re,we,data_in,data_out,full,empty);
input clk;
input reset;
input re;
input we;
input [31:0]data_in;
output full;
output empty;
output reg [31:0]data_out;
  
  reg [31:0] mem [8];
  reg [2:0] waddr;
  reg [2:0] raddr;
    
always @ (posedge clk, negedge reset)  begin
    if (reset == 0) begin
      mem[0] <= 16'bx;
      mem[1] <= 16'bx;
      mem[2] <= 16'bx;
      mem[3] <= 16'bx;
      mem[4] <= 16'bx;
      mem[5] <= 16'bx;
      mem[6] <= 16'bx;
      mem[7] <= 16'bx;
      waddr <= 0;
    end 
    else if(we == 1 && !full) begin
      mem[waddr] <= data_in;
      waddr <= waddr + 1;
    end

end

always @ (posedge clk, negedge reset)  begin
    if (reset == 0) begin
      mem[0] <= 16'bx;
      mem[1] <= 16'bx;
      mem[2] <= 16'bx;
      mem[3] <= 16'bx;
      mem[4] <= 16'bx;
      mem[5] <= 16'bx;
      mem[6] <= 16'bx;
      mem[7] <= 16'bx;
      raddr <= 0;
    end 
    else if(re == 1 && !empty) begin
      data_out <= mem[raddr];
      raddr <= raddr + 1;
    end
end

assign full=(waddr-raddr==7 || waddr-raddr==(-7))?1:0;
assign empty=(waddr-raddr==0)?1:0;

endmodule
