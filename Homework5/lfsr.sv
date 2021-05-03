module lfsr #(parameter N=8)
(
    input clk, reset, load_seed, 
    logic[N-1:1] seed_data, lfsr_data, lfsr_done
    outout logic[N-1:0] out
);
    logic[N-1:0] state;

    always_ff @(posedge clk)
        if(reset) state <= 'b1;
        else if (!reset) state <=  seed_data;
        else    state <= (state << 1) | (^state[N-1:N-2]) // state[7]^state[6]

    assign out = state[1];
endmodule lfsr