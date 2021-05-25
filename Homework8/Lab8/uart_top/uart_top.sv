// UART TX RTL Code
module uart_top #(parameter NUM_CLKS_PER_BIT=16)
(input logic tx_clk, tx_rstn, rx_clk, rx_rstn,  
 input logic[7:0] tx_din,
 input logic tx_start,
 output logic tx_done, rx_done,
 output logic[7:0] rx_dout);


// wire to connect output of uart_tx "tx" signal to
// uart_rx "rx" signal
logic serial_data_bit;

// Instantiate uart transmitter module
// student to add code



// Instantiate uart receiver module
// student to add code

endmodule: uart_top


