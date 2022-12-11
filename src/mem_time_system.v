`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:54:10 11/13/2022 
// Design Name: 
// Module Name:    mem_time_system 
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
module mem_time_system(
	input clk,
	input rst,
	input ALUSrc,
			IMMSel,
			MemWrite,
			MemRead,
	input [2:0] ALUOp,
	input [1:0] WriteReg,
					MemRegPC,
	output [31:0] ins,
						pc_in,
	output [31:0] aluout,
	output [3:0] opcode,
	output [10:0] funct,
	output [4:0] shamt,
	output [31:0] reg_show1, reg_show2, reg_show3, reg_show4, reg_show5,
	output [31:0] reg_show6, reg_show7, reg_show8, reg_show9, reg_show10
    );

	wire [15:0] mem_before_extend;
	wire [21:0] branch_22_before_extend;
	wire alu_zero, alu_carry, alu_sign;
	wire [27:0] branch_28_before_extend;
	wire mem_enable;

	assign opcode = ins[31:28];
	assign funct = ins[10:0];
	assign shamt = ins[15:11];
	assign mem_before_extend = ins[15:0];
	assign branch_22_before_extend = ins[21:0];
	assign branch_28_before_extend = ins[27:0];

	wire [31:0] reg1out, reg2out, aluin, mem_after_extend, branch_22_after_extend, pc_new, mem_out;
	wire [31:0] branch_28_after_extend, final_imm, write_data, pc_write_out;
	wire [5:0] reg1, reg2;
	wire [3:0] alu_control_signal;
	wire [2:0] branch_ctl;
	
	assign reg1 = ins[27:22];
	assign reg2 = ins[21:16];
	assign mem_enable = MemWrite | MemRead;

	program_counter pc_unit(
						.pc_final_in(pc_write_out),
						.clk(clk),
						.rst(rst),
						.pc_out(pc_new)
						);

	//Program Cunter increment logic
	pc_inc pc_inc_unit(
				.pc_new(pc_new),
				.pc_in(pc_in)
			);

	/*
		Adding the memories
	*/
	instruction_fetcher instruction_rom (
										.clk(clk),						// input ena
										.pc(pc_in),				// input [31 : 0] address is actually the output of the ALU
										.instr(ins)						// output [31 : 0] 
										);
	alu alu_unit(
		.input1(reg1out),
		.input2(aluin),
		.shamt(shamt),
		.control(alu_control_signal),
		.out(aluout),
		.zero(alu_zero),
		.carry(alu_carry),
		.sign(alu_sign)
		);
	
	alu_control aluctl(
							.alu_op(ALUOp),
							.func_code(funct[3:0]),
							.alu_control_signal(alu_control_signal)
							);

	signext_16 s16(
						.in(mem_before_extend),
						.out(mem_after_extend)
						);

	signext_22 s22(
						.in(branch_22_before_extend),
						.out(branch_22_after_extend)
						);

	signext_28 s28(
						.in(branch_28_before_extend),
						.out(branch_28_after_extend)
						);

	mux mux_immsel1(
					.in1(branch_22_after_extend),
					.in2(mem_after_extend),
					.sel(IMMSel),
					.out(final_imm)
					);

	mux mux_alusrc(
					.in1(reg2out),
					.in2(final_imm),
					.sel(ALUSrc),
					.out(aluin)
					);

	reg_write rw_unit(
							.mem(mem_out),
							.alu_out(aluout),
							.pc_in(pc_in),
							.sel(MemRegPC),
							.write_data(write_data)
							);

	register_file regs(
							.reg1addr(reg1),
							.reg2addr(reg2),
							.write_data(write_data),
							.reg1out(reg1out),
							.reg2out(reg2out),
							.write_reg_ctl(WriteReg),
							.clk(clk),
							.rst(rst),
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

	branching_control branchctl_unit(
							.opcode(opcode),
							.zero(alu_zero),
							.sign(alu_sign),
							.carry(alu_carry),
							.branch_ctl(branch_ctl)
							);
	branching_mechanism branch_unit(
								.branch_ctl(branch_ctl),
								.branch_imm_in1(branch_22_after_extend),
								.branch_imm_in2(branch_28_after_extend),
								.branch_reg_in(reg1out),
								.pc_in(pc_in),
								.pc_out(pc_write_out)
								);

	data_memory data_ram (
								.clk(~clk), // input clka
								.enable(mem_enable), // input ena
								.write_enable(MemWrite), // input [3 : 0] wea
								.address(aluout), // input [31 : 0] addra
								.write_data(reg2out), // input [31 : 0] dina
								.data_out(mem_out) // output [31 : 0] douta
								);
endmodule
