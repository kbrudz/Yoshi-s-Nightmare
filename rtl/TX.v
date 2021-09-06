`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:16 03/10/2016 
// Design Name: 
// Module Name:    TX 
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
//
//////////////////////////////////////////////////////////////////////////////////
module TX(
    input clk,
    input reset,
    input start,
    input [7:0] TX_data,
    output tx_ready,
    output Serial_out
    );
parameter baudrate = 9600 ;
parameter freq = 50000000 ;
wire tick;
Transmitter Transmitter (
    .clk(clk), 
    .reset(reset), 
    .tick(tick), 
    .start(start), 
    .din(TX_data), 
    .tx_ready(tx_ready), 
    .dout(Serial_out)
    );
tick_gen#(freq/baudrate) tick_gen (
    .reset(reset), 
    .clk(clk), 
    .tick(tick)
    );

endmodule
