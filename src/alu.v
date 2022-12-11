`timescale 1ns / 1ps

module alu(
    input signed [31:0] input1,
    input [31:0] input2,
    input [4:0] shamt,
    input [3:0] control,
    output reg [31:0] out,
    output zero,
				sign,
	 output reg carry
    );

    wire [31:0] sum, compliment, bitand, bitxor, sll, srl, sra;
    wire sumcarry;
    wire [31:0] shamt_muxout; // whether to take shift from reg or shamt

    // sum using the cla developed in assignment 1, cascading two 16-bit clas
    wire sum_c_out, p1, g1, p2, g2;
    cla_16bit_augmented cla1(
									.in1(input1[15:0]),
									.in2(input2[15:0]),
									.c_in(1'b0),
									.s(sum[15:0]),
									.c_out(sum_c_out),
									.p_out(p1),
									.g_out(g1)
									);
    cla_16bit_augmented cla2(
									.in1(input1[31:16]),
									.in2(input2[31:16]),
									.c_in(sum_c_out),
									.s(sum[31:16]),
									.c_out(sumcarry),
									.p_out(p2),
									.g_out(g2)
									);

    assign zero = input1 == 32'b0 ? 1'b1 : 1'b0; // 
    assign sign = input1[31] == 1'b1 ? 1'b1 : 1'b0;
    assign compliment = ~input2 + 1'b1;
    assign bitand = input1 & input2;
    assign bitxor = input1 ^ input2;
    
    assign shamt_muxout = control[0] ? input2 : {27'b0, shamt};
    assign sll = input1 << shamt_muxout;
    assign srl = input1 >> shamt_muxout;
    assign sra = input1 >>> shamt_muxout;

    wire [31:0] diff;
    diff diff1(.in1(input1), .in2(input2), .out(diff));

    always @(*) begin

        case(control[3:0])
            4'b1000: 
                begin
                    out = sum;
                    carry = sumcarry;
                end
            4'b1001:
                begin
                    out = compliment;
                    carry = 1'b0;
                end
            4'b1010:
                begin
                    out = bitand;
                    carry = 1'b0;
                end
            4'b1011:
                begin
                    out = bitxor;
                    carry = 1'b0;
                end
            4'b0100:
                begin
                    out = sll;
                    carry = 1'b0;
                end
            4'b0101:
                begin
                    out = srl;
                    carry = 1'b0;
                end
            4'b1100:
                begin
                    out = sll;
                    carry = 1'b0;
                end
            4'b1101:
                begin
                    out = srl;
                    carry = 1'b0;
                end
            4'b1110:
                begin
                    out = sra;
                    carry = 1'b0;
                end
            4'b0110:
                begin
                    out = sra;
                    carry = 1'b0;
                end
            4'b1111:
                begin
                    out = diff;
                    carry = 1'b0;
                end
            4'b0111:
                begin
                    out = 32'b0;
                    carry = 1'b0;
                end
            default:
                begin
                    out = 32'b0;
                    carry = 1'b0;
                end
        endcase
    end
endmodule