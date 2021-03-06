//------------------------------------------------------
//------------------------------------------------------
// FILENAME : tr_pkg.svh
// PACKAGE FOR GCD TRANSACTION
//-----------------------------------------------------
//-----------------------------------------------------


package types_pkg;
 
 //___PARAMETERS___//
 timeunit      1ns;
 timeprecision 1ps;
 parameter HALF_CLK_PERIOD = 3.9; 
 parameter int DATA_WIDTH  = 16;

 //___USER TYPE DEFINITION__//
 typedef struct packed 
 {
   bit sign;
   bit [DATA_WIDTH-2:0] dat; 
 } operand_t;
 
 typedef enum
 {
   OP_NOP,
   OP_ADD,
   OP_SUB,
   OP_MUL,
   OP_DIV,
   OP_GCD,
   OP_SQR
 } operation_t; 




//____________CLASS TRANSACTION_REQUEST _______//


import types_pkg::*;
 
class tr_request;

 //___ATTRIBUTES____//
 rand operand_t   a;
 rand operand_t   b;
 rand operation_t op;
 //___CONSTRAINTS___//
 


 // --------------------------------------------------------------
 //                      ***  DO NOT EDIT ABOVE THIS  ***
 // --------------------------------------------------------------


 //___CONSTRUCTOR___//
 function new ( 
               operand_t   a  ='{default:0},
               operand_t   b  ='{default:0},
               operation_t op =OP_NOP);
 this.a  = a;
 this.b  = b;
 this.op = op;
 endfunction:new 
  

 //___METHODS_(copy  and clone)___//

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





// -------------------------------------------------------------
//          CLASS TRANSACTION RESPONSE                         -
//      <<to extend class tr_request for response objects>>    -
//--------------------------------------------------------------

class tr_response extends tr_request;

 //___ATTRIBUTES___//
 bit [2*DATA_WIDTH-1:0] result;

 // ------------------------------------------------------------
 //                      ***  DO NOT EDIT BELOW THIS  ***
 // ------------------------------------------------------------

 

 function new (operand_t result ='{default:0});
  super.new();  //[used to call the tr_request class properties]@Mandatory operation when extending class
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

 // print method
 function string to_string ();
  //$sformatf("operand   a  : h%2x", a     );
  //$sformatf("operand   b  : h%2x", b     );
  //$sformatf("operation op : h%2x", op    );
  $sformat(to_string, "result    r  :   %h", result);
 endfunction:to_string;
 
endclass :tr_response


endpackage:types_pkg
