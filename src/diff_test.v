`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:32:30 11/11/2022
// Design Name:   diff
// Module Name:   /home/yatindra/tools/Xilinx/projs/ise/KGP_MiniRISC/diff_test.v
// Project Name:  KGP_MiniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: diff
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module diff_test;

	// Inputs
	reg [31:0] in1;
	reg [31:0] in2;

	// Outputs
	wire [31:0] out;
	integer i, j;

	// Instantiate the Unit Under Test (UUT)
	diff uut (
		.in1(in1), 
		.in2(in2), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in1 = 0;
		in2 = 0;

		$monitor($time, " in1: %b, in2: %b, out: %b", in1, in2, out);
		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		for(i=0;i<10;i=i+1) begin
			j = i + i;
			in1 = i;
			in2 = j;
			#300;
		end

	end
      
endmodule

