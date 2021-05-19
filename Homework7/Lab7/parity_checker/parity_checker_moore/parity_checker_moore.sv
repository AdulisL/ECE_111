// Parity checker RTL Code
module parity_checker_moore( 
 input logic clk, rstn,  
 input logic in,
 output logic out);
 
 // local parameter for odd and even parity
 localparam EVEN=0, ODD=1;

 // state variables 
 logic present_state, next_state;

 // Sequential Logic for present state
 always_ff@(posedge clk) begin
   if(!rstn)
    present_state <= EVEN;
  else 
    present_state <= next_state;
 end

 // Combination Logic for Next State and Output
 always@(present_state,in) begin
   case(present_state)
    EVEN: out = EVEN;
    ODD: out = ODD;
  endcase
  next_state = EVEN;
  case(present_state)
    EVEN: if(in) next_state = ODD;
    ODD: if(!in) next_state = ODD;
  endcase
 end
endmodule: parity_checker_moore

