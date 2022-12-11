`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:49:48 11/11/2022
// Design Name:   kgp_minirisc
// Module Name:   /home/yatindra/tools/Xilinx/projs/ise/KGP_MiniRISC/minirisc_test.v
// Project Name:  KGP_MiniRISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: kgp_minirisc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

// Testbench for the KGP_MiniRISC top module
module minirisc_tb;

	// Inputs
	reg clk;
	reg rst;
	wire [3:0] opcode;
	wire [10:0] funct;
	integer i;
	// Instantiate the Unit Under Test (UUT)
	kgp_minirisc uut (
		.clk(clk), 
		.rst(rst),
		.opcode(opcode),
		.funct(funct)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
      #5 rst = 0;
		#10;

      //$display($time, " opcode: %b, opcode: %b", opcode, funct);
		$display ($time, " <> ProgramCounter: %d, InstructionOpCode: %d"
				, uut.datapath.pc_unit.pc, uut.datapath.ins);
      for(i=0;i<40;i=i+1) begin
			rst<=1;
			#20;
			rst<=0;
			#10;
			//uut.datapath.pc_unit.pc=i;
			#200;
			$display ($time, " <> ProgramCounter: %d, InstructionOpCode: %d"
				, uut.datapath.pc_unit.pc, uut.datapath.ins);
			$display($time, " opcode: %b, opcode: %b", opcode, funct);
			$display ($time, "Content in registers [2]: %d, [3]: %d, [4]: %d, [5]: %d, [8]: %d, [9]: %d", uut.datapath.regs.registers[2]
				, uut.datapath.regs.registers[3], uut.datapath.regs.registers[4], uut.datapath.regs.registers[5]
				, uut.datapath.regs.registers[8], uut.datapath.regs.registers[9]); 
		end
		#1000;
      $display ($time, "Content in registers [2]: %d, [3]: %d, [4]: %d, [5]: %d, [8]: %d, [9]: %d", uut.datapath.regs.registers[2]
				, uut.datapath.regs.registers[3], uut.datapath.regs.registers[4], uut.datapath.regs.registers[5]
				, uut.datapath.regs.registers[8], uut.datapath.regs.registers[9]); 
        if (uut.datapath.regs.registers[2] == -1) begin
            $display("Element not found.");
        end 
        
        
    end
    
    always begin
        #10 clk = ~clk;
    end
      
endmodule


