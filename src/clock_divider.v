`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:00:06 11/14/2022 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(
		clk,
		clock_out
    );
	input clk;										// input clock on FPGA
	output reg clock_out;								// output clock after dividing the input clock by divisor
	reg[27:0] counter=28'd0;
	parameter DIVISOR = 28'd200000;

	always @(posedge clk) begin
		counter <= counter + 28'd1;
		if(counter>=(DIVISOR-1))
			counter <= 28'd0;
		clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
	end
endmodule
