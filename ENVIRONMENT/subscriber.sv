`ifndef fifo_subscriber
`define fifo_subscriber

class subscriber extends uvm_subscriber#(transaction);
   `uvm_component_utils(subscriber)

   uvm_tlm_analysis_fifo#(transaction) mon2subs;

   transaction trans;
   
   function new(string name="environment",uvm_component parent=null);
      super.new(name,parent);
      fifo_cg=new();
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon2subs=new("mon2subs",this);
   endfunction

   covergroup fifo_cg();
      cp1:coverpoint trans.we;
      cp2:coverpoint trans.re;
      cp3:coverpoint trans.full;
      cp4:coverpoint trans.empty;
      cp5:coverpoint trans.data_in {
                                       bins b1[10] = {[0:30]};
                                    }
   endgroup

   function void write(T t);
      fifo_cg.sample();
   endfunction

   task run_phase(uvm_phase phase);
      `uvm_info("SUBSCRIBER-RUN PHASE","",UVM_NONE);
      forever begin
         mon2subs.get(trans);
         write(trans);
      end
   endtask

   function void check_phase(uvm_phase phase);
     $display("----------------------------------------------------------------------------------------------------");
     $display("----------------------------------------------------------------------------------------------------");
      `uvm_info("MY_COVERAGE",$sformatf("%0f",fifo_cg.get_coverage()),UVM_NONE);
     $display("----------------------------------------------------------------------------------------------------");
     $display("----------------------------------------------------------------------------------------------------");
   endfunction


endclass

`endif
