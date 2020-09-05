// ---------------------------------------------------------------------------
// File Name   :  stimgen.svh
// Description :  Stimulus Generator Class for calculator testbench
// Evolution   :  Add other operation to the calulator
// ---------------------------------------------------------------------------


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
   // (2) Declare the event variable test_done to signal when all tests are done
   //     (see clock generator at testbench top-level)
   //  

   event test_done;

   // ---------------------------------------------------------------------------
   // (3) Declare the variable rtl_req of request_type
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
   //     - Simulate directed tests only
   //     - Use the task run_directed_tests (implementation see below)
          
   task run;
        run_directed_tests;  
        run_random_tests_single_op (5, OP_GCD);    
        //Trigger the event test_done to signal when all tests are done  
        //->test_done;        
   endtask :run 
     
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
      rtl_req.a = 32'h2B;            
      rtl_req.b = 32'h5;              
      gen2drv.put(rtl_req.clone());   // put copy in mailbox to avoid overwriting
      test_count++;
`ifdef DISPLAY_MESSAGES_STIMGEN
      $display("\nDirected Test # %2d\n", test_count);  
`endif        

      // Directed Test 2     
      rtl_req.op = OP_GCD;
      rtl_req.a = 24; 
      rtl_req.b = 15;  
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
   // task run_random_tests_single_op for a single operation (e.g. great common dividor) 
   task run_random_tests_single_op( input int max_count = 1, input operation_t required_operation );

      int test_count = 0;  
      $display("Generate %0d random tests for a %s operation ...", max_count, required_operation);       
      
      repeat(max_count) begin   
         rtl_req.op = required_operation;            
         rtl_req.a = $urandom_range(1000,500); 
         rtl_req.b = $urandom_range(400 , 0 ); 
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
