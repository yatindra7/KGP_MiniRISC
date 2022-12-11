`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:17:05 11/13/2022
// Design Name:   test_with_alu
// Module Name:   /home/yatindra/tools/Xilinx/projs/ise/KGP_MiniRISC/test_w_alu_tb.v
// Project Name:  KGP_MiniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: test_with_alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module KGP_MiniRISC_tb;

	// Inputs
	reg clk;
	reg rst;
	integer i;

	// Outputs
	wire [3:0] opcode;
	wire [10:0] funct;
	wire [4:0] shamt;
	wire [31:0] pc_in;
	wire [31:0] reg_show1, reg_show2, reg_show3, reg_show4, reg_show5;
	wire [31:0] reg_show6, reg_show7, reg_show8, reg_show9, reg_show10;

	// Instantiate the Unit Under Test (UUT)
	KGP_MiniRISC uut (
		.clk(clk), 
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

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		#5;
		rst = 1;
		#5;
		rst = 0;

      $monitor($time, " pc: %d, opcde: %d, funct: %d, shamt: %d", pc_in, opcode, funct, shamt);
		for(i=0;i<100;i=i+1) begin
			$monitor($time, " pc: %d, opcde: %d, funct: %d, shamt: %d, $1: %d, $2: %d, $3: %d, $4: %d, $5: %d, $6: %d, $7: %d, $8: %d, $9: %d", 
			pc_in, opcode, funct, shamt, reg_show1, reg_show2, reg_show3, reg_show4, reg_show5, reg_show6, reg_show7, reg_show8, reg_show9);
			//$monitor($time, " pc: %d, $1: %d, $2: %d, $3: %d", pc_in, uut.sys.regs.registers[0], uut.sys.regs.registers[1], uut.sys.regs.registers[2]);
			#5;
		end
		// Add stimulus here

	end
	always #5 clk = ~clk;
      
endmodule

