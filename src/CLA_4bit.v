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

module cla_4bit_augmented(
   input [3:0] in1,
   input [3:0] in2,
   input c_in,
   output [3:0] s,
//  output c_out,
   output p_out,
   output g_out
   );

   //////////////////// calculate bitwise generate and propogate ////////////////////
   // pi --> in1 ^ in2
   // gi --> in1 & in2

   wire [3:0] p,g,c;  // propogate, generate and carry
   assign p = in1 ^ in2;
   assign g = in1 & in2;


   // logic for generating sum and carry
   // si --> pi ^ ci
   // c_i+1 --> gi + pici

   // C1 = G0 + P0Cin
   // C2 = G1 + P1C1 = G1 + P1G0 + p1P0Cin
   // C3 = G2 + P2C2 = G2 + P2P1G0 + P2P1P0Cin
   // C4 = G3 + P3C3 = G3 + P3G2 + P3P2G1 + P3P2P1G0 + P3P2P1P0Cin

   // From the above Boolean equations we can observe that C4 does not have to wait for C3 and C2 to propagate but actually C4 is propagated at the same time as C3 and C2    


   //////////////////// calculate carry ////////////////////
   assign c[0] = c_in;
   assign c[1] = g[0] | (p[0] & c[0]);
   assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
   assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);

   //////////////////// calculate sum ////////////////////

   assign s = p ^ c;

   // compute block propagate and generate for the next level
   assign p_out = p[3] & p[2] & p[1] & p[0];
   assign g_out = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

//   assign c_out = g_out + (p_out & c_in);
endmodule
 