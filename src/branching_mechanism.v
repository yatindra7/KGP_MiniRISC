`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Yatindra Indoria, Srishty Gandhi
// Roll No: 20CS30060, 20CS30052
// Module Name:    Branching_Logic 
//////////////////////////////////////////////////////////////////////////////////

/*
	</>The Control Signals for the 2 MUXes in the branching logic.
		MUX0: This is used to select between PC+4 and Immediate-Branching
		MUX1: Used to select between the selected value from MUX0, and the
				register input (for the br instruction)
	</>pc_in[31:0]
		: The input <PC+4>
	</>branch_imm_in1[31:0]
		: The signextended and to be shifted input from the immediate branching
				constant *TO BE ADDED TO PC+4* for generating the final output
	</>branch_imm_in2[31:0]
		: The signextended and to be shifted input from the immediate branching
				constant *TO BE ADDED TO PC+4* for generating the final output
	</>branch_reg_in[31:0]
		: The address loaded straight from the register (in br)
	</>pc_out[31:0]
		: The output PC (Porgram Counter)	
	</>branch_ctl[2:0] (The 3 bit control signal)
		: branch_ctl[0]: 1 => branch_imm_in1
							: 0 => branch_imm_in2
		: branch_ctl[1]: 1 => branch_reg_in
							: 0 => final_branch_imm
		: branch_ctl[2]: 1 => temp_branch
							: 0 => pc_in
*/
module branching_mechanism(
								input [31:0] pc_in,
										branch_imm_in1,
										branch_imm_in2,
										branch_reg_in,
								input [2:0] branch_ctl,
								output [31:0] pc_out
									);
	
	/*
		final_branch_imm: final immediate value being considered (out of the 22 and 28 bit signextended ones)
		temp_branch_imm1: selected value of the two
		temp_branhc_imm2: output after the shifter
		final_branhc_imm: output after addition
	*/
	wire [31:0] final_branch_imm, temp_branch_imm1, temp_branch_imm2, temp_branch;
	assign final_branch_imm = temp_branch_imm2-32'd4;				// Adding PC+4, and the signextended and shifted branch

	//MUX to select out of the two values
	mux mux_sel(.in1(branch_imm_in1), .in2(branch_imm_in2), .sel(branch_ctl[0]), .out(temp_branch_imm1));
	shift_by_two shft_imm(.in(temp_branch_imm1), .out(temp_branch_imm2));
	//Instead of shift
	//assign temp_branch_imm2 = temp_branch_imm1;
	
	//MUXes to select between the final immediate as well as register as well PC+4
	mux mux0(.in1(branch_reg_in), .in2(final_branch_imm), .sel(branch_ctl[1]), .out(temp_branch));
	mux mux1(.in1(temp_branch), .in2(pc_in), .sel(branch_ctl[2]), .out(pc_out));

endmodule 