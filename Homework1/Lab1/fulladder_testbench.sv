`timescale 1ns/1ns
//FullAdder testbench code
module fulladder_testbench;
 logic in0, in1, carryin; 
 logic add_b, carryout_b,
       add_d, carryout_d,
       add_g, carryout_g;
logic [1:0]   rslt_b, rslt_d, rslt_g;

//spect : 8336949259
// Instantiate design under test
fulladder_behave behave1(
    .a(in0),
    .b(in1),
    .cin(carryin),
    .cout(carryout_b),
    .sum(add_b)
);
assign rslt_b = {carryout_b, add_b};

// Instantiate design under test
fulladder_data data1(
    .a(in0),
    .b(in1),
    .cin(carryin),
    .cout(carryout_d),
    .sum(add_d)
);
assign rslt_d = {carryout_d, add_d};

// Instantiate design under test
fulladder_gate gate1(
    .a(in0),
    .b(in1),
    .cin(carryin),
    .cout(carryout_g),
    .sum(add_g)
);
assign rslt_g = {carryout_g, add_g};



initial begin
// Initialize Inputs
    in0=0;
    in1=0;
    carryin=0;
// Wait 100 ns for global reset to finish
#50;
    in0=0;
    in1=0;
    carryin=0;

#50 
    in0=1;
    in1=0;
    carryin=0;
#50
    in0=0;
    in1=1;
    carryin=0;
#50
    in0=1;
    in1=1;
    carryin=0;
#50; 
    in0=0;
    in1=0;
    carryin=1;
#50; 
    in0=1;
    in1=0;
    carryin=1;
#50;
    in0=0;
    in1=1;
    carryin=1;
#50;
    in0=1;
    in1=1;
    carryin=1;
#50;
end

initial begin
 $monitor(" time=%0t   a=%d   b=%d   c=%d   sum_b=%d   cout_b=%d   sum_d=%d   cout_d=%d   sum_g=%d   cout_g=%d \n", $time, in0, in1, carryin, add_b, carryout_b, add_d, carryout_d, add_g, carryout_g);
end
endmodule