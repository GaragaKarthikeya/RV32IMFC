#!/bin/bash
# Compile and run the CPU simulation

# Set working directory to project root
cd "$(dirname "$0")/.."

echo "Compiling RISC-V CPU..."
iverilog -o build/riscv_cpu_sim src/core/*.v src/memory/*.v src/testbench/tb_riscv_cpu.v

# Check if compilation was successful
if [ $? -eq 0 ]; then
  echo "Compilation successful. Starting simulation..."
  # Run the simulation
  vvp build/riscv_cpu_sim
else
  echo "Compilation failed!"
fi
