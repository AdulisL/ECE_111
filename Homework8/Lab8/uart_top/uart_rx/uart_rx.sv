// UART RX RTL Code
module uart_rx #(parameter NUM_CLKS_PER_BIT=16)
(input logic clk, rstn,  
 input logic rx, // input serial incoming data
 output logic done, // indicates 8-bit serial data is converted into 8-bit parallel data and available on dout port
 output logic [7:0] dout // 8-bit parallel data output
);
 
// count variable
logic [$clog2(NUM_CLKS_PER_BIT)-1:0] count;

// state encoding and state variable
enum logic[3:0]{
  RX_IDLE       = 4'b0000,
  RX_START_BIT  = 4'b0001,
  RX_DATA_BIT0  = 4'b0010,
  RX_DATA_BIT1  = 4'b0011,
  RX_DATA_BIT2  = 4'b0100,
  RX_DATA_BIT3  = 4'b0101,
  RX_DATA_BIT4  = 4'b0110,
  RX_DATA_BIT5  = 4'b0111,
  RX_DATA_BIT6  = 4'b1000,
  RX_DATA_BIT7  = 4'b1001,
  RX_STOP_BIT   = 4'b1010} state;
 

// FSM with single always block for next state, 
// present state flipflop and output logic 
always_ff@(posedge clk) begin
 if(!rstn) begin
   done <= 0;
   count <= 0;
   dout <= 0;
   state <= RX_IDLE;
 end
 else begin
    case(state)
       RX_IDLE: begin
           done <= 0;
           count <= 0;
           dout <= 0;
           // Wait for rx = 0 indicating start bit
	   if(rx == 0) state <= RX_START_BIT;
	   else state <= RX_IDLE;
       end
       RX_START_BIT: begin
           // sample start bit value at mid-point, for start bit counter
	   // value = 7 is midpoint
           // wait for rx to transition from 1 to 0
           if(rx == 0 && count == ((NUM_CLKS_PER_BIT-1)/2)) begin
               done <= 0;
               state <= RX_DATA_BIT0;
               count <= 0;
               dout <= 0;
           end else begin
               count <= count + 1;
           end
		end
        RX_DATA_BIT0: begin
            // sample start bit value at mid-point
	    // for each databit to get midpoint count value is 16
	    // counting starts from midpoint of previous bit and ends at midpoint
	    // of current data bit
             // Student to fill rest of the code
			if( count == ((NUM_CLKS_PER_BIT-1))) begin
               done <= 0;
               state <= RX_DATA_BIT1;
               dout[0] <= rx;
					count <= 0;
           end else begin
               count <= count + 1;
           end 
				 
	end
	
	RX_DATA_BIT1: begin
            // sample start bit value at mid-point
	    // for each databit to get midpoint count value is 16
	    // counting starts from midpoint of previous bit and ends at midpoint
	    // of current data bit
             // Student to fill rest of the code
			if( count == ((NUM_CLKS_PER_BIT-1))) begin // A cycle later
               done <= 0;
               state <= RX_DATA_BIT2;
               count <= 0;
               dout[1] <= rx;
           end else begin
               count <= count + 1;
           end	 
				 
	end
	
   RX_DATA_BIT2: begin
            
			if( count == ((NUM_CLKS_PER_BIT-1))) begin
               done <= 0;
               state <= RX_DATA_BIT3;
               count <= 0;
               dout[2] <= rx;
           end else begin
               count <= count + 1;
           end	 
				 
	end
        // Student to fill rest of the code for all remaining data bits and stop bit
	RX_DATA_BIT3: begin
           
			if( count == ((NUM_CLKS_PER_BIT-1))) begin
               done <= 0;
               state <= RX_DATA_BIT4;
               count <= 0;
               dout[3] <= rx;
           end else begin
               count <= count + 1;
           end	 
				 
	end
	
	RX_DATA_BIT4: begin
            
			if( count == ((NUM_CLKS_PER_BIT-1))) begin
               done <= 0;
               state <= RX_DATA_BIT5;
               count <= 0;
               dout[4] <= rx;
           end else begin
               count <= count + 1;
           end	 
				 
	end
	
	RX_DATA_BIT5: begin
           
			if( count == ((NUM_CLKS_PER_BIT-1))) begin
               done <= 0;
               state <= RX_DATA_BIT6;
               count <= 0;
               dout[5] <= rx;
           end else begin
               count <= count + 1;
           end	 
				 
	end
	
	
	RX_DATA_BIT6: begin
            
			if( count == ((NUM_CLKS_PER_BIT-1))) begin
               done <= 0;
               state <= RX_DATA_BIT7;
               count <= 0;
               dout[6] <= rx;
           end else begin
               count <= count + 1;
           end	 
				 
	end
	
	RX_DATA_BIT7: begin
           
			if(count ==((NUM_CLKS_PER_BIT-1))) begin // samples data_bit7
               done <= 0;
               state <= RX_STOP_BIT;
               count <= 0;
               dout[7] <= rx;
           end else begin
               count <= count + 1;
           end	 
				 
	end
	
	RX_STOP_BIT: begin
        if(rx ==1 && count ==((NUM_CLKS_PER_BIT-1))) begin    
            done <= 1;
            state <= RX_IDLE;
            count <= 0;	
		   end else begin
             count <= count+1;
         end	 
		    		
	  end
	
  endcase
 end
end
endmodule: uart_rx





