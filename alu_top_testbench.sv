//1-bit ALU testbench code
`timescale 1ns/1ps
module alu_top_testbench;
parameter N = 4;
logic clock, reset;
logic [N-1:0] operand1, operand2;
logic [N-1:0] result;
logic [1:0] operation;

// Instantiate design under test
alu_top #(.N(N)) design_instance(
 .clk(clock),
 .reset(reset),
 .operand1(operand1), 
 .operand2(operand2), 
 .operation(operation), 
 .result(result)


);

initial begin
  // Initialize Inputs
  reset = 1;
  clock = 0;
  operand1 = 0;
  operand2 = 0;
  operation = 0;

  // Wait 20 ns for global reset to finish and start counter
  #20ns;
  reset = 0;

  #20ns
  operand1 = 0;
  operand2 = 1;
  operation = 0;

  #20ns;
  operand1 = 1;
  operand2 = 1;
  operation = 1;

  #20ns;
  operand1 = 1;
  operand2 = 1;
  operation = 2;

  #20ns;
  operand1 = 1;
  operand2 = 0;
  operation = 3;

  // Wait for 10ns
  #20ns;

  // terminate simulation
  $finish();
end

// Clock generator logic
always@(clock) begin
  #10ns clock <= !clock;
end

// Print input and output signals
initial begin
 $monitor(" time=%0t,  clk=%b  reset=%b  operation=%d, operand1=%d, operand2=%d",$time, clock, reset, operation, operand1, operand2);
end
endmodule