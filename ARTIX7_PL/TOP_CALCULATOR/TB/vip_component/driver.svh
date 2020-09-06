// ---------------------------------------------------------------------------
// File Name :    driver.svh
// Description :  Driver of stimulus for calculator testbench
// ---------------------------------------------------------------------------

import types_pkg::*;


class driver #(type REQUEST = tr_request);
   

   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT ABOVE THIS  ***
   // ---------------------------------------------------------------------------


   // ---------------------------------------------------------------------------
   // (1) Declare vif of the virtual interface pins_if
   //     - Use the parameter FP_WIDTH defined in the package fpu_tr_pkg
   //     - Note: A virtual interface is a reference to the actual interface
   //       and the bridge between the static pin world and object world
   // 
   virtual interface pins_if #(DATA_WIDTH) vif;

   // ---------------------------------------------------------------------------
   // (2) Declare the mailbox gen2drv for messages of request_type
   //
   mailbox #(REQUEST) gen2drv;   
   // ---------------------------------------------------------------------------
   // (3) Declare the variable rtl_req of request_type
   //
   tr_request rtl_req;

   // ---------------------------------------------------------------------------
   // (4) Implement the class constructor
   //      - Pass the virtual interface fpu_pins
   //      - Pass the mailbox gen2drv
   //      - Assign fpu_pins to the class variable
   //      - Assign gen2drv to the class variable
   //      - Construct the object rtl_request
   function new ( virtual pins_if #(DATA_WIDTH) vif, mailbox#(REQUEST) gen2drv);
      this.vif     = vif;
      this.gen2drv = gen2drv;
      rtl_req      = new();
   endfunction:new
                  
   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT BELOW THIS  ***
   // ---------------------------------------------------------------------------


   // task run to send requests to DUT via mailbox gen2drv and wait until ready
   //
   task run;
      // initialization
      vif.start  <=  0;
      vif.opa    <= '0;
      vif.opb    <= '0;
      vif.rst_n  <=  1'b0;
      // send transactions to DUT
      forever begin
         @(posedge vif.clk);  
         wait(vif.ready==1'b1);          
         gen2drv.peek(rtl_req);        // copy transaction from mailbox (blocking)
         vif.rst_n  <= 1'b1;
         vif.opa    <= rtl_req.a;
         vif.opb    <= rtl_req.b;
         vif.op     <= rtl_req.op;
         @(posedge vif.clk);
         vif.start  <= 1'b1;
`ifdef DISPLAY_MESSAGES_DRIVER 
         $display("Driver::sends a request to DUT ...@ %0t", $time); 
         $display("Driver::Number of transactions in gen2drv is %0d\n", gen2drv.num); 
`endif      
         @(posedge vif.clk);
         vif.start  <= 0;  
`ifdef DISPLAY_MESSAGES_DRIVER         
         wait(vif.done==1'b1);
         $display("Driver:: ...gets a done from DUT @ %0t", $time); 
`endif 
         gen2drv.get(rtl_req);         // remove transaction from mailbox
`ifdef DISPLAY_MESSAGES_DRIVER
         $display("Driver:: Number of transactions in gen2drv is %0d\n", gen2drv.num);
`endif
         wait(!vif.ready); 
         @(posedge vif.clk);        
      end   
   endtask
   
   // ---------------------------------------------------------------------------   
   
endclass:driver // driver

// EOF
