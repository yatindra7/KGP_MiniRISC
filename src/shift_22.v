`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:45:58 11/10/2022 
// Design Name: 
// Module Name:    shift_22 
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
module shift_22(
		input in,
		output out
    );
	wire [21:0] in;
	wire [31:0] out;

	assign out = {{10{in[21]}}, in};

endmodule
