//parity generator testbench code
`timescale 1ns/1ns
module parity_checker_mealy_testbench;
logic clock, rstn;
logic in;
logic out;

// Instantiate design under test
parity_checker_mealy DUT(
.clk(clock),
.rstn(rstn),
.in(in),
.out(out)
);

initial begin
// Initialize Inputs
rstn = 0;
clock = 0;
in = 0;

// Wait 20 ns for global reset to finish and start counter
#20;
rstn = 1;

// Drive random values to input signal in
for(int i=0; i<2; i++) begin
 #20;
 in = 1; 
 #20;
 in = 0; 
 #80;
 in = 1; 
 #40;
 in = 0;
 #20;
 in = 1;
 #40;
 in = 0;
 #20;
end

// terminate simulation
$finish();
end

// Clock generator logic
always@(clock) begin
  #10ns clock <= !clock;
end
endmodule