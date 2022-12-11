`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:41:08 11/10/2022 
// Design Name: 
// Module Name:    main_control 
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
module kgp_mini_risc_datapath(
	//Control Signals for Input
	input ALUSrc,
			IMMSel,
			MemWrite,
			MemRead,
	input [2:0] ALUOp,
	input [1:0] WriteReg,
					MemRegPC,
	//Clock and Reset
	input clk,
			rst,
	output [3:0] opcode
    );

	/*********WIRE INSTANTIATION*********/

	/*
	 * Wires for the Registerfile
	 */


	//Wire for instruction
	wire [31:0] ins;
	wire [10:0] funct;

	//Wires for Registerfile
	wire [5:0] reg1, reg2;

	//Data wires for Registerfile
	wire [31:0] write_data, reg1out, reg2out;	


	/*
	 * Wires for the ALU Connctions
	 */
	

	/*Wires for branching constnt and immediate 
	constant extension (important for the ALU)*/
	wire [21:0] branch_22_before_extend;
	wire [27:0] branch_28_before_extend;

	//Wires after the extension
	wire [31:0] branch_22_after_extend, branch_28_after_extend;

	//Wires for extension in case of memory instructions
	wire [15:0] mem_before_extend;
	wire [31:0] mem_after_extend;

	//Wire for immediate constant selection
	wire [31:0] final_imm;


	/*Wire for final ALU Input after selection between 
	immedaite and regsiter values and the wire for the
	ALU Output after calculation(other than final_imm)*/
	wire [31:0] aluin, aluout;
	wire alu_zero, alu_carry, alu_sign;

	//Wire for ALU Control
	wire [3:0] alu_control_signal;


	/*
	 * Wires for the reg_write module
	 */


	wire [31:0] mem_out, pc_in; //aluout already defined


	/*
	 * Wires for Branching Mechanism and the Program counter
	 */


	//The branch_ctl
	wire [2:0] branch_ctl;

	//The outputt (also the input to the PC)
	wire [31:0] pc_write_out, pc_new;

	/*********WIRE ASSIGNMENTS*********/

	//Wires for output
	assign opcode = ins[31:28];
	assign funct = ins[10:0];
	assign reg1 = ins[27:22];
	assign reg2 = ins[21:16];

	//Wires for the branching and immediate instructions
	assign branch_22_before_extend = ins[21:0];
	assign branch_28_before_extend = ins[27:0];
	assign mem_before_extend = ins[15:0];

	//ALU Util shamt
	wire [4:0] shamt;
	assign shamt = ins[15:11];

	//Memory Enable
	wire mem_enable;
	assign mem_enable = MemWrite | MemRead;

	/*********MODULE INSTANTIATION*********/


	/*
		Register file accesses
	*/

	//The Registerfile
	register_file regs(
							.reg1addr(reg1),
							.reg2addr(reg2),
							.write_data(write_data),
							.reg1out(reg1out),
							.reg2out(reg2out),
							.write_reg_ctl(WriteReg),
							.clk(clk),
							.rst(rst)
							);
	/*
		The ALU
	*/

	//ALU Control uint instantiation
	alu_control aluctl(
							.alu_op(ALUOp),
							.func_code(funct[3:0]),
							.alu_control_signal(alu_control_signal)
							);

	//Sign extension done
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

	//Muxes to choose the immediate constant to be provided to the adder
	/* SELECT: IMMSel[1:0]
		XXIMMSel[0]: 1 => branch_22_after_extend
		XX			: 0 => branch_28_after_extend
		IMMSel[1]: 1 => imm_temp
					: 0 => mem_after_extend
	*/
	//mux mux_immsel0(.in1(branch_22_after_extend), .in2(branch_28_after_extend), .sel(IMMSel[0]), .out(imm_temp));
	mux mux_immsel1(
					.in1(branch_22_after_extend),
					.in2(mem_after_extend),
					.sel(IMMSel),
					.out(final_imm)
					);
	
	/* MUX for selecting between immediate constant or register in ALU
		ALUSrc: 1 => reg2out
				: 0 => final_imm
	*/
	mux mux_alusrc(
					.in1(reg2out),
					.in2(final_imm),
					.sel(ALUSrc),
					.out(aluin)
					);
	
	/*
		zero: Flag to reflect if an input is 0
		carry: The flag to reflect the carry value
		sign: The flag to reflect the signed bit for
				effcient evlauation of 'bz', and 'bnz'
	*/
	//Instantiating the ALU
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

	/*
		Register writeback unit
	*/
	reg_write rw_unit(
							.mem(mem_out),
							.alu_out(aluout),
							.pc_in(pc_in),
							.sel(MemRegPC),
							.write_data(write_data)
							);
	/*
		Branching Mechanism
	*/

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
										.pc(pc_new),				// input [31 : 0] address is actually the output of the ALU
										.instr(ins)						// output [31 : 0] 
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
