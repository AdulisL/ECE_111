// 2to1 Multiplexor behavioral code
module mux_2x1_behave(
  input logic[1:0] in, 
  input logic sel, 
  output logic out
); 
  always @(sel or in)
  begin
     if(sel == 0)
        out = in[0];
     else
       out = in[1]; 
  end
endmodule
 

