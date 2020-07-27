

import types_pkg::*;
import vip_component_pkg::*;

`include "env.svh"
module calculator_tb;

  //variable declaration
  bit   clk =1'b0 ;
  event test_done ;
  
  /*bit rst_n =1'b0;
  bit ready ;
  bit start =1'b0;
  bit [31:0] gcd_a =0;
  bit [31:0] gcd_b =0;
  wire [31:0] gcd_r;
  wire done;  */
  
  //Clock generation process
  //always clk = #(HALF_CLK_PERIOD) ~ clk;
  
  
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
   pins_if #(.DATA_WIDTH(DATA_WIDTH)) pins_vif(clk);
   
 
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
     env_i = new (pins_vif, test_done);
     env_i.run_all;
   end 
   // ---------------------------------------------------------------------------
   //                      ***  DO NOT EDIT BELOW THIS  ***
   // ---------------------------------------------------------------------------
   
 
  
  
  //VHDL MOODULE
  calculator calculator_inst0 ( .clk(pins_vif.clk),
                                .rst_n(rst_n),
                                .start(pins_vif.start),
                                .value_a(pins_vif.opa),
                                .value_b(pins_vif.opb),
                                .opcode(pins_vif.op),
                                .done(pins_vif.done),
                                .ready(pins_vif.ready),
                                .result(pins_vif.result)     
                            );
  //VERILOG MODULE         
  //test       calculator_inst1 ( .clk(clk) );
  
endmodule :calculator_tb; 






 /* // tasks
  task reset_task;
   $display("\n r e s e t   s y s t e m   b e g i n s  . . . \n"); 
   #203 rst_n <= 1'b1;
   $display("\n r e s e t   s y s t e m   p e r f o r m e d  . . . \n");  
  endtask :reset_task 


  task enable_start;
      @(posedge ready)
      start <= 1'b1;
      @(negedge ready)
      start <= 1'b0;
  endtask :enable_start

   initial begin
      forever begin
        enable_start();
      end
   end*/
  
  
  
  
  /* //Driver Procedure and Test Generation
  initial begin :driver_system
     $display("\n T e s t s   a r e   r u n n i n g   . . . \n");  
     
     // Init the system
     reset_task();
     
     // Drive the System
     forever begin
       @(posedge start);
       if (ready ==1'b1)
          begin 
            $display("\n s t i m u l i s   d r i v e n    t o   t h e   D U T  . . . \n");  
            gcd_a=$urandom_range(1000,500);
            gcd_b=$urandom_range(400,100);
            $display("\n\t\t r a n d o m [a] =%d \t and  \t r a n d o m [b] =%d  \n", gcd_a, gcd_b); 
          end        
     end           
  end:driver_system */
