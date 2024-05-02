// Code your testbench here
// or browse Examples
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "include_files.sv"

module top;

bit clk;
bit reset;

fifo_intf intf_h(.clk(clk),.reset(reset));

sync_fifo inst(
   .clk(clk),
   .reset(reset),
   .re(intf_h.re),
   .we(intf_h.we),
   .data_in(intf_h.data_in),
   .data_out(intf_h.data_out),
   .full(intf_h.full),
   .empty(intf_h.empty)
);

initial begin
   uvm_config_db#(virtual fifo_intf)::set(null,"*","vintf",intf_h);
end


initial begin
   clk=0;
   forever #5 clk=~clk;
end

initial begin
   reset=0;
   #20
   reset=1;
end

initial begin
   run_test("test_case_2");
end
  
initial begin
  	$dumpfile("dump.vcd"); $dumpvars;
end

endmodule
