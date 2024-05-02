`ifndef fifo_sequence
`define fifo_sequence

/*-------------------------------------------------------------*/
/*----------------------BASE SEQUENCE--------------------------*/
/*-------------------------------------------------------------*/
class base_sequence extends uvm_sequence#(transaction);
   `uvm_object_utils(base_sequence)

   function new(string name="base_sequence");
      super.new(name);
   endfunction
 
endclass



/*-------------------------------------------------------------*/
/*-------------------------SEQUENCE_1--------------------------*/
/*-------------------------------------------------------------*/
class sequence_1 extends base_sequence;
   `uvm_object_utils(sequence_1)

   function new(string name="sequence_1");
      super.new(name);
   endfunction

   task body();
      transaction trans;
      repeat(30) begin
         trans=transaction::type_id::create("trans");
         start_item(trans);
         trans.randomize with {
                              re==1;
                              we==1;
                                 };
         finish_item(trans);
         `uvm_info("SEQUENCE_TRANSACTION_COUNT","",UVM_NONE);
      end
   endtask

endclass




/*-------------------------------------------------------------*/
/*------------------------SEQUENCE_2---------------------------*/
/*-------------------------------------------------------------*/
class sequence_2 extends base_sequence;
    `uvm_object_utils(sequence_2)

   function new(string name="sequence_2");
      super.new(name);
   endfunction

   task body();
      transaction trans;
      repeat(10) begin
         trans=transaction::type_id::create("trans");
         start_item(trans);
         trans.randomize with {
                              re==0;
                              we==1;
                                 };
         finish_item(trans);
         `uvm_info("SEQUENCE_TRANSACTION_COUNT","",UVM_NONE);
      end
      repeat(20) begin
         trans=transaction::type_id::create("trans");
         start_item(trans);
          trans.randomize with {
                              re==1;
                              we==1;
                                 };
         finish_item(trans);
         `uvm_info("SEQUENCE_TRANSACTION_COUNT","",UVM_NONE);
      end
   endtask

endclass



/*-------------------------------------------------------------*/
/*------------------------SEQUENCE_3---------------------------*/
/*-------------------------------------------------------------*/
class sequence_3 extends base_sequence;
    `uvm_object_utils(sequence_3)

    int count3;

   function new(string name="sequence_3");
      super.new(name);
   endfunction
   task body();
      transaction trans;
      repeat(10) begin
         trans=transaction::type_id::create("trans");
         start_item(trans);
         trans.randomize with {
                              re==1;
                              we==0;
                                 };
         finish_item(trans);
         `uvm_info("SEQUENCE_TRANSACTION_COUNT","",UVM_NONE);
      end
      repeat(20) begin
         trans=transaction::type_id::create("trans");
         start_item(trans);
          trans.randomize with {
                              re==1;
                              we==1;
                                 };
         finish_item(trans);
         `uvm_info("SEQUENCE_TRANSACTION_COUNT","",UVM_NONE);
      end
   endtask

endclass


`endif
