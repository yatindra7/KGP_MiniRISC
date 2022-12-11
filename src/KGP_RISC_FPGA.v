`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:06 11/14/2022 
// Design Name: 
// Module Name:    KGP_RISC_FPGA 
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
module KGP_RISC_FPGA(
    input clk,
    input rst,
    input [3:0] opcode,
    output [31:0] reg_show5,
				reg_show6,
				reg_show8,
				reg_show9
    );

	wire [31:0] reg_show1, reg_show2, reg_show3, reg_show4;
	wire [31:0] reg_show7, reg_show10;
	wire slow_clk;
	wire [10:0] funct;
	wire [4:0] shamt;
	wire [31:0] pc_in;
	KGP_MiniRISC mod(
							.clk(slow_clk),
							.rst(rst),
							.opcode(opcode),
							.funct(funct),
							.shamt(shamt),
							.pc_in(pc_in),
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

	clock_divider div(
							.clk(clk),
							.clock_out(slow_clk)
							);

endmodule
