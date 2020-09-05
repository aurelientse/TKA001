// ---------------------------------------------------------------------------
// File Name :    comparator.svh
// Description :  Comparator Class for calculator testbench
// ---------------------------------------------------------------------------

import types_pkg::*;

class comparator #(type RESPONSE = tr_response);

   
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

   function new ( mailbox#(RESPONSE) mon2comp,  mailbox#(RESPONSE) ref2comp );
            this.mon2comp = mon2comp;
            this.ref2comp = ref2comp;
            ref_resp      = new ();
            rtl_resp      = new ();
   endfunction:new
   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT BELOW THIS  ***
   // ---------------------------------------------------------------------------

   // task run to compare the responses from DUT and C reference
   //
   task run;
/*`ifdef REPORT_LOG
      integer fid;
      integer err_count = 1;
 `ifdef MUL_PAR		// macro to select the multiplier   
      fid = $fopen("Results_FPU_ParMult.txt");
 `else
      fid = $fopen("Results_FPU_SerMult.txt");
 `endif	
`endif*/

      forever begin   
         ref2comp.get(ref_resp);
         mon2comp.get(rtl_resp);
         $display("testscenario passed/failed \n");
         
         // ------------------------------------------------------------------
         // Assertion to compare the result bits and status bits
         // Status bits (see fpu_tr_pkg)
         // STATUS_INEXACT = rtl_response.status[0]  
         // STATUS_OVERFLOW = rtl_response.status[1]
         // STATUS_UNDERFLOW = rtl_response.status[2]
         // STATUS_DIV_ZERO = rtl_response.status[3]
         // STATUS_NAN = rtl_response.status[4]
/*
`ifndef ERROR_OP

         assert ( 
		  (
		   ref_resp.result == rtl_resp.result 	           // compare result
		    || rtl_response.status[4] == 1'b1		           // except if nan	
 		    || rtl_response.status[0] == 1'b1			   // except if inexact
		   )

		  && (
		      ref_response.status[0] == rtl_response.status[4] ||  // compare nan, except
		      (ref_response.status[0] == 1'b0 &&                   // if nan_ref = 0 and
		       rtl_response.status[4] == 1'b1)			   // nan_rtl = 1
		      )

		  && ref_response.status[2] == rtl_response.status[3]	   // div_zero	
		  && ref_response.status[4] == rtl_response.status[2]	   // underflow			
		  && ref_response.status[3] == rtl_response.status[1]	   // overflow
		  // && ref_response.status[5] == rtl_response.status[0]   // inexact		

		  ) else begin  
	    
            $error("\n C reference and DUT mismatch!");
	    $display("   a = %x is %e, b = %x is %e, op = %s, round = %s", 
                     rtl_resp.a, $bitstoshortreal(rtl_resp.a),  
                     rtl_resp.b, $bitstoshortreal(rtl_resp.b), 
                     rtl_resp.op, rtl_response.round);
	    $display("   DUT result: %x is %e", rtl_resp.result, 
                     $bitstoshortreal(rtl_resp.result));
	    $display("   C result  : %x is %e", ref_resp.result,  $bitstoshortreal(ref_resp.result));
	    $display("   DUT status: inexact = %b, overflow = %b, underflow = %b, div_zero = %b, nan = %b ",
                     rtl_response.status[0], rtl_response.status[1], 
                     rtl_response.status[2], rtl_response.status[3], 
                     rtl_response.status[4]);
	    $display("   C status  : inexact = %b, overflow = %b, underflow = %b, div_zero = %b, nan = %b",
                     ref_response.status[5], ref_response.status[3], 
                     ref_response.status[4], ref_response.status[2], 
                     ref_response.status[0]);

 `ifdef REPORT_LOG

	    $fdisplay(fid, "----- Error # %0d -----\n", err_count++);
            $fdisplay(fid, "   a = %x is %e, b = %x is %e, op = %s, round = %s \n", 
                      rtl_response.a, $bitstoshortreal(rtl_response.a),  
                      rtl_response.b, $bitstoshortreal(rtl_response.b), 
                      rtl_response.op, rtl_response.round);
            $fdisplay(fid, "   DUT result: %x is %e \n", rtl_response.result, 
                      $bitstoshortreal(rtl_response.result));
            $fdisplay(fid, "   C result  : %x is %e \n", ref_response.result, 
                      $bitstoshortreal(ref_response.result));
            $fdisplay(fid, "   DUT status: inexact = %b, overflow = %b, underflow = %b, div_zero = %b, nan = %b \n",
                      rtl_response.status[0], 
                      rtl_response.status[1], 
                      rtl_response.status[2], 
                      rtl_response.status[3], 
                      rtl_response.status[4]);
            $fdisplay(fid, "   C status  : inexact = %b, overflow = %b, underflow = %b, div_zero = %b, nan = %b \n",
                      ref_response.status[5], 
                      ref_response.status[3], 
                      ref_response.status[4], 
                      ref_response.status[2], 
                      ref_response.status[0]);   
                                
`endif // REPORT_LOG

         end    
         
`endif   // ERROR_OP  

         // ------------------------------------------------------------------  */

      end
 
 /*     
`ifdef REPORT_LOG
      $fclose(fid);
`endif
*/
   endtask
   // ---------------------------------------------------------------------------
endclass:comparator // class_comparator

// EOF
