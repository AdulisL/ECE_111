// 4-bit counter behavioral code
`timescale 1ns/1ns
module counter_4bit    // Module start declaration
 // Parameter declaration, count signal width set to '4'  
 #(parameter WIDTH=4)  
 ( 
    input logic clk,
    input logic clear, 
    output wire[WIDTH-1:0] count
 );

 // Local variable declaration
 reg[WIDTH-1:0] cnt_value; 
  
 // always procedural block describing counter behavior
 always @(posedge clk or posedge clear) 
   begin
     if (clear == 1)
       cnt_value = 0;
     else 
       cnt_value = cnt_value + 1;
   end

 // Counter value assigned to output port count  
 assign count = cnt_value;
endmodule: counter_4bit  // Module end declaration