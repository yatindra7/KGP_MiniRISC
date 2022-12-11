`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:40:29 11/10/2022
// Design Name:   branching_mechanism
// Module Name:   /home/yatindra/tools/Xilinx/projs/ise/KGP_MiniRISC/branching_mechanism_test.v
// Project Name:  KGP_MiniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: branching_mechanism
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module branching_mechanism_test;

	// Inputs
	reg [31:0] pc_in;
	reg [31:0] branch_imm_in1;
	reg [31:0] branch_imm_in2;
	reg [31:0] branch_reg_in;
	reg [2:0] branch_ctl;

	// Outputs
	wire [31:0] pc_out;

	// Instantiate the Unit Under Test (UUT)
	branching_mechanism uut (
		.pc_in(pc_in), 
		.branch_imm_in1(branch_imm_in1), 
		.branch_imm_in2(branch_imm_in2), 
		.branch_reg_in(branch_reg_in), 
		.branch_ctl(branch_ctl), 
		.pc_out(pc_out)
	);

	initial begin
		// Initialize Inputs
		pc_in = 0;
		branch_imm_in1 = 0;
		branch_imm_in2 = 0;
		branch_reg_in = 0;
		branch_ctl = 0;

		$monitor($time, " pc_in = %d, branch_imm_in1 = %d, branch_imm_in2 = %d, branch_reg_in = %d, branch_ctl = %b, pc_out = %d| ",
						pc_in, branch_imm_in1, branch_imm_in2, branch_reg_in, branch_ctl, pc_out);
		
		// Wait 100 ns for global reset to finish
		#100;
		pc_in <= 32'd2;
		branch_imm_in1 <= 32'd2;
		branch_imm_in2 <= 32'd3;
		branch_reg_in <= 32'd69;
		branch_ctl <= 3'b111;

		#100;
		pc_in <= 32'd2;
		branch_imm_in1 <= 32'd2;
		branch_imm_in2 <= 32'd3;
		branch_reg_in <= 32'd69;
		branch_ctl <= 3'b010;

		#100;
		pc_in = 32'd2;
		branch_imm_in1 <= 32'd2;
		branch_imm_in2 <= 32'd3;
		branch_reg_in <= 32'd69;
		branch_ctl <= 3'b100;     

		#100;
		pc_in = 32'd2;
		branch_imm_in1 <= 32'd2;
		branch_imm_in2 <= 32'd3;
		branch_reg_in <= 32'd69;
		branch_ctl <= 3'b101;		
		
		#200
		$finish;
		// Add stimulus here

	end
      
endmodule

