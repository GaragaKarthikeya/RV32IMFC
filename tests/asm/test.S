.section .text
.globl _start
_start:
    # Simple program to test our CPU
    addi x1, x0, 5      # x1 = 5
    addi x2, x0, 10     # x2 = 10
    add x3, x1, x2      # x3 = x1 + x2 = 15
    sw x3, 0(x0)        # Store x3 to memory address 0
    lw x4, 0(x0)        # Load from memory address 0 to x4
    addi x5, x0, 7      # x5 = 7
    add x6, x3, x5      # x6 = x3 + x5 = 22
loop:
    j loop              # Infinite loop to end program
