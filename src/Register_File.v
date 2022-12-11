`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Yatindra Indoria, Srishty Gandhi
// Roll No: 20CS30060, 20CS30052
// Module Name:    Register_File 
//////////////////////////////////////////////////////////////////////////////////
module register_file(
    input [5:0] reg1addr,
    input [5:0] reg2addr,
    input [1:0] write_reg_ctl,
    input [31:0] write_data,
    output [31:0] reg1out,
    output [31:0] reg2out,
	 output [31:0] reg_show1, reg_show2, reg_show3, reg_show4, reg_show5,
	 output [31:0] reg_show6, reg_show7, reg_show8, reg_show9, reg_show10,
    input clk,
    input rst
    );
	 //Register array init: **64 REGISTERS: 32 BIT**
    reg [31:0] registers[63:0];

	 assign reg_show1=registers[1];
	 assign reg_show2=registers[2];
	 assign reg_show3=registers[3];
	 assign reg_show4=registers[4];
	 assign reg_show5=registers[5];
	 assign reg_show6=registers[6];
	 assign reg_show7=registers[7];
	 assign reg_show8=registers[8];
	 assign reg_show9=registers[9];	 
	 assign reg_show10=registers[10];

	 integer i;

	 //Assigning the output wires for *READ*
    assign reg1out = registers[reg1addr];
    assign reg2out = registers[reg2addr];

	 //Sequential Logic for *WRITE*
    always @(posedge clk) begin
        if(rst) begin
				//Setting all the 64 registers to 0
				for(i=0;i<64;i=i+1)
					registers[i] <= 0;
        end else begin
            case(write_reg_ctl)
                2'b10: registers[reg1addr] <= write_data;
                2'b11: registers[reg2addr] <= write_data;
                2'b01: registers[6'b011111] <= write_data;	// (bl) Support for the Branch and Link Instruction
					 default: begin
						/*Ignore the instruction, no write*/
					 end
            endcase
        end
    end
endmodule
