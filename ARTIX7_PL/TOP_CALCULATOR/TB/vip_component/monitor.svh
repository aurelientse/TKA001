// ---------------------------------------------------------------------------
// File Name   :  monitor.svh
// Description :  Monitor Class for calculator testbench
// ---------------------------------------------------------------------------

import types_pkg::*;


class monitor #(type REQUEST  = tr_request, 
                     RESPONSE = tr_response );


   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT ABOVE THIS  ***
   // ---------------------------------------------------------------------------
   

   // --------------------------------------------------------------------------- 
   // (1) Declare the virtual interface vif_pins
   //     - Use the parameter DATA_WIDTH defined in the package tr_pkg
   //     - Note: A virtual interface is a reference to the actual interface
   //       and the bridge between the static pin world and object world
   // 

   virtual interface pins_if #(DATA_WIDTH) pins_vif;   
   // ---------------------------------------------------------------------------
   // (2) Declare the mailboxes
   // 
   //     - LAB TASK 4: mon2ref  for messages of request_type
   //                   mon2comp for messages of response_type
   //
   //     - LAB TASK 5: mon2cov  for messages of response_type
   //

   mailbox #( REQUEST  ) mon2ref ;
   mailbox #( RESPONSE ) mon2comp;
   mailbox #( RESPONSE ) mon2cov ;
   
   // ---------------------------------------------------------------------------
   // (3) Declare the variable ref_req  of  request_type 
   //     Declare the variable rtl_resp of  response_type
   //
					 
   tr_request  ref_req;
   tr_response rtl_resp;

   // ---------------------------------------------------------------------------
   // (4) Implement the class constructor
   //     - Pass the virtual interface fpu_pins
   //     - Pass all mailboxes
   //     - Assign all arguments to the class variables
   //     - Construct all objects
   //
   function new (virtual interface pins_if #(DATA_WIDTH) pins_vif,
                 mailbox #(REQUEST ) mon2ref, mailbox #(RESPONSE) mon2comp );
            this.pins_vif  = pins_vif;
            this.mon2ref   = mon2ref ;
            this.mon2comp  = mon2comp;
            ref_req        = new();
            rtl_resp       = new();
   endfunction :new

   // ---------------------------------------------------------------------------
   // (5) Watch out for mon2cov.put() in the task monitor_pass_rtl_response
   //     (see the region under *** DO NOT BELOW THIS ***)
   //     
   //     - LAB TASK 4: Comment out the line (no mailbox mon2cov available) 
   //
   //     - LAB TASK 5: Take care to call the put method of the mailbox mon2cov
   //     

    
   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT BELOW THIS  ***
   // ---------------------------------------------------------------------------


   // ---------------------------------------------------------------------------
   //
   task run;   
      forever @(posedge pins_vif.clk) begin      
          if(pins_vif.start) monitor_pass_ref_request;
          if(pins_vif.ready) monitor_pass_rtl_response;
      end
   endtask:run

   // ---------------------------------------------------------------------------
   //  
   task monitor_pass_ref_request;
      ref_req.a  = pins_vif.opa;
      ref_req.b  = pins_vif.opb;
      ref_req.op = operation_t'(pins_vif.op);  // [convert a user type into binary code::casting]
      mon2ref.put(ref_req);                    // [Send ref_request to the mailbox mon2ref]
   endtask :monitor_pass_ref_request   
   
   // ---------------------------------------------------------------------------
   //     
   task monitor_pass_rtl_response;
      // Collect rtl_response
      rtl_resp.a      = ref_req.a;
      rtl_resp.b      = ref_req.b;
      rtl_resp.op     = ref_req.op;
      rtl_resp.result = pins_vif.result;
      // Send rtl_response to the mailboxes mon2comp and mon2cov
      mon2comp.put(rtl_resp);
      //mon2cov.put(rtl_resp);                                  
   endtask: monitor_pass_rtl_response
   
   // ---------------------------------------------------------------------------  

endclass: monitor // monitor

// EOF

