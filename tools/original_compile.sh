#!/bin/bash

PROGRAM_FILE=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--program)
            PROGRAM_FILE=$(readlink -f "$2")  # Get absolute path
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Compile the design
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

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful. Starting simulation..."
    
    # Run with program file if provided
    if [ -n "$PROGRAM_FILE" ]; then
        # Create temporary include file for path definition
        echo "\`define PROGRAM_FILE \"$PROGRAM_FILE\"" > program_path.vh
        
        echo "Using program file: $PROGRAM_FILE"
        cat program_path.vh
        
        # Recompile with program path definition
        iverilog -o riscv_cpu_sim \
          -I. \
          riscv_cpu.v \
          program_counter.v \
          instruction_memory.v \
          register_file.v \
          alu.v \
          control_unit.v \
          data_memory.v \
          immediate_generator.v \
          tb_riscv_cpu.v
          
        vvp riscv_cpu_sim
    else
        echo "Using default program"
        vvp riscv_cpu_sim
    fi
    
    echo "Simulation complete. You can view waveforms with: gtkwave waveform.vcd"
else
    echo "Compilation failed."
fi