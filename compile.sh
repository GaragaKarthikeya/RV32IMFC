#!/bin/bash

# Compile the design and generate VCD
iverilog -o riscv_cpu_sim \
  riscv_cpu.v \
  program_counter.v \
  instruction_memory.v \
  register_file.v \
  alu.v \
  control_unit.v \
  data_memory.v \
  immediate_generator.v \
  tb_riscv_cpu.v

# Run the simulation
if [ $? -eq 0 ]; then
  echo "Compilation successful. Starting simulation..."
  vvp riscv_cpu_sim
  echo "Simulation complete. You can view waveforms with: gtkwave waveform.vcd"
else
  echo "Compilation failed."
fi