.section .text
.globl _start
_start:
    # Initialize registers
    addi x1, x0, 0        # x1 = 0 (First Fibonacci number)
    addi x2, x0, 1        # x2 = 1 (Second Fibonacci number)
    addi x3, x0, 0        # x3 = 0 (Memory address pointer)
    addi x4, x0, 8        # x4 = 8 (Counter - we'll generate 8 numbers to fit in testbench)
    
    # Store first Fibonacci number (0)
    sw x1, 0(x3)          # Store x1 to memory at address x3
    addi x3, x3, 4        # Increment pointer to next word
    addi x4, x4, -1       # Decrement counter
    
    # Store second Fibonacci number (1)
    sw x2, 0(x3)          # Store x2 to memory at address x3
    addi x3, x3, 4        # Increment pointer to next word
    addi x4, x4, -1       # Decrement counter
    
loop:
    beq x4, x0, done      # If counter reaches 0, exit loop
    
    add x5, x1, x2        # x5 = x1 + x2 (Next Fibonacci number)
    sw x5, 0(x3)          # Store x5 to memory at address x3
    addi x3, x3, 4        # Increment pointer to next word
    
    add x6, x0, x1        # Save x1 temporarily in x6
    add x1, x0, x2        # x1 = x2
    add x2, x0, x5        # x2 = x5
    addi x4, x4, -1       # Decrement counter
    
    j loop                # Jump back to loop
    
done:
    # End of program - infinite loop
    j done
