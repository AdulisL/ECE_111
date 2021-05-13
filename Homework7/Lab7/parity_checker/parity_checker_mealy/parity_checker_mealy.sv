// Parity checker RTL Code
module parity_checker_mealy( 
 input logic clk, rstn,  
 input logic in,
 output logic out);
 
 // state variables
 enum logic[1:0] {EVEN=2'b00, ODD=2'b01} present_state, next_state; 
 
 // local variable to store output in always_comb block
 logic out_t;
  
 // Sequential Logic for present state
 always_ff@(posedge clk) begin
  
   //student to add logic here
   //Note : register out_t  (out <= out_t)
 end

 // Combination Logic for Next State and Output
 always_comb begin
  
   // student to add logic here

 end
endmodule: parity_checker_mealy

