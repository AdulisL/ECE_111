// FullAdder behavioral level code
module fulladder_behave(
  input logic a, b, cin, 
  output logic sum, cout
);
  assign {cout, sum} = a + b + cin;
endmodule

