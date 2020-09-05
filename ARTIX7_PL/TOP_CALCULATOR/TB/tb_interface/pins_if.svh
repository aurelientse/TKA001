// ---------------------------------------------------------------------------
// File Name   :  pin_if.svh
// Description :  Pin-Level Interface for calculator
// ---------------------------------------------------------------------------

interface pins_if #(int DATA_WIDTH) (input logic clk);
   

   // ---------------------------------------------------------------------------
   // Operands and Result
   // ---------------------------------------------------------------------------
   
   logic [DATA_WIDTH-1:0] opa;
   logic [DATA_WIDTH-1:0] opb;	
   logic [DATA_WIDTH-1:0] result;
   
   // ---------------------------------------------------------------------------
   // Operations
   // ---------------------------------------------------------------------------

   // 000 = add 
   // 001 = substract 
   // 010 = multiply 
   // 011 = divide
   // 100 = square root
   // 101 = invalid operation
   // 110 = invalid operation
   // 111 = invalid operation
   
   //logic [2:0] op;
   
   // ---------------------------------------------------------------------------
   // Round Modes
   // ---------------------------------------------------------------------------

   // 00 = round to nearest even (default) 
   // 01 = round to zero 
   // 10 = round up 
   // 11 = round down
   
   //logic [1:0] rmode;
   
   // ---------------------------------------------------------------------------
   // Control and Status (Exception) Bits
   // ---------------------------------------------------------------------------
   logic rst_n;            // reset active low
   logic start;            // start the operation
   logic ready;	    // operation finished
   logic done ;            // opeation done 
   
 
   //logic inexact;       // inexact
   //logic overflow;      // overflow
   //logic underflow;     // underflow
   //logic div_zero;      // divide by zero
   //logic nan;           // not-a-number 
   
   // ---------------------------------------------------------------------------
   // Assertions and Cover Statements
   // ---------------------------------------------------------------------------	 
   
   // ---------------------------------------------------------------------------
   // Property and assertion to check a ready within two starts
   // 
     

endinterface:pins_if // pins_if

// EOF
