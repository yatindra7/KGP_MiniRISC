`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:35:44 11/10/2022
// Design Name:   signext_16
// Module Name:   /home/yatindra/tools/Xilinx/projs/ise/KGP_MiniRISC/signext_16_test.v
// Project Name:  KGP_MiniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: signext_16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module signext_16_test;

	// Inputs
	reg [15:0] in;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	signext_16 uut (
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		$monitor($time, " Initial: %b, Final: %b", in, out);
		// Wait 100 ns for global reset to finish
		#100;
      in = 16'd23;
		#100;
      in = 16'd233;
		#100;
      in = 16'd123;
		#100;
      in = -16'd23;
		#200
		$finish;
		// Add stimulus here

	end
      
endmodule

