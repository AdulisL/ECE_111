// Barrel Shifter RTL Model
`include "mux_2x1_behavioral.sv"
module barrel_shifter (
  input logic select,  // select=0 shift operation, select=1 rotate operation
  input logic direction, // direction=0 right move, direction=1 left move
  input logic[1:0] shift_value, // number of bits to be shifted (0, 1, 2 or 3)
  input logic[3:0] din,
  output logic[3:0] dout
);

// Students to add code for barrel shifter

// barrel shifter
always_comb 
    casez ({select, direction, shift_value})
      4'b?00:         dout = din;
      4'b001, 4'b111: dout = {din[0], din[3:1]}; 
      4'b?10:         dout = {din[1:0], din[3:2]}; 
      4'b011, 4'b101: dout = {din[2:0], din[3]}; 
      default: dout = din; 
    endcase

endmodule: barrel_shifter


