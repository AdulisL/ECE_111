/* This is merely sample starter code. You may write your own from scratch or
use some of all of this, as desired. There is no single correct design.
*/
module simplified_sha256 #(parameter integer size = 80)(       // don't change this
// from test bench
  input               clk, reset_n, 
                      start,			// request to start reading message from memory
  input        [15:0] message_addr, 	// when reading/loading, mem_addr starts here
                      output_addr,		// when writing/storing, mem_addr starts here
//
  output logic        done, 			// acknowledge that results have been written to memory
// connections to external memory, inside test bench
                      mem_clk, 			// clock for memory in test bench
                      mem_we,		    // write enable for memory in test bench
  output logic [15:0] mem_addr,			// message_addr + offset
  output logic [31:0] mem_write_data,	// output_addr + offset
  input  logic [31:0] mem_read_data);	// data from external memory during read operations

// FSM state variables 
enum logic [2:0] {IDLE, BLOCK, COMPUTE, WRITE} state;

// Local variables
logic [31:0] w[16];		                      // array of 16 thirty-two bit words
logic [31:0] h0, h1, h2, h3, h4, h5, h6, h7;  // from chart of SHA algorithm
logic [31:0] a, b, c, d, e, f, g, h;		  //   likewise
logic [ 7:0] i, j;							  // dummy indices
logic [ 7:0] tstep;							  // k selector for sha256_op; always = i-1
logic [15:0] offset;                          // counts 0 to 7 during mem read, again during mem write
logic [ 7:0] num_blocks;					  // function of size parameter 
logic [15:0] cur_addr;						  // starting address for read message or write results

// SHA256 K constants -- tstep selects these for sha256_op function
parameter int k[0:63] = '{
   32'h428a2f98,32'h71374491,32'hb5c0fbcf,32'he9b5dba5,32'h3956c25b,32'h59f111f1,32'h923f82a4,32'hab1c5ed5,
   32'hd807aa98,32'h12835b01,32'h243185be,32'h550c7dc3,32'h72be5d74,32'h80deb1fe,32'h9bdc06a7,32'hc19bf174,
   32'he49b69c1,32'hefbe4786,32'h0fc19dc6,32'h240ca1cc,32'h2de92c6f,32'h4a7484aa,32'h5cb0a9dc,32'h76f988da,
   32'h983e5152,32'ha831c66d,32'hb00327c8,32'hbf597fc7,32'hc6e00bf3,32'hd5a79147,32'h06ca6351,32'h14292967,
   32'h27b70a85,32'h2e1b2138,32'h4d2c6dfc,32'h53380d13,32'h650a7354,32'h766a0abb,32'h81c2c92e,32'h92722c85,
   32'ha2bfe8a1,32'ha81a664b,32'hc24b8b70,32'hc76c51a3,32'hd192e819,32'hd6990624,32'hf40e3585,32'h106aa070,
   32'h19a4c116,32'h1e376c08,32'h2748774c,32'h34b0bcb5,32'h391c0cb3,32'h4ed8aa4a,32'h5b9cca4f,32'h682e6ff3,
   32'h748f82ee,32'h78a5636f,32'h84c87814,32'h8cc70208,32'h90befffa,32'ha4506ceb,32'hbef9a3f7,32'hc67178f2
};

// parameter size = 80 bytes = 20 words -- see above -- do not change default value of 80; 
assign tstep = (i - 1);							  // already taken care of for you
assign num_blocks = determine_num_blocks(size);   // assume maximum of 256 blocks = 16K bytes

// Function to determine number of blocks in memory to fetch
function logic [15:0] determine_num_blocks(input[31:0] size);
  if (size ... )				            // hint: block size = 64
    determine_num_blocks = size/64 + 1;
  else
    determine_num_blocks = size/64 + 2;   
  $display("size = %d, num_blocks = %d",size,determine_num_blocks);
endfunction

// SHA256 hash round
function logic [255:0] sha256_op(input [31:0] a, b, c, d, e, f, g, h, w,
                                 input [ 7:0] t);
  logic [31:0] S1, S0, ch, maj, t1, t2; // internal signals
    S1 = rightrotate(e, 6) ^ rightrotate(e, 11) ^ rightrotate(e, 25);
    ch =  // Boolean function of e, f, and g
    t1 =  // function of h, w, ch, k[t], and S1
    S0 =  // rotate and XOR function of a
    maj = // carry bit of a, b, and c -- majority gate
    t2 =  // function of maj and S0
    sha256_op = {t1 + t2, a, b, c, d + t1, e, f, g};
endfunction

// Generate request to memory
// for reading from memory to get original message
// for writing final computed has value
assign mem_clk  = clk;
assign mem_addr = cur_addr + offset;    // offset increments during mem read / write bursts

// Right Rotation Example : right rotate input x by r
// Say input x = 1111 ffff 2222 3333 4444 6666 7777 8888 and r = 4
// x >> r  will result in : 0000 1111 ffff 2222 3333 4444 6666 7777 
// x << (32-r) will result in : 8888 0000 0000 0000 0000 0000 0000 0000
// final right rotate value = 8888 1111 ffff 2222 3333 4444 6666 7777
// (0000 1111 ffff 2222 3333 4444 6666 7777) | (8888 0000 0000 0000 0000 0000 0000 0000)
// Right rotation function
function logic [31:0] rightrotate(input logic [31:0] x,
                                  input logic [ 7:0] r);
   // right rotate x by r positions
endfunction

// Called from COMPUTE stage for word expansion logic
// 0: outputs 32'b100...0;
// 1: outputs data[31:24] followed by 24'b100...0;
// 2: outputs data[31:16] followed by 16'b100...0;
function logic [31:0] mask_data(input logic [31:0] data,
                                input logic [ 1:0] select);
    case (select)
    0: mask_data = 32'h80000000;						     //  MSB = 1
    1: mask_data = (data & 32'h FF000000) | 32'h 00800000;   //  {8MSBs, 1}
    2: mask_data = (data & 32'h FFFF0000) | 32'h 00008000;   // {16 MSBs, 1} 
    3: mask_data = (data & 32'h FFFFFF00) | 32'h 00000080;   // {24 MSBs, 1}
    endcase
endfunction

// SHA-256 FSM 
// Get a BLOCK from the memory, COMPUTE Hash output using sha256_op function
//  and write hash value back to memory
always_ff @(posedge clk, negedge reset_n) begin
  if (!reset_n) begin
    mem_we  <= 1'b0;
    state   <= IDLE;
  end 
  else case (state)
    IDLE: begin   :idle_loop
      if(start) begin
//Initialize hash values:
// (first 32 bits of the fractional parts of the square roots of the first 8 primes 2..19):
        h0 <= 32'h6a09e667;
        h1 <= 32'hbb67ae85;
        h2 <= 32'h3c6ef372;
        h3 <= 32'ha54ff53a;
        h4 <= 32'h510e527f;
        h5 <= 32'h9b05688c;
        h6 <= 32'h1f83d9ab;
        h7 <= 32'h5be0cd19;

// Initialize counter of number of block iterations 
        j              <= ; 

// Initialize pointer to access memory location
	    offset         <= ;

// by default, set memory to read mode 
	    mem_we         <= ;

// get staring address of message 
	    cur_addr       <= ;

// clear write data to memory
	    mem_write_data <= ;

// on to next state
	    state          <= ;
      end
    end	  :idle_loop

/* SHA-256 FSM 
    1) Read a message BLOCK from memory;
    2) COMPUTE Hash output using sha256_op function
    3) repeat steps 1 and 2 as long as new message blocks are available
    4) repeat step 1   
    4) WRITE hash value back to memory	  */
    BLOCK: begin :block_loop
	// Fetch message in 512-bit block size
	// For each of 512-bit block initiate hash value computation
      if(j < ) begin
// at start of processing each message block M[j], copy h0:7 to a:h
       	a <= ; 
		
    	
    	
    	 ...

		
		h <= ;
		
// reset 64 iteration processing counter 
		i <= ;

// increment memory address to fetch next block
		offset <= ;

// move to SHA256 hash COMPUTE stage
		state  <= ; 
	  end
// After all blocks from memory are fetched and hash value is computed,
//  move to memory WRITE stage to write final 256-bit computed hash value
	  else begin
	    i <= ;
		state <= ;
	  end
    end	:block_loop

// For each BLOCK COMPUTE hash sequence:
// Always return to BLOCK stage after COMPUTE 
// if there are still message blocks available in memory, go to COMPUTE
// otherwise go to WRITE stage
    COMPUTE: begin
	// 64 processing rounds steps for 512-bit block 
        if (i <= 64) begin
// for each proc step i perform word expansion for wt
          for (int n = 0; n < 15; n++) w[n] <= w[n+1];
// If i < 16, Wi = i'th 32-bit word of block Mi
            if (i < 16) begin  :ilt16_block
                if ((offset << 2) <= size)
                    w[15] <= mem_read_data; // read ahead
                else if ((offset << 2) > size && ((offset - 1) << 2) <= size)
                    w[15] <= mask_data(mem_read_data, size[1:0]);
                else if ((j == num_blocks - 1) && i == 15) // if last block and last word
                    w[15] <= size << 3; // pad message size in bits
                else
                    w[15] <= 32'h00000000;
            end	 : ilt16_block
	    // Extend the first 16 words into the remaining 48 words w[15..63] of the message schedule array
	        else begin
	    // w[i] := w[i-15] + s0 + w[i-6] + s1
              w[15] <= // function of w[0], right-rotated/shifted w[1], w[9], right-rotated/shifted w[14] 

            end

            if (i < 15) offset <= ...;

            if (i != 0) begin // process tstep = (i - 1)th round
                {a, ..., h} <= sha256_op(a, ..., h, w[15], tstep);
            end

	    // next processing iteration
            i <= ;
				
	    // Stay in COMPUTE stage until 64 iterations of processing is completed for the BLOCK
	    state <= COMPUTE;
        end else begin
            // Once all 64 rounds of processing completed 
            // Add the compressed chunk computed from sha256_a function to the current hash value
            // and compute final hash value for current block
            h0 <= h0 + a;
			 // etc.







	    // increment block index
            j <= ;

        // go to next BLOCK fetch stage
            state <= ;
        end
    end

    // h0 to h7 each are 32 bit hashes, which makes up total 256 bit value
    // h0 to h7 after compute stage has final computed hash value
    // write back these h0 to h7 to memory starting from output_addr
    WRITE: begin
	// Generate write request to memory starting from output_addr
    // write one word at a time into data memory 
	// offset will move memory address from one location to the next
	// so that our 8 hashes are written to consecutive output addresses
                mem_we <= 1;
                cur_addr <= output_addr;
                case (i)
                  0: mem_write_data <= h0;
   				  // etc.









  // update memory address
       offset <= ; 
     
  // increment hash pointer
       i <= ; 
	 end else
  //  proceed to next state
	    state <= ; 
    end
   endcase
  end

// Generate when SHA256 hash computation has finished and moved to IDLE state
assign done = ;

endmodule
