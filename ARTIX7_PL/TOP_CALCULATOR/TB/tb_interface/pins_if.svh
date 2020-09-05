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

   // 000 = invalid operation
   // 001 = add 
   // 010 = substract  
   // 011 = multiply
   // 100 = divide 
   // 101 = square root 
   // 110 = gcd 
   // 111 = invalid operation   
   logic [2:0] op;
   
   
   // ---------------------------------------------------------------------------
   // Control and Status (Exception) Bits
   // ---------------------------------------------------------------------------  
   logic start;		    // start the operation
   logic ready;		    // operation finished
   logic done ;          // opeation done 

endinterface:pins_if // pins_if

// EOF
