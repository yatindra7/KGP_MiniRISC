`timescale 1ns / 1ps

module alu_control(
    input [2:0] alu_op,
    input [3:0] func_code,
    output reg [3:0] alu_control_signal
    );

    /*
        Assign the values based on the following table:
                ALUop (from control unit) - Function Code - Control Signal
        add     100                       - 0000          - 1000
        comp    100                       - 0001          - 1001
        AND     100                       - 0010          - 1010
        XOR     100                       - 0011          - 1011
        SLL     100                       - 0100          - 0100
        SRL     100                       - 0101          - 0101
        SLLv    100                       - 0110          - 1100
        SRLv    100                       - 0111          - 1101
        SRA     100                       - 1000          - 0110
        SRAv    100                       - 1001          - 1110
        addi    110                       - NA            - 1000
        compi   101                       - NA            - 1001
        Diff     111                       - x             - 1111
        lw      001                       - NA            - 1000
        sw      001                       - NA            - 1000
        any other control signal will give values of flag 1 and flag 0 (i.e. zero and negative) and flag 2 and out will be zero 
    */

    always @(*) begin
        case(alu_op)
            3'b100:
                begin
                    case(func_code)
                        4'b0000: alu_control_signal <= 4'b1000; // add
                        4'b0001: alu_control_signal <= 4'b1001; // comp
                        4'b0010: alu_control_signal <= 4'b1010; // AND
                        4'b0011: alu_control_signal <= 4'b1011; // XOR
                        4'b0100: alu_control_signal <= 4'b0100; //SLL
                        4'b0101: alu_control_signal <= 4'b0101; //SRL
                        4'b0110: alu_control_signal <= 4'b1100; //SLLv
                        4'b0111: alu_control_signal <= 4'b1101; //SRLv
                        4'b1000: alu_control_signal <= 4'b0110; //SRA
                        4'b1001: alu_control_signal <= 4'b1110; //SRAv
                        default: alu_control_signal <= 4'b0111; 
                    endcase
                end
            3'b110: alu_control_signal <= 4'b1000; // addi
            3'b101: alu_control_signal <= 4'b1001; // compi
            3'b111: alu_control_signal <= 4'b1111; //Diff
            3'b001: alu_control_signal <= 4'b1000; //lw,sw
            default: alu_control_signal <= 4'b0111;
        endcase
    end

endmodule