#  5-Stage Pipelined RISC-V Processor (RV32I + RV32M)

A 32-bit 5-stage pipelined processor core supporting the RISC-V base integer instruction set (RV32I) and hardware multiplication/division extensions (RV32M), implemented in SystemVerilog.

##  Architecture Features
- **Pipeline Stages:** Fetch (IF), Decode (ID), Execute (EX), Memory (MEM), WriteBack (WB).
- **RV32M Hardware Extension:** Complete ALU support for `MUL`, `MULH`, `MULHU`, `MULHSU`, `DIV`, `DIVU`, `REM`, `REMU`.
- **Hazard Handling:**
  - Forwarding Unit to handle RAW data hazards.
  - Hazard Detection Unit for Load-Use dependencies.
- **Tools Used:** ModelSim SE-64, SystemVerilog, VS Code.

##  Verification
Simulation and verification conducted in ModelSim with testbenches for individual units (ALU) and full datapath execution.