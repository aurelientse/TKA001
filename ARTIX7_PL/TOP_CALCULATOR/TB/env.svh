// ---------------------------------------------------------------------------
// File Name :    env.svh
// Description :  Environment (Top-level) Class for the calculator testbench
// ---------------------------------------------------------------------------

import types_pkg::*;
import vip_component_pkg::*;


class env #(type REQUEST  = tr_request, 
                 RESPONSE = tr_response);  
   
   // ---------------------------------------------------------------------------
   //                     ***  DO NOT EDIT ABOVE THIS  ***
   // ---------------------------------------------------------------------------
   
   // ---------------------------------------------------------------------------      
   // (1) Declare the testbench components (see Labs 4 to 6)
   //
   //     LAB TASK 4: Simple testbench
   //     - stimgen of class fpu_stimgen
   //     - driver of class fpu_driver
   //
   stimgen gen_i;
   driver  drv_i;

   //     LAB TASK 4: Self-checking testbench
   //     - reference of class fpu_ref
   //     - monitor of class fpu_monitor
   //     - comparator of class fpu_comparator 
   //
   reference  ref_i;
   monitor    mon_i;
   comparator com_i;
   //     LAB TASK 6: Final testbench
   //     - coverage of class fpu_coverage   
   //


   // ---------------------------------------------------------------------------
   // (2) Declare the mailboxes (see Lab Tasks 4 to 6) 
   //
   //     LAB TASK 4: Simple testbench
   //     - gen2drv for messages of fpu_request_type
   //
   //     LAB TASK 4: Self-checking testbench
   //     - mon2ref for messages of fpu_request_type
   //     - mon2comp for messages of fpu_response_type
   //     - ref2comp for messages of fpu_response_type
   //
    mailbox  #(REQUEST ) gen2drv;
    mailbox  #(REQUEST ) mon2ref;
    mailbox  #(RESPONSE) mon2comp;
    mailbox  #(RESPONSE) ref2comp;

   //     LAB TASK 6: Final testbench
   //     - mon2cov for messages of fpu_response_type       
   //

   mailbox #(REQUEST) mon2cov;
   // ---------------------------------------------------------------------------
   // (3) Declare the event tests_done to signal when all tests are done    
   //

   event test_done;
   // ---------------------------------------------------------------------------
   // (4) Implement the class constructor (see Lab Tasks 4 to 6)
   //
   //     - Pass the virtual interface fpu_pins
   //     - Pass the event test_done
   //     - Construct the mailboxes with message bound = 1
   //     - Construct the testbench components
   //       Pass fpu_pins to the constructors of driver and monitor
   //       Pass the mailboxes to the constructors of the components
   //       Pass tests_done to the constructor of stimgen
   //

   function new ( virtual interface pins_if #(DATA_WIDTH) vif,
                  event test_done );
            gen2drv        = new(1);
            mon2ref        = new(1);
            mon2comp       = new(1);
            ref2comp       = new(1);
            gen_i          = new(gen2drv , test_done);
            drv_i          = new(vif, gen2drv );
            mon_i          = new(vif, mon2ref, mon2comp);
            ref_i          = new(mon2ref , ref2comp);
            com_i          = new(mon2comp, ref2comp);            
   endfunction:new
   // ---------------------------------------------------------------------------
   // (5) Implement the task run_all to call all the run tasks of the required 
   //     testbench objects (see Lab Tasks 4 - 6) 
   //     Use a fork-join grouping to create threads
   //
    
   task run_all;
        fork
            gen_i.run;
            drv_i.run;
            mon_i.run;
            ref_i.run;
            com_i.run;
        join          
   endtask :run_all

   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT BELOW THIS  ***
   // ---------------------------------------------------------------------------
   
endclass:env // environment

// EOF
