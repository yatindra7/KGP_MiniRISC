`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:15:42 11/11/2022 
// Design Name: 
// Module Name:    reg_write 
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
*	The below is used for:	1> Writing the output of the ALU back into the registerfile
*									2> Writing the value from memory to the registerfile
*									3> Writing the 
*/	
module reg_write(
	input [31:0] mem,
					alu_out,
					pc_in,
	input [1:0] sel,
	output [31:0] write_data
    );

	wire [31:0] temp_data;
	assign temp_data = sel[0] ? mem: alu_out;
	assign write_data = sel[1] ? temp_data: pc_in;

endmodule
