// Vending Machine RTL Code
module vending_machine_mealy( 
 input logic clk, rstn,  
 input logic N, D,
 output logic open);
 
 // state encoding and state variables
 parameter[3:0] CENTS_0=0, CENTS_5=1, CENTS_10=2, CENTS_15=3;
 logic[3:0] present_state, next_state; 


 // Note : output open is not registered in this example for students to compare moore and mealy machine waveform and see what is the different between mealy and moore
 // remember we learnt in class that mealy reacts immediately to change in input !!

 // Sequential Logic for present state
 always_ff@(posedge clk) begin
  if(!rstn) begin
    present_state <= 0; 
    present_state[CENTS_0] <= 1'b1;
  end 
  else begin
    present_state <= next_state; 
  end
 end

 // Combination Logic for Next State and Output
 always_comb begin 
  next_state = 4'b0;
  priority case(1'b1)
   present_state[CENTS_0]: begin

    // student to add logic here
    
   end
   present_state[CENTS_5]: begin
 
    // student to add logic here

   end
   present_state[CENTS_10]: begin

    // student to add logic here

   end
   present_state[CENTS_15]: begin

    // student to add logic here

   end
   default: begin

    // student to add logic here

   end
  endcase
 end
endmodule: vending_machine_mealy
