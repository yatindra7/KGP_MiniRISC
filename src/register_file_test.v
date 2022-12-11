`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:02:54 11/10/2022
// Design Name:   register_file
// Module Name:   /home/yatindra/tools/Xilinx/projs/ise/KGP_MiniRISC/register_file_test.v
// Project Name:  KGP_MiniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register_file
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module register_file_test;

	// Inputs
	reg [5:0] reg1addr;
	reg [5:0] reg2addr;
	reg [1:0] write_reg_ctl;
	reg [31:0] write_data;
	reg clk;
	reg rst;

	// Outputs
	wire [31:0] reg1out;
	wire [31:0] reg2out;
	wire [31:0] retReg;

	// Instantiate the Unit Under Test (UUT)
	register_file uut (
		.reg1addr(reg1addr), 
		.reg2addr(reg2addr), 
		.write_reg_ctl(write_reg_ctl), 
		.write_data(write_data), 
		.reg1out(reg1out), 
		.reg2out(reg2out), 
		.clk(clk), 
		.rst(rst), 
		.retReg(retReg)
	);

	initial begin
		// Initialize Inputs
		rst <= 1;
		reg1addr <= 0;
		reg2addr <= 0;
		write_reg_ctl <= 0;
		write_data <= 0;
		clk <= 0;

		#100
		rst <= 0;

		$monitor($time, " VAL1: %d, VAL2: %d, OUT1: %d, OUT2: %d, CTL: %b, DATA: %d", 
				reg1addr, reg2addr, reg1out, reg2out, write_reg_ctl, write_data);
		// Wait 100 ns for global reset to finish
		#300;
		reg1addr <= 6'd1;
		reg2addr <= 6'd5;
		write_reg_ctl <= 2'b10;
		write_data <= 32'd36;

		#300;
		reg1addr <= 6'd1;
		reg2addr <= 6'd5;
		write_reg_ctl <= 2'b11;
		write_data <= 32'd63;

		#300;
		reg1addr <= 6'd1;
		reg2addr <= 6'd5;
		write_reg_ctl <= 2'b10;
		write_data <= 32'd69;

		#300;
		reg1addr <= 6'd1;
		reg2addr <= 6'd5;
		write_reg_ctl <= 2'b11;
		write_data <= 32'd36;	

		#500
		$finish;
		// Add stimulus here

	end
   always begin
		#5 clk = ~clk;
	end
endmodule

