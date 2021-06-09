`timescale 1ns/1ns
// 2to1 Multiplexor gatelevel code
module mux_2x1(
  input logic[1:0] in, 
  input logic sel, 
  output logic out
); 
  wire a0, a1, inv_sel; 
  not G1(inv_sel, sel);
  and G2(a0, in[0], inv_sel);
  and G3(a1, in[1], sel);
  or  #1.5  G4(out, a0, a1);   
endmodule