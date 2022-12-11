`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:54:23 11/10/2022 
// Design Name: 
// Module Name:    branching_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module branching_control(
	input [3:0] opcode,
	input zero,
			sign,
			carry,
	output reg [2:0] branch_ctl
    );
	
	always @(opcode or zero or sign or carry) begin
		case(opcode)
			4'b0110: branch_ctl <= {1'b1, 1'b0, 1'b0}; //b
			4'b0111: branch_ctl <= {1'b1, 1'b1, 1'b1}; //br
			4'b1000: begin
				if(sign)
					branch_ctl <= {1'b1, 1'b0, 1'b1}; //bltz
				else
					branch_ctl <= {1'b0, 1'b0, 1'b0}; //Not a branch
			end
			4'b1001: begin
				if(zero)
					branch_ctl <= {1'b1, 1'b0, 1'b1}; //bz
				else
					branch_ctl <= {1'b0, 1'b0, 1'b0}; //Not a branch
			end
			4'b1010: begin
				if(!zero)
					branch_ctl <= {1'b1, 1'b0, 1'b1}; //bnz
				else
					branch_ctl <= {1'b0, 1'b0, 1'b0}; //Not a branch
			end
			4'b1011: branch_ctl <= {1'b1, 1'b0, 1'b0}; //bl
			4'b1100: begin
				if(carry)
					branch_ctl <= {1'b1, 1'b0, 1'b0}; //bc
				else
					branch_ctl <= {1'b0, 1'b0, 1'b0}; //Not a branch
			end
			4'b1101: begin
				if(!carry)
					branch_ctl <= {1'b1, 1'b0, 1'b0}; //bnc
				else
					branch_ctl <= {1'b0, 1'b0, 1'b0}; //Not a branch
			end
			default: begin
				branch_ctl <= {1'b0, 1'b0,1'b0}; //Not a branch
			end
			endcase
	end

endmodule
