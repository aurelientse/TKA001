//------------------------------------------------------
//------------------------------------------------------
// FILENAME : gcd_tr_pkg.svh
// PACKAGE FOR GCD TRANSACTION
//-----------------------------------------------------
//-----------------------------------------------------


package types_pkg;
 
 //___________PARAMETERS__________//
 timeunit      1ns;
 timeprecision 1ps;
 parameter HALF_CLK_PERIOD = 5; 
 parameter int DATA_WIDTH  = 32;

 //______USER TYPE DEFINITION____//
 typedef struct packed 
 {
   bit sign;
   bit [30:0] dat; 
 } operand_t;
 
 typedef enum
 {
   OP_NOP,
   OP_DIV,
   OP_GCD,
   OP_SQR
 } operation_t; 




//____________CLASS TRANSACTION_REQUEST _______//


import types_pkg::*;
 
class tr_request;

 //__________ATTRIBUTES_________________//
 rand operand_t   a;
 rand operand_t   b;
 rand operation_t op;
 //__________CONSTRAINTS________________//
 


 // ---------------------------------------------------------------------------
 //                      ***  DO NOT EDIT ABOVE THIS  ***
 // ---------------------------------------------------------------------------


 //__________CONSTRUCTOR________________//
 function new ( 
               operand_t   a  ='{default:0},
               operand_t   b  ='{default:0},
               operation_t op =OP_NOP);
 this.a  = a;
 this.b  = b;
 this.op = op;
 endfunction:new 
  

 //___________METHODS_(copy  and clone)___//

 function void copy (input tr_request tmp);
   a  = tmp.a;  
   b  = tmp.b; 
   op = tmp.op;
 endfunction: copy

 function tr_request clone();
   tr_request tmp =new();
   tmp.copy(this);
   return tmp;
 endfunction :clone


endclass: tr_request





// ---------------------------------------------------------------------------
// CLASS TRANSACTION RESPONSE to extend class tr_request for response objects
//----------------------------------------------------------------------------

class tr_response extends tr_request;

 //__________ATTRIBUTES_________________//
 operand_t result;

 // ---------------------------------------------------------------------------
 //                      ***  DO NOT EDIT BELOW THIS  ***
 // ---------------------------------------------------------------------------

 

 function new (operand_t result ='{default:0});
  super.new();  //[uses to call the tr_request class properties ]@Mandatory operation for a sub-class
  this.result =result;
 endfunction:new


 // clone method
 function tr_response clone();
    tr_response tmp = new();
    tmp.copy(this);
    return tmp;
 endfunction      
   
 // copy method
 function void copy (input tr_response tmp);
    super.copy(tmp);
    result = tmp.result;
 endfunction
 
endclass :tr_response


endpackage:types_pkg
