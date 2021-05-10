module gray_code_to_binary_convertor #(parameter N = 4)( 
  input logic clk, rstn, 
  input logic[N-1:0] gray_value,
  output logic[N-1:0] binary_value);
 
  // Add code for gray code to binary conversion
 
  /* gray_code convertion using funtion call */
  always_ff @(posedge ck or negedge arstn) 
  begin
    if(!reset) binary_value <= 0;
    else binary_value <= gray_to_binary(gray_value);
  end
  
  // gray_code to binary_value function 
  function automatic gray_to_binary(logic[N-1:0] value);
    begin
      binary_value[N-1] = value[N-1];
      foreach (value[i])  // iterate through every element in the array
        binary_value[i-1] = value[i]^value[i-1];  
    end  
    
  endfunction 
endmodule: gray_code_to_binary_convertor
