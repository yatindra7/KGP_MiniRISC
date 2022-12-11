`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:56:18 11/11/2022 
// Design Name: 
// Module Name:    instruction_fetcher 
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
module instruction_fetcher(
	input [31:0] pc,
	input clk,
	output [31:0] instr
    );

	in_rom InstrROM(
							.clka(clk),
							.ena(1'b1),
							.addra(pc),
							.douta(instr)
							);

endmodule
