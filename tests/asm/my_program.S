.section .text
.globl _start
_start:
    addi x1, x0, 15       # x1 = 15
    addi x2, x0, 20       # x2 = 20
    add x3, x1, x2        # x3 = x1 + x2 = 35
    sw x3, 4(x0)          # Store x3 to memory address 4
    lw x4, 4(x0)          # Load from memory address 4 to x4
    addi x5, x0, 5        # x5 = 5
    sub x6, x3, x5        # x6 = x3 - x5 = 30
loop:
    j loop                # Infinite loop to end program
