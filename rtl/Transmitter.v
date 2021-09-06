`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:55:18 03/10/2016 
// Design Name: 
// Module Name:    Transmitter 
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
module Transmitter(
    input clk,
    input reset,
    input tick,
    input start,
    input [7:0] din,
    output reg tx_ready,
    output dout
    );
localparam s0 = 0;
localparam s1 = 1;
reg state;
reg[10:0]shift_reg;
reg[3:0]count;
reg load;
//reg enbl_cnt;
always@(posedge clk)
	if(reset)
	   begin
		count<=0;
		state<=s0;
		end
	else
		case(state)
			s0:begin
				tx_ready<=1'b1;
				if(start)
					begin
					load<=1'b1;
					state<=s1;
					end
			end
			s1:begin
				tx_ready<=1'b0;
				load<=1'b0; 
				if(tick && count==10)
				      begin
						count<=0;
						state<=s0;
						end
				else if(tick) 
						begin
						count<=count+1;
						state<=s1;
						end	
				end
		endcase
assign dout = shift_reg[0];	
always@(posedge clk)
	if(reset)
		shift_reg<=11'b11111111111;
	else if(load)
		shift_reg<={din,3'b011};
	else if(tick)
		shift_reg<={1'b1,shift_reg[10:1]};
endmodule
