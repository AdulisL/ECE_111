// 2to4 Decoder gatelevel code
module decoder_2to4_gate(
 input  logic[1:0] sel,
 output logic[3:0] out
);
 wire w0, w1;
 not i0(w0, sel[0]);
 not i1(w1, sel[1]);
 and g0(out[0], w1, w0);
 and g1(out[1], w1, sel[0]);
 and g2(out[2], sel[1], w0);
 and g3(out[3], sel[1], sel[0]);
endmodule