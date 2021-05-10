//clock divide by 3 RTL code
module clock_divide_by_3 ( 
 input  logic clkin, reset,
 output logic clkout);

 // Add clock divide by 3 code
 logic posedge_count;
 logic negedge_count;
 //First halfcycle
always_ff @(posedge clkin) begin
    if(reset) posedge_count <= 0;
    else posedge_count <= posedge_count + 1;
end
//Second halfcycle
always_ff @(negedge clkin) begin
    if(reset) negedge_count <= 0;
    else negedge_count <= negedge_count + 1;
end
//Sum of 2 odds = even
always_comb begin
    clkout <= (posedge_count + neged) / 3;
end

endmodule: clock_divide_by_3