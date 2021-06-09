// 2to4 Decoder dataflow level code
module decoder_2to4_data(
 input  logic[1:0] sel,
 output logic[3:0] out
);
 assign out[0] = (!sel[0]) && (!sel[1]);
 assign out[1] = (sel[0]) && (!sel[1]);
 assign out[2] = (!sel[0]) && (sel[1]);
 assign out[3] = (sel[0]) && (sel[1]);
endmodule