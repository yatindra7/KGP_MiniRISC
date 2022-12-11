`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:32 11/11/2022 
// Design Name: 
// Module Name:    diff 
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
module diff(
	input [31:0] in1,
					in2,
	output reg [31:0] out
    );

	wire [31:0] temp_xor;
	integer i, temp_i;
	assign temp_xor = in1 ^ in2;

	always @(*) begin
		for (i = 31; i >= 0; i=i-1) begin
			if (temp_xor[i]) begin
				temp_i = i;
			end
		end

		for (i = 0; i < 32; i=i+1) begin
			if (i == temp_i) out[i] = 1'b1;
			else out[i] = 1'b0;
		end
	end

endmodule
