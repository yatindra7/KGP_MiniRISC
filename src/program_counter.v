`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:46:16 11/11/2022 
// Design Name: 
// Module Name:    program_counter 
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
/*
	The program counter is updated at every clock cycle, the same is handled by the 
	clock cycle.
	The value incoming is determined by the branching logic in place
*/
module program_counter(
	input [31:0] pc_final_in,
	input				clk,
						rst,
	output [31:0] pc_out
    );

	reg [31:0] pc;
	assign pc_out = pc;

	always @(posedge clk or posedge rst) begin
		if (rst) pc <= 0;
		else pc <= pc_final_in;
	end

endmodule
