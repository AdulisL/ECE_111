`timescale 1ns/1ns
//LFSR Testbench Code
module lfsr_testbench;
  parameter N = 4;
  bit           clock;
  bit           reset,        // note: active low
                load_seed;    // note: active high
  bit  [N-1:0]  seed_data;
  int           ct;
  wire [N-1:0]  lfsr_data; 
  wire          lfsr_done;
   
  lfsr #(.N(N)) design_inst(
   .clk      (clock),
   .reset    ,
   .load_seed,
   .seed_data,
   .lfsr_data,
   .lfsr_done
  );
  int file;
  initial begin
   file = $fopen("rslt.txt");
   // Wait 10 ns for global reset to finish and start counter
   #10ns   reset     = '1;   // release reset

   #10ns   load_seed = '1;
           seed_data = '1;   // '1 = all 1s; 'b1 = 00...01

   #20ns   load_seed = '0;

   #200ns  $fclose(file); 
   $stop;             // terminate simulation
   
  end

  // Clock generator logic
  always begin
    #5ns clock = 1;          // DUT updates on rising edges of clock
    #5ns clock = 0;          // inputs change on falling edges of clock
    $fdisplay(file," time=%0t,  reset=%b  clk=%b  load_seed=%b  count=%b  done=%b", $time, reset, clock, load_seed, lfsr_data, lfsr_done, ct);
    if(reset && !load_seed) ct++;
  end

  // Print input and output signals
  initial begin
  end

endmodule