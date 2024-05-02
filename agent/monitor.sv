`ifndef fifo_monitor
`define fifo_monitor

`define vintf_h vif.monitor_mp.monitor_cb
class monitor extends uvm_monitor;
   `uvm_component_utils(monitor)

   virtual fifo_intf vif;

   transaction trans;

   uvm_analysis_port#(transaction) mon2scor;

   function new(string name="monitor",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon2scor=new("mon2scor",this);
       if(!uvm_config_db#(virtual fifo_intf)::get(this,"","vintf",vif)) begin
         `uvm_fatal("MONITOR_CONNECTION_NOT_ESTABLISHED","");
      end
      else begin
         `uvm_info("MONITOR_CONNECTION_ESTABLISHED","",UVM_NONE);
      end
   endfunction

   task run_phase(uvm_phase phase);
      forever begin
         if(vif.reset==1) begin
            trans=transaction::type_id::create("trans",this);
            trans.we       = `vintf_h.we;        
            trans.re       = `vintf_h.re;
            trans.full     = `vintf_h.full;
            trans.empty    = `vintf_h.empty;
            trans.data_in  = `vintf_h.data_in;
            trans.data_out = `vintf_h.data_out;
            @(posedge vif.clk);
            mon2scor.write(trans);
            `uvm_info("MONITOR_TO_SCOREBOARD_SENT","",UVM_NONE);
         end
         else @(posedge vif.clk);
      end
   endtask

endclass

`endif

