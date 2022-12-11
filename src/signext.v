`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:44:21 11/10/2022 
// Design Name: 
// Module Name:    shift_16 
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
module signext_16(
		input [15:0] in,
		output [31:0] out
    );

	assign out = {{16{in[15]}}, in};

endmodule

module signext_22(
		input [21:0] in,
		output [31:0] out
    );

	assign out = {{10{in[21]}}, in};

endmodule

module signext_28(
		input [27:0] in,
		output [31:0] out
    );

	assign out = {{4{in[21]}}, in};

endmodule