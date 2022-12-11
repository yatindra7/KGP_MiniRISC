`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:32:42 11/10/2022
// Design Name:   shift_by_two
// Module Name:   /home/yatindra/tools/Xilinx/projs/ise/KGP_MiniRISC/shitf_by_two_test.v
// Project Name:  KGP_MiniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: shift_by_two
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module shitf_by_two_test;

	// Inputs
	reg [31:0] in;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	shift_by_two uut (
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		$monitor($time, " The Input: %d, The Output: %d", in, out);
		// Wait 100 ns for global reset to finish
		#100;
      in = 2;
		#100
		in = 56;
		#100
		in = 12;
		#200
		$finish;
		// Add stimulus here

	end
      
endmodule

