`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:05:11 03/11/2016 
// Design Name: 
// Module Name:    UART 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
/*
--======== to transmit data =======--
--wait untill tx_ready=1 then apply data to TX_data and triger statr_tx

--======== to receiv data ==========--
-- wait untill RX_done=1 then sample the data at RX_data
*/
//////////////////////////////////////////////////////////////////////////////////
module UART(
    input clk,
    input reset,
	 /* receiver signals */
		 // receiver done
		 output RX_done,
		 // received data
		 output [7:0] RX_data,
	     /* transmitter signals */
		 // transmitter ready to transmit
		 output tx_ready,
		 // data required to be transmitted
		 input [7:0] TX_data,
		 // start transmission
		 input start_tx,
	 
	 /* UART signals */
		 input Serial_in,
		 output Serial_out
    );
parameter baudrate = 9600 ;
parameter freq = 100000000 ;

RX#(baudrate, freq) RX (
    .reset(reset), 
    .clk(clk), 
    .Serial_in(Serial_in), 
    .RX_done(RX_done), 
    .Data_out(RX_data)
    );
TX#(baudrate, freq) TX (
    .clk(clk), 
    .reset(reset), 
    .start(start_tx), 
    .TX_data(TX_data), 
    .tx_ready(tx_ready), 
    .Serial_out(Serial_out)
    );
endmodule

