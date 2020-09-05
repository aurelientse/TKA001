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
   virtual interface pins_if #(DATA_WIDTH) vif_pins;

   // ---------------------------------------------------------------------------
   // (2) Declare the mailbox gen2drv for messages of fpu_request_type
   //
   mailbox #(tr_request) gen2drv; 

   // ---------------------------------------------------------------------------
   // (3) Declare the variable rtl_request of fpu_request_type
   //
   tr_request rtl_req;

   // ---------------------------------------------------------------------------
   // (4) Implement the class constructor
   //      - Pass the virtual interface fpu_pins
   //      - Pass the mailbox gen2drv
   //      - Assign fpu_pins to the class variable
   //      - Assign gen2drv to the class variable
   //      - Construct the object rtl_request
   //   
   function new ( virtual pins_if #(DATA_WIDTH) vif_pins, mailbox#(REQUEST) gen2drv);
      this.vif_pins     = vif_pins;
      this.gen2drv      = gen2drv;
      rtl_req           = new();
   endfunction:new
                  
   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT BELOW THIS  ***
   // ---------------------------------------------------------------------------


   // task run to send requests to DUT via mailbox gen2drv and wait until ready
   //
   task run;
      // initialization
      vif_pins.start  <=  0;
      vif_pins.opa    <= '0;
      vif_pins.opb    <= '0;
      vif_pins.op     <= '0;
      // send transactions to DUT
      forever begin
         @(posedge vif_pins.clk);            
         gen2drv.peek(rtl_req);       // copy transaction from mailbox (blocking)
         vif_pins.opa    <= rtl_req.a;
         vif_pins.opb    <= rtl_req.b;
         vif_pins.op     <= rtl_req.op;
         @(posedge vif_pins.clk);
         vif_pins.start  <= 1;
`ifdef DISPLAY_MESSAGES_DRIVER 
         $display("Driver sends a request to DUT @ %0t", $time); 
         $display("Number of transactions in gen2drv is %0d\n", gen2drv.num); 
`endif      
         @(posedge vif_pins.clk);
         vif_pins.start  <= 0;   
         wait(vif_pins.ready);
`ifdef DISPLAY_MESSAGES_DRIVER 
         $display("... and gets a ready from DUT @ %0t", $time);
`endif 
         gen2drv.get(rtl_req); // remove transaction from mailbox
`ifdef DISPLAY_MESSAGES_DRIVER
         $display("Number of transactions in gen2drv is %0d\n", gen2drv.num);
`endif
         wait(!vif_pins.ready); 
         @(posedge vif_pins.clk);        
      end   
   endtask
   
   // ---------------------------------------------------------------------------   
   
endclass:driver // fpu_driver

// EOF
