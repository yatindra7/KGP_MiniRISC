/*
 * Assignment	: 3
 * Problem No.	: 1
 * Semester		: Autumn 2022 
 * Group 		: 31
 * Name1 		: Srishty Gandhi
 * RollNumber1 	: 20CS30052
 * Name2 		: Yatindra Indoria
 * RollNumber2 	: 20CS30060
*/

`timescale 1ns / 1ps

module cla_16bit_augmented(
    input [15:0] in1,
    input [15:0] in2,
    input c_in,
    output [15:0] s,
    output c_out,
    output p_out,
    output g_out
    );
	 
	wire [4:0] c; // wires for connecting carries from lookahead carry unit to the 4-bit CLAs
	wire [3:0] p, g; // wires for connecting block propagate and generate from 4-bit CLAs to lookahead carry unit
	 
	// 16 bit adder by using four augmented 4-bit CLAs and a lookahead carry unit
	cla_4bit_augmented cla1(.in1(in1[3:0]), .in2(in2[3:0]), .c_in(c_in), .s(s[3:0]), .p_out(p[0]), .g_out(g[0]));
	cla_4bit_augmented cla2(.in1(in1[7:4]), .in2(in2[7:4]), .c_in(c[1]), .s(s[7:4]), .p_out(p[1]), .g_out(g[1]));
	cla_4bit_augmented cla3(.in1(in1[11:8]), .in2(in2[11:8]), .c_in(c[2]), .s(s[11:8]), .p_out(p[2]), .g_out(g[2]));
	cla_4bit_augmented cla4(.in1(in1[15:12]), .in2(in2[15:12]), .c_in(c[3]), .s(s[15:12]), .p_out(p[3]), .g_out(g[3]));
	
	lookahead_carry_unit lcu(.c_in(c_in), .p(p), .g(g), .c(c), .p_out(p_out), .g_out(g_out));
	
	assign c_out = c[4];


endmodule