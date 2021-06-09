`timescale 1ns/1ns
//mux testbench code
module mux_2x1_testbench;
  logic[1:0] tb_in; 
  logic tb_sel;
  logic tb_out_behave,
          tb_out_data,
          tb_out_gate;

// Instantiate design under test
mux_2x1 behave1(
.in(tb_in),
.sel(tb_sel),
.out(tb_out_behave)
);

// Instantiate design under test
mux_2x1 data1(
.in(tb_in),
.sel(tb_sel),
.out(tb_out_data)
);

// Instantiate design under test
mux_2x1 gate1(
.in(tb_in),
.sel(tb_sel),
.out(tb_out_gate)
);

initial begin
// Initialize Inputs
  tb_in=0;
  tb_sel=0;

// Wait 100 ns for global reset to finish
#100;
  tb_in[0]=0;
  tb_in[1]=0;
  tb_sel=0;
#50;
  tb_in[0]=1;
  tb_in[1]=0;
  tb_sel=0;
#50;
  tb_in[0]=0;
  tb_in[1]=1;
  tb_sel=0;
#50;
  tb_in[0]=0;
  tb_in[1]=0;
  tb_sel=1;
#50;
  tb_in[0]=1;
  tb_in[1]=0;
  tb_sel=1;
#50;
  tb_in[0]=0;
  tb_in[1]=1;
  tb_sel=1;
end

initial begin
 $monitor(" time=%0t,  in=%b  sel=%b  out_b=%b  out_d=%b  out_g=%b\n", $time, tb_in, tb_sel, tb_out_behave, tb_out_data, tb_out_gate);
end
endmodule