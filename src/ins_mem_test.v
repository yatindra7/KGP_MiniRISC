`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:21:48 11/11/2022
// Design Name:   instruction_fetcher
// Module Name:   /home/yatindra/tools/Xilinx/projs/ise/KGP_MiniRISC/ins_mem_test.v
// Project Name:  KGP_MiniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: instruction_fetcher
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ins_mem_test;

	// Inputs
	reg [31:0] pc;
	reg clk;
	integer i;

	// Outputs
	wire [31:0] instr;

	// Instantiate the Unit Under Test (UUT)
	instruction_fetcher uut (
		.pc(pc), 
		.clk(clk), 
		.instr(instr)
	);

	initial begin
		// Initialize Inputs
		pc = 0;
		clk = 0;

		$monitor($time, " >> %b", instr);
		// Wait 100 ns for global reset to finish
		$monitor($time, " pc=%d, instr=%d", pc, instr);
		for(i = 0; i<100; i=i+4) begin
			pc = i;
			#100;
		end
		// Add stimulus here

	end
	always #5 clk = ~clk;
      
endmodule

