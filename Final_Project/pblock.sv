/* pblock starter
  Hint 1: see flow chart in Piazza @303
  Hint 2: test bench does the same operations you need to do
*/
module pblock (input               clk,
               input        [ 4:0] state,
               input        [ 6:0] t,				  // 
               input        [31:0] n,				  // instance number of our pblock
               input        [31:0] mem_read_data,	  // from data memory
               input        [31:0] k1,	              
               output logic [31:0] hout);

logic [31:0] w[16];
logic [31:0] A, B, C, D, E, F, G, H;   // usual A:H that get added to h0:7
logic [31:0] temp;
logic [31:0] h[8];					   // usual h0:7
logic [31:0] h1[8];					   // second pass h0:7
logic [31:0] h2[8];					   // third pass h0:7

parameter int p2[16] = '{
    32'h00000000,32'h00000000,32'h00000000,32'h80000000,
    32'h00000000,32'h00000000,32'h00000000,32'h00000000,
    32'h00000000,32'h00000000,32'h00000000,32'h00000000,
    32'h00000000,32'h00000000,32'h00000280,32'h00000000
};

parameter int p3[16] = '{
    32'h00000000,32'h00000000,32'h00000000,32'h00000000,
    32'h00000000,32'h00000000,32'h00000000,32'h80000000,
    32'h00000000,32'h00000000,32'h00000000,32'h00000000,
    32'h00000000,32'h00000000,32'h00000100,32'h00000000
};

function logic [31:0] rightrotate(input [31:0] x, input  [7:0] r);

endfunction

logic [31:0] t1, t2;	             // 

assign t1 = 		    // hint: see function sha256_op in tb_bitcoin_hash.sv; uses temp
assign t2 = 

assign hout =  h[0];

assign h1[0] =	h[0] + a;          
assign h1[1] =
assign h1[2] =
assign h1[3] =
assign h1[4] =
assign h1[5] =
assign h1[6] =
assign h1[7] =

logic [31:0] wt;

// A-H, temp
always_ff @(posedge clk) 
  if (!(t[6] && t[0])) begin // t<65
    if (state[4]) begin // COMPUTE1, COMPUTE2, COMPUTE3
	   temp <= 			w[15] + k1 + G;
	   {A, B, ... } <=  // concatenation of t1+t2, A:C, D+t1, E:G
    end 
    else begin
	   temp <= 			w[15] + k1 + h[7];
	   {A, B, ... } <=	{h[0], h[1], ... };
    end
  end

// W ARRAY
always_ff @(posedge clk) begin
  for (int m = 0; m < 15; m++) w[m] <= w[m+1];
  wt <= w[1]  + (rightrotate(w[2],   7) ^ rightrotate(w[2],  18) ^ (w[2] >> 3)) +
        w[10] + (rightrotate(w[15], 17) ^ rightrotate(w[15], 19) ^ (w[15]>>10));
  if (state[4]) begin // COMPUTE1, COMPUTE2, COMPUTE3
    if (t<15) begin
      case (state[1:0])
        0: // COMPUTE1
			 w[15] <= 				// hint: comes from memory
        1: begin // COMPUTE2	w[15] <= ...
           if (t<2)
			  w[15] <= 			    // hint: comes from memory
           else if (t == 2)
			  w[15] <= 		   n;
           else
			  w[15] <= 		   p2[t];
           end
        default: begin
          if (t<7) begin
		    w[15] <= 		   h2[0]; 		// save this one so that we can:
            for (int m = 0; m < 7; m++)     // move h2[15:1] down to h2[14:0]
          end
          else
            w[15] <= p3[t];
        end
      endcase
    end 
	else 	 // if t>14
       w[15] <=  wt;
    if (!state[1])                        // not COMPUTE3
         //   h2[i] <= h1[i] 
  end  
  else if (state[4:1]==4'b0101) begin  // PREP31, PREP32
    w[15] <=   			               // as above in t<7 case
    for (int m = 0; m < 7; m++)        // as above 
  end 
  else 
   	w[15] <=        // fetch more data
end

// H ARRAY
always_ff @(posedge clk) begin
  if (state[4] && state[1] && t[6] && t[0])  // COMPUTE3 && t>64

  else if (state[3]) begin 
    if (state[2:0]==...) begin 
      h[0] <= 32'h6a09e667;
      h[1] <= 32'hbb67ae85;
      h[2] <= 32'h3c6ef372;
      h[3] <= 32'ha54ff53a;
      h[4] <= 32'h510e527f;
      h[5] <= 32'h9b05688c;
      h[6] <= 32'h1f83d9ab;
      h[7] <= 32'h5be0cd19;
    end 
    else if (state[2:0]==)  
	  {h[0] ,,, } <= {h1[0], ...};
  end
end
endmodule
