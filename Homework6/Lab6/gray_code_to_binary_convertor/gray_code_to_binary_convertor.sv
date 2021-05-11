module gray_code_to_binary_convertor #(parameter N = 4)( 
  input logic clk, rstn, 
  input logic[N-1:0] gray_value,
  output logic[N-1:0] binary_value);
 
  // Add code for gray code to binary conversion

 /* gray_code convertion using funtion call */
  always_ff @(posedge clk or negedge rstn) 
  begin
    if(!rstn) binary_value <= 0;
    else binary_value <= gray_to_binary(gray_value);
  end

  // gray_code to binary_value function 
  function automatic[N-1:0] gray_to_binary(logic[N-1:0] value);
      logic[N-1:0] temp;
      temp[N-1] = value[N-1];
      // iterate through every element in the array
      for (int i = N-1; i > 0; i--)  
        temp[i-1] = temp[i] ^ value[i-1]; 
      return temp;   

  endfunction 
  
endmodule: gray_code_to_binary_convertor
