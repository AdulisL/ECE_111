//clock divide by 3 RTL code
module clock_divide_by_3 ( 
 input  logic clkin, reset,
 output logic clkout);

 // Add clock divide by 3 code
 logic[1:0] posedge_count;
 logic[1:0] negedge_count;

 //First halfcycle
always_ff @(posedge clkin) begin
    if(reset) posedge_count <= 0;
    else posedge_count <= (posedge_count + 1) % 3;
end
//Second halfcycle
always_ff @(negedge clkin) begin
    if(reset) negedge_count <= 0;
    else negedge_count <= (negedge_count + 1) % 3;
end
//Sum of 2 odds = even
always_comb begin
    if(posedge_count > 0 && negedge_count > 0)
        clkout = 1;
    else clkout = 0;
end
endmodule: clock_divide_by_3