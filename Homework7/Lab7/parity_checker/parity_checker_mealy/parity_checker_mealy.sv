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
  if(!rstn)
    present_state <= EVEN;
  else
    present_state <= next_state;
   //Note : register out_t  (out <= out_t)
 end

 // Combination Logic for Next State and Output
 always_comb begin
  case(present_state) begin
    EVEN: begin
      if(in == 1) begin
        next_state = ODD;
        out = 0;
      end
      else begin
        next_state = EVEN;
        out = 0;
      end
    end
    ODD: begin 
      if(in == 1) begin
        next_state = ODD;
        out = 0;
      end
      else begin
        next_state = EVEN;
        out = 0;
      end
    end
  end
 end


endmodule: parity_checker_mealy

