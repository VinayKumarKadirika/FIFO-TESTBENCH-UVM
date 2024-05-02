class scoreboard extends uvm_scoreboard;
   `uvm_component_utils(scoreboard)

   uvm_tlm_analysis_fifo#(transaction) mon2scor;


   bit [31:0]wmem[$];
   bit [31:0]rmem[$];
   bit [31:0]data;

   function new(string name="scoreboard",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon2scor=new("mon2scor",this);
   endfunction

   task run_phase(uvm_phase phase);
      transaction trans;
      forever begin
         mon2scor.get(trans);
         if(trans.we==1 && !trans.full) begin
            wmem.push_back(trans.data_in);
         end
         if(trans.re==1 && !trans.empty) begin
            rmem.push_back(trans.data_out);
            for(int i=0;i<rmem.size();i++) begin
               if(wmem[i-1]==rmem[i]) begin
                  `uvm_info("SCOREBOARD_PASSED",$sformatf("data_out=%0d,data_in=%0d",trans.data_out,trans.data_in),UVM_NONE);
               end
               else begin
                  `uvm_error("SCOREBOARD_FAILED",$sformatf("data_out=%0d,data_in=%0d",trans.data_out,trans.data_in));
               end
            end
         end
      end
   endtask

endclass
