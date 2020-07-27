// ---------------------------------------------------------------------------
// File Name   :  reference.svh
// Description :  Class with C reference via DPI-C
// ---------------------------------------------------------------------------

import types_pkg::*;



/*import "DPI-C" function int cref_result(input int opa, input int opb, 
                                        input int operation, input int round);
   
import "DPI-C" function int cref_status();
*/

   
class reference #( type REQUEST  = tr_request, 
		        RESPONSE =  tr_response );

   
   // ---------------------------------------------------------------------------
   //                   ***  DO NOT EDIT ABOVE THIS  ***
   // --------------------------------------------------------------------------- 
   

   // ---------------------------------------------------------------------------         
   // (1) Declare the mailbox mon2ref for messages of  request_type
   //     Declare the mailbox ref2comp for messages of response_type
   //
   
    mailbox#( REQUEST ) mon2ref ;
    mailbox# (RESPONSE) ref2comp;

   // ---------------------------------------------------------------------------
   // (2) Declare the variable ref_request  of request_type
   //     Declare the variable ref_response of response_type
   //    
   tr_request  ref_req ;
   tr_response ref_resp;

   // ---------------------------------------------------------------------------
   // (3) Implement the class constructor
   //     - Pass the mailboxes
   //     - Assign the arguments to the class variables
   //     - Construct the objects
   //

   function new ( mailbox#( REQUEST ) mon2ref,
                  mailbox#( RESPONSE) ref2comp);
            this.mon2ref  = mon2ref;
            this.ref2comp = ref2comp;
            ref_req  = new();
            ref_resp = new();
   endfunction:new
                  
   // ---------------------------------------------------------------------------
   // (4) Implement the task run using a forever loop
   //     - Read ref_request via get method from mailbox mon2ref
   //     - Compute the reference result object ref_response by calling
   //       the function ref_compute (implementation see below)
   //     - Send ref_response via put method to the mailbox ref2comp
   //
   task run;
        forever begin
           mon2ref.get(ref_req);
           ref_resp = ref_compute(ref_req); //TODO
           ref2comp.put(ref_resp);           
        end
   endtask : run


   // ---------------------------------------------------------------------------
   //                  ***  DO NOT EDIT BELOW THIS  ***
   // ---------------------------------------------------------------------------  

   // Function ref_compute to get the reference result and status from C model
   
   function tr_response ref_compute(tr_request ref_req);
      shortreal result;          // local result in shortreal
      operand_t r;               // local result in bit representation
      
      // Call C function cref_result to compute reference data output
      //ref_resp.result = cref_result( ref_req.a , ref_req.b, ref_req.op); //TODO
      ref_resp.a      = ref_req.a;
      ref_resp.b      = ref_req.b;
      ref_resp.op     = ref_req.op;
     // ref_resp.round = ref_request.round;
      
      // Call C function cref_status to compute reference status output
      //ref_resp.status = cref_status();

      return ref_resp;

   endfunction :ref_compute

   // ---------------------------------------------------------------------------  
   
endclass:reference // reference

// EOF
