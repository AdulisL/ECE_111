//Integer Multiplier Testbench Code
module integer_multiplier_testbench;
 parameter N = 4;
 bit              clock, reset=1, start;
 bit  [N-1:0]     multiplicand, multiplier;
 logic[(2*N-1):0] l_product;
 wire [(2*N-1):0] product; 
 wire             done;

// Instantiate design under test
integer_multiplier #(.N(N)) design_instance(
  .clock       (clock),
  .reset       (reset),
  .start       (start),
  .multiplicand(multiplicand),
  .multiplier  (multiplier),
  .product     (product),
  .done        (done)
);

initial begin
// Release Reset
#20 reset = 0;
	scoreboard;

// Initialize multiplicand, multiplier and generate start pulse
#20 multiplicand = 11;
    multiplier   = 13;
	scoreboard;

// Initialize multiplicand, multiplier and generate start pulse
#20 multiplicand = 8;
    multiplier   = 4;
    scoreboard;

// Initialize multiplicand, multiplier and generate start pulse
#20 multiplicand = 7;
    multiplier  = 9;
    scoreboard;

// exhaustive test
    for(int i=0; i<(2**N); i++) begin
	  for(int j=0; j<(2**N); j++) begin
		#20 multiplicand = i;
		multiplier = j;
		scoreboard2;
      end
    end

// Wait for 10ns
#20 $stop;

end

task scoreboard;    
    start = 1;
#20 start = 0;

// Wait for product to be available from design
wait (done);

// Check if interger_divider design generates correct product value for given multiplicand and multiplier 
l_product = multiplicand * multiplier;
if (product == l_product)
  $display(" time=%0t   Multiplicand=%d   Multiplier=%d  DUT Product=%d  Expected=%d  Done=%d  Correct Result\n", $time, multiplicand, multiplier, product, l_product, done);
else
  $error(" time=%0t   Multiplicand=%d   Multiplier=%d   DUT Product=%d  Expected=%d  Done=%d  Incorrect Result\n", $time, multiplicand, multiplier, product, l_product, done);
wait (!done);
endtask

task scoreboard2;    // suppresses correct result printout
    start = 1;
#20 start = 0;

// Wait for product to be available from design
wait (done);

// Check if interger_divider design generates correct product value for given multiplicand and multiplier 
l_product = multiplicand * multiplier;
//if (product == l_product)
//  $display(" time=%0t   Multiplicand=%d   Multiplier=%d  DUT Product=%d  Expected=%d  Done=%d  Correct Result\n", $time, multiplicand, multiplier, product, l_product, done);
if(product != l_product)//else
  $error(" time=%0t   Multiplicand=%d   Multiplier=%d   DUT Product=%d  Expected=%d  Done=%d  Incorrect Result\n", $time, multiplicand, multiplier, product, l_product, done);
wait (!done);
endtask

// Clock generator logic
always begin
  #10 clock = 1;
  #10 clock = 0;
end

endmodule