.section .text
.globl _start
_start:
    # Initialize registers
    addi x1, x0, 0        # x1 = 0 (First Fibonacci number)
    addi x2, x0, 1        # x2 = 1 (Second Fibonacci number)
    addi x3, x0, 0        # x3 = 0 (Memory address pointer)
    
    # Store first two numbers
    sw x1, 0(x3)          # Store 0 to mem[0]
    addi x3, x3, 4
    sw x2, 4(x3)          # Store 1 to mem[1]
    addi x3, x3, 4
    
    # Calculate next 6 numbers manually (unrolled loop)
    # 3rd number (1)
    add x5, x1, x2        # x5 = x1 + x2
    add x1, x0, x2        # x1 = x2
    add x2, x0, x5        # x2 = x5
    sw x5, 0(x3)          # Store to memory
    addi x3, x3, 4
    
    # 4th number (2)
    add x5, x1, x2
    add x1, x0, x2
    add x2, x0, x5
    sw x5, 0(x3)
    addi x3, x3, 4
    
    # 5th number (3)
    add x5, x1, x2
    add x1, x0, x2
    add x2, x0, x5
    sw x5, 0(x3)
    addi x3, x3, 4
    
    # 6th number (5)
    add x5, x1, x2
    add x1, x0, x2
    add x2, x0, x5
    sw x5, 0(x3)
    addi x3, x3, 4
    
    # End with infinite loop
    j end
end:
    j end
