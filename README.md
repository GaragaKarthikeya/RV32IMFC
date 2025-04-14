# RISC-V 32I CPU Implementation

A basic RISC-V CPU implementation in Verilog following the RV32I base instruction set architecture. This project provides a simple single-cycle CPU designed for educational purposes.

## Overview

This implementation features a complete single-cycle RISC-V CPU supporting core RV32I instructions. The design prioritizes clarity and educational value over performance optimizations.

![RISC-V Architecture](https://riscv.org/wp-content/uploads/2018/09/riscv-logo-1.png)

## Project Structure

The implementation consists of the following Verilog modules:

| File | Description |
|------|-------------|
| `riscv_cpu.v` | Top-level module integrating all components |
| `program_counter.v` | PC register controlling instruction flow |
| `instruction_memory.v` | ROM storing the program instructions |
| `register_file.v` | 32×32-bit register file |
| `alu.v` | Arithmetic Logic Unit supporting RV32I operations |
| `control_unit.v` | Instruction decoder and control signal generator |
| `data_memory.v` | RAM for load/store operations |
| `immediate_generator.v` | Creates immediate values from instruction fields |
| `tb_riscv_cpu.v` | Testbench for simulation and verification |

## Implemented Features

- Basic RV32I instruction execution
- 32-bit datapath
- 32 general-purpose registers
- Single-cycle execution model
- Memory-mapped I/O (basic implementation)

## Getting Started

### Prerequisites

- Icarus Verilog (`iverilog`)
- GTKWave (for waveform viewing)
- WSL2 or Linux environment

### Installation

For Ubuntu/Debian-based systems or WSL2:

```bash
sudo apt update
sudo apt install iverilog gtkwave
```

### Compiling and Running

1. Clone or download this repository
2. Navigate to the project directory
3. Run the compilation script:

```bash
chmod +x compile.sh
./compile.sh
```

## Test Program

The current implementation includes a simple test program in `instruction_memory.v`:

```
# Memory address | Instruction    | Description
# ---------------------------------------------
# 0x00           | 00500093       | addi x1, x0, 5      # x1 = 5
# 0x04           | 00A00113       | addi x2, x0, 10     # x2 = 10
# 0x08           | 002081B3       | add x3, x1, x2      # x3 = x1 + x2 = 15
# 0x0C           | 00302023       | sw x3, 0(x0)        # Store x3 to memory address 0
# 0x10           | 00002203       | lw x4, 0(x0)        # Load from memory address 0 to x4
```

### Expected Results

After running the simulation:

- Register x1 = 5
- Register x2 = 10
- Register x3 = 15 (sum of x1 and x2)
- Register x4 = 15 (loaded from memory)
- Memory location 0 = 15

## Customizing the Test Program

To test different instructions, modify the `initial` block in `instruction_memory.v`. You can add your own RISC-V instructions by:

1. Converting assembly to machine code using a RISC-V assembler
2. Adding the hex values to the memory initialization

Example:
```verilog
// In instruction_memory.v
initial begin
    memory[0] = 32'h00500093;  // Your first instruction
    memory[1] = 32'h00A00113;  // Your second instruction
    // Add more instructions
    ...
end
```

## Viewing Waveforms

After running the simulation, view the generated waveforms:

```bash
gtkwave waveform.vcd
```

For WSL2 users, either:
1. Configure an X server on Windows and export the DISPLAY
2. Copy the VCD file to Windows and use GTKWave for Windows

## Supported Instructions

The current implementation supports:

- **Arithmetic**: ADD, ADDI, SUB
- **Logical**: AND, OR, XOR
- **Shifts**: SLL, SRL, SRA
- **Comparison**: SLT, SLTU
- **Memory**: LW, SW
- **Branch**: BEQ (basic implementation)

## Limitations and Future Work

- Limited to single-cycle execution (not pipelined)
- Basic branch handling without branch prediction
- No hardware interrupts or exceptions
- Limited memory addressing
- No support for compressed instructions (RV32C)

## Extending the Project

To expand this implementation:
- Add more instruction types
- Implement pipelining for better performance
- Add hazard detection and forwarding units
- Implement a memory hierarchy with cache
- Add support for interrupts and exceptions
- Integrate with peripherals for I/O

## License

This project is provided for educational purposes.

## Acknowledgements

- [RISC-V International](https://riscv.org/) for the open instruction set architecture
- RISC-V ISA specification