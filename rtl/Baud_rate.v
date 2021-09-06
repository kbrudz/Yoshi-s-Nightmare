`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:54:33 03/10/2016 
// Design Name: 
// Module Name:    Baud_rate 
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
module Baud_rate(
    input clk,
	 input reset,
    output tick
    );
parameter max = 163 ;
reg[31:0]counter;
assign tick=(counter==max-1)?1'b1:1'b0;
always@(posedge clk)
	if(reset)
		counter<=0;
	else if(counter==max-1)
		counter<=0;
	else
		counter<=counter+1;
endmodule
