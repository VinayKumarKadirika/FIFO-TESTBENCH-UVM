`ifndef fifo_driver
`define fifo_driver

`define vintf vif.driver_mp.driver_cb
class driver extends uvm_driver#(transaction);
   `uvm_component_utils(driver)

   virtual fifo_intf vif;

   function new(string name="driver",uvm_component parent=null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual fifo_intf)::get(this,"","vintf",vif)) begin
         `uvm_fatal("DRIVER_CONNECTION_NOT_ESTABLISHED","");
      end
      else begin
         `uvm_info("DRIVER_CONNECTION_ESTABLISHED","",UVM_NONE);
      end
   endfunction

   task run_phase(uvm_phase phase);
      transaction trans;
      forever begin
         fork
            begin
               while(vif.reset==0) begin
                  @(posedge vif.clk);
               end
            end
            begin
               if(vif.reset==0) begin
                  `vintf.we<=0;
                  `vintf.re<=0;
                  wait(vif.reset==1);
               end
            end
         join_any
         disable fork;
         seq_item_port.get_next_item(trans);
         driver_logic(trans);
         seq_item_port.item_done();
         `uvm_info("DRIVER_TRANSACTION_COUNT = ","",UVM_NONE);
      end
   endtask

   task driver_logic(transaction trans);
       @(posedge vif.clk);
       `vintf.re     <=trans.re;
       `vintf.we     <=trans.we;
       trans.full  =vif.full;
       if(trans.we==1) `vintf.data_in<=trans.data_in;
       else if(trans.full==1 || trans.we==0) `vintf.data_in<=32'hxxxx_xxxx;
    endtask


endclass

`endif
