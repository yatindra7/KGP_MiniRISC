`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:57:03 11/13/2022
// Design Name:   mem_time_system
// Module Name:   /home/yatindra/tools/Xilinx/projs/ise/KGP_MiniRISC/mem_sys_test.v
// Project Name:  KGP_MiniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mem_time_system
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mem_sys_test;

	// Inputs
	reg clk;
	reg rst;
	integer i;
	// Outputs
	wire [31:0] ins, pc_in;
	wire [3:0] opcode;
	wire [10:0] funct;

	// Instantiate the Unit Under Test (UUT)
	mem_time_system uut (
		.clk(clk), 
		.rst(rst), 
		.ins(ins), 
		.opcode(opcode),
		.pc_new(pc_in),
		.funct(funct)
	);


	initial begin
		// Initialize Inputs
		$monitor($time, " <>pc_in: %d, opcode: %b", pc_in, opcode);
		clk = 0;
		rst = 0;

		rst = 1;
		#20;
		rst = 0;
		#5;
		// Wait 100 ns for global reset to finish
		#100;
      for(i=0;i<100;i=i+1) begin
			$monitor($time, " pc_in: %d, opcode: %d, funct: %d", pc_in, opcode, funct);
		end
		// Add stimulus here

	end
   always #5 clk = ~clk;
endmodule

