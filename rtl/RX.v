`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:14:23 03/10/2016 
// Design Name: 
// Module Name:    RX 
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
module RX(
    input reset,
    input clk,
    input Serial_in,
    output RX_done,
    output [7:0] Data_out
    );
parameter baudrate = 9600 ;
parameter freq = 50000000 ;
wire tick;
Baud_rate#(freq/(baudrate*16)) Baud_rate (
    .clk(clk), 
    .reset(reset), 
    .tick(tick)
    );
Reciever Reciever (
    .clk(clk), 
    .reset(reset), 
    .Data_in(Serial_in), 
    .tick(tick), 
    .dout(Data_out), 
    .load(RX_done)
    );
endmodule
