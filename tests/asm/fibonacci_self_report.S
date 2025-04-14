.section .text
.globl _start
_start:
    # Initialize registers
    addi x1, x0, 0        # x1 = 0 (First Fibonacci number)
    addi x2, x0, 1        # x2 = 1 (Second Fibonacci number)
    addi x3, x0, 0        # x3 = 0 (Memory address pointer)
    addi x4, x0, 10       # x4 = 10 (Counter - we'll generate 10 numbers)
    addi x10, x0, 0       # x10 = 0 (Completed flag, will set to 1 at end)
    
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
    
    addi x1, x2, 0        # x1 = x2
    addi x2, x5, 0        # x2 = x5
    addi x4, x4, -1       # Decrement counter
    
    j loop                # Jump back to loop
    
done:
    # Calculate a distinct value in x10 to indicate we finished
    addi x10, x0, 255     # Set x10 to 255 to indicate completion
    
    # Store registers for easier inspection
    addi x11, x0, 100     # Start at address 100 for debug data
    sw x1, 0(x11)         # Store x1 (second-to-last Fibonacci)
    sw x2, 4(x11)         # Store x2 (last Fibonacci)
    sw x3, 8(x11)         # Store x3 (final address pointer)
    sw x10, 12(x11)       # Store completion flag
    
    # End program in an infinite loop
    j done
