`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:39:17 11/13/2022 
// Design Name: 
// Module Name:    test_with_alu 
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
module KGP_MiniRISC(
	input clk,
			rst,
	output [3:0] opcode,
	output [10:0] funct,
	output [4:0] shamt,
	output [31:0] pc_in,
	output [31:0] reg_show1, reg_show2, reg_show3, reg_show4, reg_show5,
	output [31:0] reg_show6, reg_show7, reg_show8, reg_show9, reg_show10	
    );

	wire ALUSrc, IMMSel, MemWrite, MemRead;
	wire [2:0] ALUOp;
	wire [1:0] WriteReg, MemRegPC;
	//wire [15:0] mem_before_extend;
	//wire [21:0] branch_22_before_extend;
	//wire alu_zero, alu_carry, alu_sign;

	wire [31:0] ins, aluout;
	mem_time_system sys(
						.clk(clk),
						.rst(rst),
						.ins(ins),
						.pc_in(pc_in),
						.opcode(opcode),
						.funct(funct),
						.shamt(shamt),
						.ALUOp(ALUOp),
						.ALUSrc(ALUSrc),
						.IMMSel(IMMSel),
						.WriteReg(WriteReg),
						.MemRegPC(MemRegPC),
						.aluout(aluout),
						.MemWrite(MemWrite),
						.MemRead(MemRead),
							.reg_show1(reg_show1),
							.reg_show2(reg_show2),
							.reg_show3(reg_show3),
							.reg_show4(reg_show4),
							.reg_show5(reg_show5),
							.reg_show6(reg_show6),
							.reg_show7(reg_show7),
							.reg_show8(reg_show8),
							.reg_show9(reg_show9),
							.reg_show10(reg_show10)
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
