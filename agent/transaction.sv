`ifndef fifo_transaction
`define fifo_transaction

class transaction extends uvm_sequence_item;

   rand bit re;
   rand bit we;
   rand bit [31:0]data_in;
   bit [31:0]data_out;
   bit empty;
   bit full;

   constraint c_indata{data_in inside{[0:25]};}
  
  constraint ctrl{soft re inside {0,1}; we inside {0,1};}


   `uvm_object_utils_begin(transaction)
   `uvm_field_int(re,UVM_ALL_ON)
   `uvm_field_int(we,UVM_ALL_ON)
   `uvm_field_int(data_in,UVM_ALL_ON)
   `uvm_field_int(data_out,UVM_ALL_ON)
   `uvm_field_int(empty,UVM_ALL_ON)
   `uvm_field_int(full,UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name="transaction");
      super.new(name);
   endfunction

endclass

`endif
