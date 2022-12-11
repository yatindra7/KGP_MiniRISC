/*
 * Assignment	: 3
 * problem No.	: 1
 * Semester		: Autumn 2022 
 * group 		: 31
 * Name1 		: Srishty gandhi
 * RollNumber1 	: 20CS30052
 * Name2 		: Yatindra Indoria
 * RollNumber2 	: 20CS30060
 */

 `timescale 1ns / 1ps
module lookahead_carry_unit(
    input c_in,
    input [3:0] p,
    input [3:0] g,
    output [4:0] c,
    output p_out,
    output g_out
    );

/*
	Logic:
	
	c[i+1] --> g[i] | (p[i] & c[i])
	
	c[1] = g[0] | (p[0] & c[0]) = g[0] | (p[0] & c_in)
	c[2] = g[1] | (p[1] & c[1]) = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c_in)
	c[3] = g[2] | (p[2] & c[2]) = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c_in)
	c[4] = g[3] | (p[3] & c[3]) = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c_in)
	
	Also block propogate p_out and generate g_out are calculated as
	p_out = p[3] & p[2] & p[1] & p[0]
	g_out = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0])
*/
	
	// compute the carry bits
	assign c[0] = c_in;
	assign c[1] = g[0] | (p[0] & c_in);
	assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c_in);
	assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c_in);
	assign c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c_in);
	
	// compute block propagate and generate for the next level
	assign p_out = p[3] & p[2] & p[1] & p[0];
	assign g_out = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

endmodule