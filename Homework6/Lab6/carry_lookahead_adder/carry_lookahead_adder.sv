`include "fulladder.sv"
module carry_lookahead_adder#(parameter N=4)(
  input logic[N-1:0] A, B,
  input logic CIN,
  output logic[N:0] result,
  output logic cout,
);

 logic [n-1:-1] carry;
 logic [n-1:0] dummy;
 logic [n-1:0] x;
 logic [n-1:0] y;

 assign carry[-1] = CIN;
 assign cout = carry[n-1];

 for(genvar i = 0; i < n; i++) 
  begin
    fulladder f0(result[i], dummy[i], A[i], B[i], carry[i-1]);
    assign g[i] = a[i] & b[i];
    assign p[i] = a[i] ^ b[i];
    assign carry[i] = g[i] + (p[i] & carry[i-1]);
  end
  
endmodule: carry_lookahead_adder

