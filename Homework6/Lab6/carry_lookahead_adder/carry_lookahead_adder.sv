//`include "fulladder.sv"
module carry_lookahead_adder#(parameter N=4)(
  input logic[N-1:0] A, B,
  input logic CIN,
  output logic[N:0] result
);

// declare carry and sum

logic[N:0]l_carry;
logic[N-1:0]l_sum;
logic[N-1:0]p; // propagate
logic[N-1:0]g; // generate

assign l_carry[0]= CIN;

always_comb begin
	for(int j=0; j<N; j++) begin
		g[j] = (A[j] & B[j]);
		p[j] =((A[j]) ^ (B[j]));
		l_carry[j+1]= ((g[j])|(p[j]&(l_carry[j])));
	end
end
 
// use generate to instantiate full adder multiple times
genvar i;
generate
	for(i=0; i<N; i=i+1) begin: fa_loop
		fulladder fa_inst(
		.a(A[i]),
		.b(B[i]),
		.cin(l_carry[i]),
		.sum(l_sum[i])
		  );
	end:fa_loop
endgenerate


assign result = {l_carry[N],l_sum};

  
endmodule: carry_lookahead_adder

