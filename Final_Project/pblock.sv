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
            rightrotate = (x >> r) | (x << (32-r));  // Ana's code - Meron
endfunction

// included s1, s0, ch, maj assigns for the t1 & t2 - Meron
logic [31:0] t1, t2, S1, S0, ch, maj;	 
assign S0 = rightrotate(A, 2) ^ rightrotate(A, 13) ^ rightrotate(A, 22); // for t2
assign S1 = rightrotate(E, 6) ^ rightrotate(E, 11) ^ rightrotate(E, 25); // for t1
assign ch = (E & F) ^ ((~E) & G); // for t1
assign maj = (A & B) ^ (A & C) ^ (B & C); // for t2

// Following the instruction - Meron
assign t1 =  temp + S1 + ch;    // hint: see function sha256_op in tb_bitcoin_hash.sv; uses temp
assign t2 = S0 + maj;

assign hout =  h[0];

// A continues update on the hash by function - Meron
assign h1[0] =	h[0] + A;          
assign h1[1] =  h[1] + B;
assign h1[2] =  h[2] + C;
assign h1[3] =  h[3] + D;
assign h1[4] =  h[4] + E;
assign h1[5] =  h[5] + F;
assign h1[6] =  h[6] + G;
assign h1[7] =  h[7] + H;

logic [31:0] wt;

// A-H, temp
always_ff @(posedge clk) 
  if (!(t[6] && t[0])) begin // t<65
    if (state[4]) begin // COMPUTE1, COMPUTE2, COMPUTE3
	   temp <= 	w[15] + k1 + G;
	   {A, B, C, D, E, F, G, H} <= {t1+t2, A, B, C, D+t1, E, F, G}; // concatenation of t1+t2, A:C, D+t1, E:G - Meron
    end 
    else begin // First pass fill - Meron
	   temp <= 	w[15] + k1 + h[7];
	   {A, B, C, D, E, F, G, H} <=	{h[0], h[1], h[2], h[3], h[4], h[5], h[6], h[7]};
    end
  end

// W ARRAY
always_ff @(posedge clk) begin
  for (int m = 0; m < 15; m++) w[m] <= w[m+1];
  wt <= w[1] + (rightrotate(w[2],   7) ^ rightrotate(w[2], 18) ^ (w[2] >> 3)) + w[10] + (rightrotate(w[15], 17) ^ rightrotate(w[15], 19) ^ (w[15]>>10));
  if (state[4]) begin // COMPUTE1, COMPUTE2, COMPUTE3
    if (t<15) begin
      case (state[1:0])
        0: begin// COMPUTE1
			      w[15] <= 	mem_read_data;			// hint: comes from memory - Meron
        end
        1: begin // COMPUTE2	w[15] <= ...
           if (t<2)
			        w[15] <= 	mem_read_data;    // hint: comes from memory - Meron
           else if (t == 2)
			        w[15] <= 		   n;
           else
			        w[15] <= 		   p2[t];
           end
        default: begin
          if (t<7) begin
		      w[15] <= 		   h2[0]; 		// save this one so that we can:
          for (int m = 0; m < 7; m++)     // move h2[7:1] down to h2[7:0]
                h2[m] <= h2[m+1];  // pushing down - Meron
          end
          else
            w[15] <= p3[t];
        end
      endcase
    end 
	else 	 // if t>14
       w[15] <=  wt;
  if (!state[1]) begin                       // not COMPUTE3
      //   h2[i] <= h1[i];  // second pass - Meron
        {h2[0], h2[1], h2[2], h2[3], h2[4], h2[5], h2[6], h2[7]} <= {h1[0], h1[1], h1[2], h1[3], h1[4], h1[5], h1[6], h1[7]};
         
  end  
  else if (state[4:1]==4'b0101) begin  // PREP31, PREP32
    w[15] <=   			h2[0];        // as above in t<7 case - Meron
    for (int m = 0; m < 7; m++)  h2[m] <= h2[m+1];  // as above - Meron
                 
  end 
  else 
   	w[15] <=  mem_read_data; // fetch more data - Meron
  end
end

// H ARRAY
always_ff @(posedge clk) begin
  if (state[4] && state[1] && t[6] && t[0])  // COMPUTE3 && t>64
     {h[0], h[1], h[2], h[3], h[4], h[5], h[6], h[7]} <= {h2[0], h2[1], h2[2], h2[3], h2[4], h2[5], h2[6], h2[7]}; // Third fill - Meron
  else if (state[3]) begin 
    if (state[2:0] == 3'b100 || state[2:0] == 3'b010) begin//first fill - Meron
      h[0] <= 32'h6a09e667;
      h[1] <= 32'hbb67ae85;
      h[2] <= 32'h3c6ef372;
      h[3] <= 32'ha54ff53a;
      h[4] <= 32'h510e527f;
      h[5] <= 32'h9b05688c;
      h[6] <= 32'h1f83d9ab;
      h[7] <= 32'h5be0cd19;
    end 
    else if (state[2:0] == 3'b000) begin // Second fill - Meron
	    {h[0], h[1], h[2], h[3], h[4], h[5], h[6], h[7]} <= {h1[0], h1[1], h1[2], h1[3], h1[4], h1[5], h1[6], h1[7]};
    end
  end
end

endmodule