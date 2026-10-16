`timescale 1ns / 1ps

module ALUControl(
    input  logic [2:0] ALUOp,
    input  logic [2:0] func3,
    input  logic [6:0] func7,
    output logic [4:0] ALUOperation
);
    always_comb begin
        casez({ALUOp, func3, func7[5]})
            7'b000110?, 7'b101110?: ALUOperation = 5'b00000;
            7'b000111?, 7'b101111?: ALUOperation = 5'b00001;
            7'b100????, 7'b1010000, 7'b000000?, 7'b110????, 7'b001????, 7'b111????, 7'b010????: ALUOperation = 5'b00010;
            7'b1010001:            ALUOperation = 5'b00011;
            7'b101010?, 7'b000010?: ALUOperation = 5'b00101;
            7'b101001?, 7'b000001?: ALUOperation = 5'b01000;
            7'b101100?, 7'b000100?: ALUOperation = 5'b01001;
            7'b1011010, 7'b0001010: ALUOperation = 5'b01010;
            7'b1011011, 7'b0001011: ALUOperation = 5'b01011;
            7'b101011?, 7'b000011?: ALUOperation = 5'b01101;
            default:               ALUOperation = 5'b11111;
        endcase
    end
endmodule