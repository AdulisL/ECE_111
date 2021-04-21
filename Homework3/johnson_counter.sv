module johnson_counter #(parameter WIDTH = 4)(
    input logic clk, clear, preset,
    input[WIDTH-1:0] load_cnt,
    output logic[WIDTH-1:0] count
);
    // reg [WIDTH-1:0] reg_count;

    // initial
    // begin
    //     reg_count = 4'b0000;
    //     $stop;
    // end

    always @(posedge clk or negedge clear) begin //clk rising and falling edges
        if(!clear) begin
            // reg_count = 0;            // clear j_counter
            count <= 4'b0000;
        end
        else if(!preset)begin
            // reg_count = load_cnt;     // load load_count
            count <= load_cnt;
        end
        else begin

            // reg_count[2:0] = reg_count[3:1];  // right-shift
            count    <= count >> 1;
            count[3] <= ~count[0];

        end
    end
    // j_Counter value assigned to output port count  
    // assign count = reg_count;
   
endmodule: johnson_counter  // Module end declaration
