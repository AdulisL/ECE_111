//Clock divide by 4 testbench
`timescale 1ns/1ns
module clock_divide_by_3_testbench;
logic clock, reset, out;

// Instantiate design under test
clock_divide_by_3 design_instance(
.clkin(clock),
.reset(reset),
.clkout(out)
);

initial begin
// Initialize Inputs
reset = 1;
clock = 0;

// Wait 40 ns for global reset to finish and start counter
#40;
reset = 0;

// Wait for some time
#340ns;

// terminate simulation
$finish();
end

// Clock generator logic
always@(clock) begin
  #10ns clock <= !clock;
end
endmodule