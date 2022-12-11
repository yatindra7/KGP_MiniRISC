`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:59:06 11/11/2022 
// Design Name: 
// Module Name:    pc_inc 
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
module pc_inc(
		input [31:0] pc_new,
		output [31:0] pc_in
    );
//Module for the increment of the
//PC to PC+4 in every case.

assign pc_in = pc_new + 32'd4;

endmodule
