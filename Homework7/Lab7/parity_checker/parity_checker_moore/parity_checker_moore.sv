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
   // student to add logic here
 end

 // Combination Logic for Next State and Output
 always@(present_state,in) begin
   // student to add logic here
 end
endmodule: parity_checker_moore

