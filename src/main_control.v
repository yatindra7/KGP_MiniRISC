`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:30:17 11/10/2022 
// Design Name: 
// Module Name:    main_control 
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
module main_control(
	input [3:0] opcode,
	output reg ALUSrc,
					IMMSel,
					MemWrite,
					MemRead,
	output reg [2:0] ALUOp,
	output reg [1:0] WriteReg,
					MemRegPC
    );

	//assign x = 1'b0;
	always @(*) begin
	case(opcode)
		4'b0001: begin //ALU-1
			ALUSrc <= 1;
			IMMSel <= 0;
			ALUOp <= 3'b100;
			WriteReg <= 2'b10;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b10;
		end
		4'b0010: begin //addi-2
			ALUSrc <= 0;
			IMMSel <= 1;
			ALUOp <= 3'b110;
			WriteReg <= 2'b10;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b10;
		end
		4'b0011: begin	//compi-3
			ALUSrc <= 0;
			IMMSel <= 1;
			ALUOp <= 3'b101;
			WriteReg <= 2'b10;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b10;
		end
		4'b0100: begin	//lw-4
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b001;
			WriteReg <= 2'b11;
			MemWrite <= 0;
			MemRead <= 1;
			MemRegPC <= 2'b11;
		end
		4'b0101: begin	//sw-5
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b001;
			WriteReg <= 2'b00;
			MemWrite <= 1;
			MemRead <= 0;
			MemRegPC <= 2'b00;
		end
		4'b0110: begin //b-6
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b000;
			WriteReg <= 2'b00;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'bxx;
		end
		4'b0111: begin //br-7
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b000;
			WriteReg <= 2'b00;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b00;
		end
		4'b1000: begin //bltz-8
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b000;
			WriteReg <= 2'b00;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b00;
		end
		4'b1001: begin //bz-9
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b000;
			WriteReg <= 2'b00;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b00;
		end
		4'b1010: begin //bnz-10
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b000;
			WriteReg <= 2'b00;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b00;
		end
		4'b1011: begin //bl-11
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b000;
			WriteReg <= 2'b01;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b00;
		end
		4'b1100: begin //bcy-12
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b000;
			WriteReg <= 2'b00;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b00;
		end
		4'b1101: begin //br-13
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b000;
			WriteReg <= 2'b00;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b00;
		end
		4'b1110: begin //diff-14
			ALUSrc <= 1;
			IMMSel <= 0;
			ALUOp <= 3'b111;
			WriteReg <= 2'b10;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b10;
		end
		default begin
			ALUSrc <= 0;
			IMMSel <= 0;
			ALUOp <= 3'b000;
			WriteReg <= 2'b00;
			MemWrite <= 0;
			MemRead <= 0;
			MemRegPC <= 2'b00;
		end
		endcase
end

endmodule
