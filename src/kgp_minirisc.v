`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:21:16 11/11/2022 
// Design Name: 
// Module Name:    kgp_minirisc 
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
module kgp_minirisc(
    input clk,
    input rst,
	 output [3:0] opcode,
	 output [10:0] funct
    );

	wire ALUSrc, IMMSel, MemWrite, MemRead;
	wire [2:0] ALUOp;
	wire [1:0] WriteReg, MemRegPC;

	kgp_mini_risc_datapath datapath(
									.ALUSrc(ALUSrc),
									.IMMSel(IMMSel),
									.MemWrite(MemWrite),
									.MemRead(MemRead),
									.ALUOp(ALUOp),
									.WriteReg(WriteReg),
									.MemRegPC(MemRegPC),
									.opcode(opcode),
									.clk(clk),
									.rst(rst)
									);
	main_control controlunit(
									.ALUSrc(ALUSrc),
									.IMMSel(IMMSel),
									.MemWrite(MemWrite),
									.MemRead(MemRead),
									.ALUOp(ALUOp),
									.WriteReg(WriteReg),
									.MemRegPC(MemRegPC),
									.opcode(opcode)
					);

endmodule
