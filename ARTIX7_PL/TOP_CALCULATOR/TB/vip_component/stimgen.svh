// ---------------------------------------------------------------------------
// File Name   :  stimgen.svh
// Description :  Stimulus Generator Class for calculator testbench
// ---------------------------------------------------------------------------

//`include "../TB/tr_pkg/tr_pkg.svh"
//`include "../TB/tr_pkg/tr_request_and_response.svh"

import types_pkg::*;
 
class stimgen#(type REQUEST = tr_request);


  // ---------------------------------------------------------------------------
  //                  ***  DO NOT EDIT ABOVE THIS  ***
  // ---------------------------------------------------------------------------


   // ---------------------------------------------------------------------------
   // (1) Declare the mailbox gen2drv for messages of request_type
   //  
     
   mailbox#(REQUEST) gen2drv;

   // ---------------------------------------------------------------------------
   // (2) Declare the event variable tests_done to signal when all tests are done
   //     (see clock generator at testbench top-level)
   //  

   event test_done;

   // ---------------------------------------------------------------------------
   // (3) Declare the variable rtl_request of fpu_request_type
   //
   tr_request rtl_req;

   // ---------------------------------------------------------------------------
   // (4) Implement the class constructor
   //     - Pass the mailbox gen2drv
   //     - Pass the event tests_done
   //     - Assign all arguments to the class variables
   //     - Construct the object rtl_request
   //   
 
   function new ( mailbox #(REQUEST) gen2drv, event test_done);
            this.gen2drv   = gen2drv; 
            this.test_done = test_done;  
            rtl_req        = new ();            
   endfunction :new 

              
   // ---------------------------------------------------------------------------
   // (5) Implement the task run for several tests (see LAB TASKS 4 to 6)
   //
   //     LAB TASK 4: Simulate directed tests only
   //     - Use the task run_directed_tests (implementation see below)
          
   task run;
        run_directed_tests;  
        run_random_tests_single_op (500, OP_GCD);             
   endtask :run 

   //     LAB TASK 5: Add random tests to increase the coverage
   //     - Use the tasks run_random_tests_all_ops and run_random_tests_single_op
   //       (implementations see below) to create random tests 
   //     - Use the macro MUL_PAR (see script file run_fpu_parallel.do) to select
   //       one of the two multiplier implementations (parallel or serial)
   //
   //     LAB TASK 6: Add tests for invalid op codes
   //     - Use the prepared task run_error_tests (implementation see below)
   //     - Use the macro ERROR_OP (see script file run_fpu_error_ops.do) to select 
   //       these tests
   //      
   
   
   // ---------------------------------------------------------------------------
   // (6) LAB TASK 5: Complete the task randcase_operands 
   //     - The task is used to select different constraints (see fpu_tr_pkg)
   //     - Add a randcase with branches and appropriate weights for operand A
   //     - Add a randcase with branches and appropriate weights for operand B  
   //            
   
   
   
   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT BELOW THIS  ***
   // ---------------------------------------------------------------------------   
   
   
   // ---------------------------------------------------------------------------      
   //                            TEST GENERATION TASKS
   // ---------------------------------------------------------------------------

   
   // ---------------------------------------------------------------------------
   // task run_directed_tests for directed tests
   
   task run_directed_tests; 
      
      int test_count = 0;    
      $display("\n###  R U N   D I R E C T E D   T E S T S  . . .  ###\n");     
      
      // Directed Test 1     
      rtl_req.op = OP_GCD;
      rtl_req.a = $shortrealtobits(2.0);
      rtl_req.b = $shortrealtobits(3.0);
      gen2drv.put(rtl_req.clone());   // put copy in mailbox to avoid overwriting
      test_count++;
`ifdef DISPLAY_MESSAGES_STIMGEN
      $display("\nDirected Test # %2d\n", test_count);  
`endif        

      // Directed Test 2     
      rtl_req.op = OP_GCD;
      rtl_req.a = $shortrealtobits(5.0);
      rtl_req.b = $shortrealtobits(2.0);
      gen2drv.put(rtl_req.clone()); // put copy in mailbox to avoid overwriting 
      test_count++;
`ifdef DISPLAY_MESSAGES_STIMGEN
      $display("\nDirected Test # %2d\n", test_count);  
`endif              
     // wait until DUT finished the last test
      #(100*HALF_CLK_PERIOD);      
      $display("\n### All directed tests are finished! ###\n");     
      
   endtask:run_directed_tests
         
       
       
   // ---------------------------------------------------------------------------     
   // task run_random_tests_single_op for a single operation (e.g. multiply) 
   task run_random_tests_single_op(   input int max_count = 1,  
                                      input operation_t required_operation 
                                   );

      int test_count = 0;  
      $display("Generate %0d random tests for a %s operation ...", 
               max_count, required_operation);       
      
      repeat(max_count) begin   
	 //rtl_request.constraint_mode(0);	     
         //randcase_operands();              
         //assert(rtl_request.randomize());
         rtl_req.op = required_operation;            
         rtl_req.a = $urandom_range(1000,500); //$shortrealtobits(5.0);
         rtl_req.b = $urandom_range(500, 0);   //$shortrealtobits(2.0);
         gen2drv.put(rtl_req.clone());         // put copy in mailbox to avoid overwriting          
         test_count++;
`ifdef DISPLAY_MESSAGES_STIMGEN
	 $display("\nRandom single operation test # %2d\n", test_count);  
`endif     
      end
      
      // wait until DUT finished the last test
      #(100*HALF_CLK_PERIOD);
      $display("\n### All random single operation tests are finished! ###\n");
      
   endtask: run_random_tests_single_op

  
       
endclass :stimgen  
