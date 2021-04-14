// 1-bit ALU behavioral code
`timescale 1ns/1ps
module alu // Module start declaration
#(parameter N=4) // Parameter declaration
(
  input logic[N-1:0] opnd1, opnd2,
  input logic[1:0] operation,
  output logic[N-1:0] out
);
  always@(opnd1 or opnd2 or operation) 
  begin
    case(operation)
      2'b00: out = opnd1 + opnd2; 
      2'b01: out = opnd1 - opnd2; 
      2'b10: out = opnd1 & opnd2;
      2'b11: out = opnd1 | opnd2; 
    endcase
  end
endmodule: alu // Module end declaration
