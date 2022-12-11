`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:48:34 11/11/2022 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory(
    input [31:0] address,
    input clk,
    input enable,
    input write_enable,
    input [31:0] write_data,
    output [31:0] data_out
    );
	
	data_bram DataRAM (.clka(clk), .ena(enable), .wea({4{write_enable}}), .addra(address), .dina(write_data), .douta(data_out));

endmodule
