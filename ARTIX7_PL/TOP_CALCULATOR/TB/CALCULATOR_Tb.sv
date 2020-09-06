

import types_pkg::*;
import vip_component_pkg::*;
`include "env.svh"





module calculator_tb;

  import "DPI-C" function void hello_from_cpp();
  
  //variable declaration
  bit    clk   = 1'b0;
  event test_done ;  
  
  
  // ---------------------------------------------------------------------------
   // Clock generator with event tests_done
   initial begin
      fork     
          wait(test_done.triggered);
          forever #HALF_CLK_PERIOD clk = ~clk;
      join_any
      disable fork;      
   end   
   
   // ---------------------------------------------------------------------------
   // Interface pins_vif of type pins_if with parameter DATA_WIDTH and port clk
   //
   pins_if #(.DATA_WIDTH(DATA_WIDTH)) vif(clk);
   
 
   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT ABOVE THIS  ***
   // ---------------------------------------------------------------------------

   // ---------------------------------------------------------------------------
   // (1) Declare the object env_i of class env 
   //
   env env_i;

   // ---------------------------------------------------------------------------
   // (2) Add an initial procedure 
   //     - Call the constructor for env with pins_vif and test_done
   //     - Call the task run_all of the top-level object env
   //

   initial begin 
     env_i = new (vif, test_done);
     env_i.run_all;
     hello_from_cpp();  
   end 

   initial begin
      forever begin
      @test_done;
      env_i.report;           
      end      
   end 
   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT BELOW THIS  ***
   // ---------------------------------------------------------------------------
   
 
  
  
  //Instantiate VHDL MODULE
  calculator calculator_inst0 ( .clk(vif.clk),
                                .rst_n(vif.rst_n),
                                .start(vif.start),
                                .value_a(vif.opa),
                                .value_b(vif.opb),
                                .opcode(vif.op),
                                .done(vif.done),
                                .ready(vif.ready),
                                .result(vif.result)     
                            );
 
endmodule :calculator_tb; 



 /* // tasks
  task reset_task;
   $display("\n r e s e t   s y s t e m   b e g i n s  . . . \n"); 
   #203 rst_n <= 1'b1;
   $display("\n r e s e t   s y s t e m   p e r f o r m e d  . . . \n");  
  endtask :reset_task 
*/

