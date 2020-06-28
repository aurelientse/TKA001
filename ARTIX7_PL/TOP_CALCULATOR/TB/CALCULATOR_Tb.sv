
module calculator_tb;

  //variable declaration
  bit clk   =1'b0;
  bit rst_n =1'b0;
  bit ready ;
  bit start =1'b0;
  bit [31:0] gcd_a =0;
  bit [31:0] gcd_b =0;
  wire [31:0] gcd_r;
  wire done;  
  //Clock generation process
  always clk = #5 ~ clk;
  
  // tasks
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
   end
  
  
  
  
  //Driver Procedure and Test Generation
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
  end:driver_system
  
  
  //VHDL MOODULE
  calculator calculator_inst0 ( .clk(clk),
                                .rst_n(rst_n),
                                .start(start),
                                .value_a(gcd_a),
                                .value_b(gcd_b),
                                .done(done),
                                .ready(ready),
                                .result(gcd_r)     
                            );
  //VERILOG MODULE         
  //test       calculator_inst1 ( .clk(clk) );
  
  mailbox mbx;
endmodule; 
