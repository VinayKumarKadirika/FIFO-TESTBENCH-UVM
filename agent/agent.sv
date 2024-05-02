`ifndef fifo_agent
`define fifo_agent

class agent extends uvm_agent;
   `uvm_component_utils(agent)

   sequencer sequencer_h;
   driver driver_h;
   monitor monitor_h;

   uvm_analysis_port#(transaction) mon2scor;

   function new(string name="agent",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon2scor=new("mon2scor",this);
      sequencer_h=sequencer::type_id::create("sequencer_h",this);
      driver_h=driver::type_id::create("driver_h",this);
      monitor_h=monitor::type_id::create("monitor_h",this);
   endfunction

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
      monitor_h.mon2scor.connect(mon2scor);
   endfunction

   task run_phase(uvm_phase phase);
      `uvm_info("AGENT-RUN PHASE","",UVM_NONE);
   endtask

endclass

`endif
