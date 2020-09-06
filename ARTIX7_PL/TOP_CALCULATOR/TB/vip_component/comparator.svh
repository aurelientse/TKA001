// ---------------------------------------------------------------------------
// File Name :    comparator.svh
// Description :  Comparator Class for calculator testbench
// ---------------------------------------------------------------------------

import types_pkg::*;

class comparator #(type RESPONSE = tr_response);
   
   int match;
   int mismatch;
   
   // ---------------------------------------------------------------------------
   //                     ***  DO NOT EDIT ABOVE THIS  ***
   // ---------------------------------------------------------------------------


   // ---------------------------------------------------------------------------
   // (1) Declare the mailbox mon2comp for messages of response_type
   //     Declare the mailbox ref2comp for messages of response_type
   //
   mailbox #(RESPONSE) mon2comp;
   mailbox #(RESPONSE) ref2comp;

   // ---------------------------------------------------------------------------
   // (2) Declare the variables ref_resp and rtl_resp of response_type
   //
   tr_response ref_resp;
   tr_response rtl_resp;

   // ---------------------------------------------------------------------------
   // (3) Implement the class constructor
   //     - Pass the mailboxes mon2comp and ref2comp and assign it to the variables
   //     - Construct the objects ref_resp and rtl_resp
   //
   function new ( mailbox#(RESPONSE) mon2comp, mailbox#(RESPONSE) ref2comp );
      this.mon2comp = mon2comp;
      this.ref2comp = ref2comp;
      ref_resp      = new ();
      rtl_resp      = new ();
      match         = 0;
      mismatch      = 0:
   endfunction:new
   
   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT BELOW THIS  ***
   // ---------------------------------------------------------------------------

   // task run to compare the responses from DUT and C reference
   //
   task run;
`ifdef REPORT_LOG
   integer fid;
   integer err_count = 1;
`endif

      forever begin   
         ref2comp.get(ref_resp);
         mon2comp.get(rtl_resp);

         assert 
           (
               ( rtl_resp.a      ==  ref_resp.a  )
               &&
               ( rtl_resp.b      ==  ref_resp.b  )
               &&
               ( rtl_resp.op     ==  ref_resp.op )
               &&
               ( rtl_resp.result ==  ref_resp.result)
           ) match++;
         else 
            begin 
               mismatch ++;
               $error("Comparator::CompareTypeMismatch!
                       Expected %s and Actual %s", 
                       ref_resp.to_string , rtl_resp.to_string
                     );
            end

   endtask
   // ---------------------------------------------------------------------------
   function void report_simulation ();
      $display("# scoreboard report =============== #");
      $display("# Total stimgen: %0d", match + mismatch );
      $display("# match        : %0d", match);
      $display("# mismatch     : %0d");
      $display("# reference channel: %9s", ref2comp.is_empty);
      $display("# monitor   channel: %9s", mon2comp.is_empty);
      $display("# ================================= #");
   endfunction : report_simulation
   
   
endclass:comparator // class_comparator

// EOF
