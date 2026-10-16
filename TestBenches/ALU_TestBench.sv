`timescale 1ns / 1ps

module ALU_TestBench;

    logic [31:0] dataA, dataB;
    logic [4:0]  ALUOperation;
    logic [31:0] ALUOutput;

    // Connect to the ALU module
    ALU uut (
        .dataA(dataA),
        .dataB(dataB),
        .ALUOperation(ALUOperation),
        .ALUOutput(ALUOutput)
    );

    initial begin
        $display("========================================");
        $display("=== TESTING ALU WITH RV32M EXTENSION ===");
        $display("========================================");

        // 1. Test ADD (15 + 10 = 25)
        dataA = 32'd15; dataB = 32'd10; ALUOperation = 5'b00010; #10;
        $display("ADD:      %d + %d = %d (Expected: 25)", dataA, dataB, ALUOutput);

        // 2. Test MUL (6 * 7 = 42)
        dataA = 32'd6; dataB = 32'd7; ALUOperation = 5'b01110; #10;
        $display("MUL:      %d * %d = %d (Expected: 42)", dataA, dataB, ALUOutput);

        // 3. Test DIV (40 / 5 = 8)
        dataA = 32'd40; dataB = 32'd5; ALUOperation = 5'b10010; #10;
        $display("DIV:      %d / %d = %d (Expected: 8)", dataA, dataB, ALUOutput);

        // 4. Test REM (17 % 5 = 2)
        dataA = 32'd17; dataB = 32'd5; ALUOperation = 5'b10100; #10;
        $display("REM:      %d %% %d = %d (Expected: 2)", dataA, dataB, ALUOutput);

        // 5. Test DIV BY ZERO (10 / 0 = 0xFFFFFFFF)
        dataA = 32'd10; dataB = 32'd0; ALUOperation = 5'b10010; #10;
        $display("DIV ZERO: %d / %d = %h (Expected: ffffffff)", dataA, dataB, ALUOutput);

        $display("========================================");
        $display("=== TESTING FINISHED SUCCESSFULLY ===");
        $display("========================================");
        $finish;
    end

endmodule