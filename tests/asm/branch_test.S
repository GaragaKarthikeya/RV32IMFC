// Branch Instruction Test Program
// This assembly program tests all branch instructions implemented in our RISC-V CPU

.section .text
.globl _start

_start:
    // Initialize registers with test values
    addi x1, x0, 10      // x1 = 10
    addi x2, x0, 20      // x2 = 20
    addi x3, x0, 10      // x3 = 10 (same as x1)
    addi x4, x0, -5      // x4 = -5 (negative value)
    addi x5, x0, 0       // x5 = 0 (for storing results)
    addi x6, x0, 0       // x6 = 0 (counter for memory address)

    // Test 1: BEQ - Branch if Equal
    // Should branch when x1 == x3
    beq x1, x3, beq_success
    // Should not reach here
    addi x5, x5, 1       // Failure indicator
    jal x0, beq_next
beq_success:
    addi x5, x5, 100     // Success indicator
beq_next:
    sw x5, 0(x6)         // Store result to memory
    addi x6, x6, 4       // Increment memory pointer
    addi x5, x0, 0       // Reset result indicator

    // Test 2: BNE - Branch if Not Equal
    // Should branch when x1 != x2
    bne x1, x2, bne_success
    // Should not reach here
    addi x5, x5, 1       // Failure indicator
    jal x0, bne_next
bne_success:
    addi x5, x5, 100     // Success indicator
bne_next:
    sw x5, 0(x6)         // Store result to memory
    addi x6, x6, 4       // Increment memory pointer
    addi x5, x0, 0       // Reset result indicator

    // Test 3: BLT - Branch if Less Than (signed)
    // Should branch when x4 < x1 (negative < positive)
    blt x4, x1, blt_success
    // Should not reach here
    addi x5, x5, 1       // Failure indicator
    jal x0, blt_next
blt_success:
    addi x5, x5, 100     // Success indicator
blt_next:
    sw x5, 0(x6)         // Store result to memory
    addi x6, x6, 4       // Increment memory pointer
    addi x5, x0, 0       // Reset result indicator

    // Test 4: BGE - Branch if Greater than or Equal (signed)
    // Should branch when x1 >= x3 (10 >= 10)
    bge x1, x3, bge_success
    // Should not reach here
    addi x5, x5, 1       // Failure indicator
    jal x0, bge_next
bge_success:
    addi x5, x5, 100     // Success indicator
bge_next:
    sw x5, 0(x6)         // Store result to memory
    addi x6, x6, 4       // Increment memory pointer
    addi x5, x0, 0       // Reset result indicator

    // Test 5: BLTU - Branch if Less Than Unsigned
    // Should not branch when x4 < x1 on unsigned comparison
    // (In unsigned comparison, -5 is a large positive number)
    bltu x4, x1, bltu_success
    // Should branch here for success
    addi x5, x5, 100     // Success indicator
    jal x0, bltu_next
bltu_success:
    addi x5, x5, 1       // Failure indicator
bltu_next:
    sw x5, 0(x6)         // Store result to memory
    addi x6, x6, 4       // Increment memory pointer
    addi x5, x0, 0       // Reset result indicator

    // Test 6: BGEU - Branch if Greater than or Equal Unsigned
    // Should branch when x4 >= x1 on unsigned comparison
    bgeu x4, x1, bgeu_success
    // Should not reach here
    addi x5, x5, 1       // Failure indicator
    jal x0, bgeu_next
bgeu_success:
    addi x5, x5, 100     // Success indicator
bgeu_next:
    sw x5, 0(x6)         // Store result to memory
    addi x6, x6, 4       // Increment memory pointer

    // Branching with zero
    addi x7, x0, 0       // x7 = 0
    addi x8, x0, 1       // x8 = 1

    // Test 7: BEQ with zero - should branch
    beq x7, x0, beqz_success
    // Should not reach here
    addi x5, x5, 1       // Failure indicator
    jal x0, beqz_next
beqz_success:
    addi x5, x5, 100     // Success indicator
beqz_next:
    sw x5, 0(x6)         // Store result to memory
    addi x6, x6, 4       // Increment memory pointer
    addi x5, x0, 0       // Reset result indicator

    // Test 8: BNE with zero - should branch
    bne x8, x0, bnez_success
    // Should not reach here
    addi x5, x5, 1       // Failure indicator
    jal x0, bnez_next
bnez_success:
    addi x5, x5, 100     // Success indicator
bnez_next:
    sw x5, 0(x6)         // Store result to memory
    addi x6, x6, 4       // Increment memory pointer

    // Add a success marker at the end
    addi x9, x0, 0xCAFE  // Magic success value
    sw x9, 0(x6)         // Store success marker

end_loop:
    jal x0, end_loop     // Infinite loop to end program