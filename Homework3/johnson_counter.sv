module johnson_counter #(parameter WIDTH = 4)(
    input logic clk, clear, preset,
    logic [WIDTH-1:0] load_cnt = 4'b1000,
    output wire[WIDTH-1:0] count
);
    reg [WIDTH-1:0] reg_count;

    initial
    begin
        reg_count = 4'b0000;
        $stop;
    end

    always @(posedge clk, negedge clear) begin //clk rising and falling edges
        if(!clear) begin
            reg_count <= 0;            // clear j_counter
        end
        else if(!preset)begin
            reg_count <= load_cnt;     // load load_count
        end
        else begin
            reg_count <= reg_count + 1;   
        end
    end
     // Johnson right shift counter
    always @(posedge clk) begin
        reg_count[2:0] = reg_count[3:1];  // right-shift fill 0 on the MSB
        reg_count[3] = !reg_count[0];     //Circulate inverted LSB to MSB
        // reg_count <= reg_count >> 1;   // right-shift operator
    end

    // j_Counter value assigned to output port count  
    assign count = reg_count;
   
endmodule: johnson_counter  // Module end declaration
