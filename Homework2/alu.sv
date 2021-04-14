// 1-bit ALU behavioral code
`timescale 1ns/1ps
module alu // Module start declaration
#(parameter N=4) // Parameter declaration
(
  input logic[N-1:0] operand1, operand2,
  input logic[1:0] operation,
  output logic[N-1:0] alu_out
);
  always@(operand1 or operand2 or operation) 
  begin
    case(operation)
      2'b00: alu_out = operand1 + operand2; 
      2'b01: alu_out = operand1 - operand2; 
      2'b10: alu_out = operand1 & operand2;
      2'b11: alu_out = operand1 | operand2; 
    endcase
  end
endmodule: alu // Module end declaration
