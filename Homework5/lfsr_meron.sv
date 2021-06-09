module lfsr #(parameter N=4)
(
    input clk, reset, load_seed, load_ptrn,
    input [N-1:0] seed_data, ptrn_in,
    output logic lfsr_done,
    output logic[N-1:1] lfsr_data
);
    // logic[N-1:0] ptrn;

    // logic[N-1:1] state;
    // always_ff @(posedge clk)
    //     if(reset) state <= 3'b001;
    //     else begin
    //         state    <= state << 1;
    //         state[0] <= ^state[2:1];
    //     end
    // assign  = state[0];

// students to add implementation of lfsr
    // always_ff @(posedge clk, posedge reset) begin
    //     if(reset) ptrn <= 0;
    //     else if (load_ptrn) ptrn <= ptrn_in;
    // end


    always_ff @(posedge clk, posedge reset) begin
        if(reset) lfsr_data <= 0;
        else if(load_seed) lfsr_data <= seed_data;
        // else lfsr_data <= {lfsr_data[N-2:0], ^ptrn&lfsr_data};
        else begin
            case(N)
            2:      lfsr_data <= {lfsr_data[0], (^lfsr_data)};
            3:      lfsr_data <= {lfsr_data[N-2:0], (^(lfsr_data[2:1]))};
            4:      lfsr_data <= {lfsr_data[N-2:0], (^(lfsr_data[3:2]))};
            5:      lfsr_data <= {lfsr_data[N-2:0], 
            (^(lfsr_data[N-1])^(^(lfsr_data[N-3])))};
            6:      lfsr_data <= {lfsr_data[N-2:0], (^(lfsr_data[N-1:N-2]))};
            7:      lfsr_data <= {lfsr_data[N-2:0], (^(lfsr_data[N-1:N-2]))};
            default lfsr_data <= {lfsr_data[N-2:0], 
            (^(lfsr_data[N-1])^(^(lfsr_data[N-2:N-4])))};
            endcase
        end
    end

    assign lfsr_done = (seed_data == lfsr_data)? 1: 0;
endmodule
