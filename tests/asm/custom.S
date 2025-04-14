# File: custom.S
.section .text
.globl _start
_start:
    # Your assembly code here
    addi x1, x0, 15       # Set x1 to 15
    addi x2, x0, 20       # Set x2 to 20
    add x3, x1, x2        # x3 = x1 + x2
    sw x3, 4(x0)          # Store x3 to memory address 4
    lw x4, 4(x0)          # Load from memory address 4 to x4
    addi x5, x0, 5        # Set x5 to 5
    sub x6, x3, x5        # x6 = x3 - x5
loop:
    j loop                # Infinite loop to end program
