`timescale 1ns / 1ps

module ALU (
    input  logic [31:0] dataA,
    input  logic [31:0] dataB,
    input  logic [4:0]  ALUOperation,
    output logic [31:0] ALUOutput
);

    // Signaux intermédiaires 64 bits pour l'extension RV32M
    logic signed [63:0] signed_A, signed_B;
    logic        [63:0] unsigned_A, unsigned_B;

    logic signed [63:0] prod_ss;
    logic signed [63:0] prod_su;
    logic        [63:0] prod_uu;

    assign signed_A   = $signed(dataA);
    assign signed_B   = $signed(dataB);
    assign unsigned_A = {32'b0, dataA};
    assign unsigned_B = {32'b0, dataB};

    assign prod_ss = signed_A * signed_B;
    assign prod_su = signed_A * unsigned_B;
    assign prod_uu = unsigned_A * unsigned_B;

    always_comb begin
        case (ALUOperation)
            // --- Instructions de base RV32I ---
            5'b00000: ALUOutput = dataA | dataB;                                       // OR
            5'b00001: ALUOutput = dataA & dataB;                                       // AND
            5'b00010: ALUOutput = dataA + dataB;                                       // ADD
            5'b00011: ALUOutput = dataA - dataB;                                       // SUB
            5'b00101: ALUOutput = ($signed(dataA) < $signed(dataB)) ? 32'd1 : 32'd0;  // SLT
            5'b01000: ALUOutput = dataA << dataB[4:0];                                 // SLL
            5'b01001: ALUOutput = dataA ^ dataB;                                       // XOR
            5'b01010: ALUOutput = dataA >> dataB[4:0];                                 // SRL
            5'b01011: ALUOutput = $signed(dataA) >>> dataB[4:0];                       // SRA
            5'b01101: ALUOutput = (dataA < dataB) ? 32'd1 : 32'd0;                     // SLTU

            // --- Extension RV32M ---
            5'b01110: ALUOutput = dataA * dataB;          // MUL
            5'b01111: ALUOutput = prod_ss[63:32];         // MULH
            5'b10000: ALUOutput = prod_su[63:32];         // MULHSU
            5'b10001: ALUOutput = prod_uu[63:32];         // MULHU

            5'b10010: begin // DIV
                if (dataB == 32'b0)
                    ALUOutput = 32'hFFFFFFFF;
                else
                    ALUOutput = $signed(dataA) / $signed(dataB);
            end

            5'b10011: begin // DIVU
                if (dataB == 32'b0)
                    ALUOutput = 32'hFFFFFFFF;
                else
                    ALUOutput = dataA / dataB;
            end

            5'b10100: begin // REM
                if (dataB == 32'b0)
                    ALUOutput = dataA;
                else
                    ALUOutput = $signed(dataA) % $signed(dataB);
            end

            5'b10101: begin // REMU
                if (dataB == 32'b0)
                    ALUOutput = dataA;
                else
                    ALUOutput = dataA % dataB;
            end

            default: ALUOutput = 32'b0;
        endcase
    end

endmodule