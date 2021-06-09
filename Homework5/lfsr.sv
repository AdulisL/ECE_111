module lfsr #(parameter N=8)
(   input clk, reset, load_seed, 
    input [N-1:0] seed_data, 
	output logic lfsr_done, 
	output logic[N-1:0] lfsr_data);

    always_ff @(posedge clk, negedge reset) begin
		if(!reset)  lfsr_data <= 0;
		// if load_seed == 1 set state to seed_data
        else if (load_seed) lfsr_data <= seed_data; 
		else begin
			case(N)
			// x**2 +x +1    SHIFTS BY 1
			2 : lfsr_data <= {lfsr_data[0],(^(lfsr_data[1:0]))}; 
			// x**3 +x**2 +1  
			3 : lfsr_data <= {lfsr_data[N-2:0],(^(lfsr_data[N-1:N-2]))};
			// x**	 +x**3 +1 
			4 : lfsr_data <= {lfsr_data[N-2:0],(^(lfsr_data[N-1:N-2]))}; 
			// x**5	 +x**3 +1
			5 : lfsr_data <= {lfsr_data[N-2:0],((lfsr_data[N-1])^(lfsr_data[N-3]))};
			// X**6 +X**	 +1
			6 : lfsr_data <= {lfsr_data[N-2:0],(^(lfsr_data[N-1:N-2])) };
			// X**7 +X**6 +1 
			7 : lfsr_data <= {lfsr_data[N-2:0],(^(lfsr_data[N-1:N-2])) };
			// X**8 + X**6 + X**	 + X**	 + 1 
			default lfsr_data <= {lfsr_data[N-2:0],((^(lfsr_data[N-3:N-5]))^(lfsr_data[N-1]))};  
			endcase
		end
    end 
    assign lfsr_done = (seed_data == lfsr_data) ? 1:0;  	 
endmodule 