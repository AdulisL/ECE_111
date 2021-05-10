module gray_code_to_binary_convertor #(parameter N = 4)( 
  input logic clk, rstn, 
  input logic[N-1:0] gray_value,
  output logic[N-1:0] binary_value);
 
  // Add code for gray code to binary conversion
  always_comb 
  begin
    binary_value[WIDTH-1] = gray_value[WIDTH-1];
    
    foreach (gray_value[i]) 
      binary_value[i-1] = gray_value[i]^gray_value[i-1];  
  end  
endmodule: gray_code_to_binary_convertor
