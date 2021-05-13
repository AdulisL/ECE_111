// Vending Machine RTL Code
module vending_machine_moore( 
 input logic clk, rstn,  
 input logic N, D,
 output logic open);
 
 // state variables and state encoding parameters
 parameter[3:0] CENTS_0=0, CENTS_5=1, CENTS_10=2, CENTS_15=3;
 logic[3:0] present_state, next_state; 

 // Sequential Logic for present state
 always_ff@(posedge clk) begin
  if (!rstn) begin
    present_state <= 0;
    present_state[CENTS_0] <= 1'b1;
  end 
  else  
    present_state <= next_state; 
 end

 // Combination Logic for Next State and Output
 always_comb begin 
  // default values to avoid latches for next_state since partial bits of next_state are assigned inside case if statements
  next_state = 4'b0;
  open = 1'b0;

  // use of priority before case, since case(1'b1) has multiple possible case item matching, priority enforces priority encoding of case items in order it is specified
  priority case(1'b1)
   present_state[CENTS_0]: begin
      open = 0;
      if(N==1) next_state[CENTS_5] = 1'b1;
      else if(D==1) next_state[CENTS_10] = 1'b1;
      else next_state[CENTS_0] = 1'b1;
   end
   present_state[CENTS_5]: begin
     
     //student to add logic here      

   end
   present_state[CENTS_10]: begin

     //student to add logic here     

   end
   present_state[CENTS_15]: begin

     //student to add logic here     

   end
   default: begin

     //student to add logic here     

   end
  endcase
 end
endmodule: vending_machine_moore

