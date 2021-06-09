//2to4 decoder testbench code
`timescale 1ns/1ns
module decoder_2to4_testbench;
logic[1:0]  tb_sel;
wire [3:0]  tb_out_behave,
            tb_out_data,
            tb_out_gate;

// Instantiate design under test
decoder_2to4_behave behave1(
.sel(tb_sel),
.out(tb_out_behave)
);
// Instantiate design under test
decoder_2to4_data data1(
.sel(tb_sel),
.out(tb_out_data)
);
// Instantiate design under test
decoder_2to4_gate gate1(
.sel(tb_sel),
.out(tb_out_gate)
);

initial begin
// Initialize Inputs
tb_sel = 0;
// Wait 100 ns for global reset to finish
#50;
// Add stimulus here
#50 tb_sel[0]=0;
    tb_sel[1]=1;
#50 tb_sel[0]=1;
    tb_sel[1]=0;
#50 tb_sel[0]=1;
    tb_sel[1]=1;
#50;
end

// always @(tb_sel, tb_out_behave, tb_out_data, tb_out_gate)
//     $display($time,);

initial begin
 $monitor(" time=%0t,  sel=%b  out_b=%b  out_d=%b out_g=%b \n",
 $time, tb_sel, tb_out_behave, tb_out_data, tb_out_gate);
end
endmodule