module instruction_memory (
    input wire [31:0] pc,
    output wire [31:0] instruction
);

    // For a simple implementation, we'll use a small ROM
    reg [31:0] memory [0:255]; // 256 words of memory
    integer i;
    
    // Initialize with a simple program (can be replaced with actual instructions)
    initial begin
        // Example program:
        // addi x1, x0, 5      # x1 = 5
        // addi x2, x0, 10     # x2 = 10
        // add x3, x1, x2      # x3 = x1 + x2 = 15
        // sw x3, 0(x0)        # Store x3 to memory address 0
        // lw x4, 0(x0)        # Load from memory address 0 to x4
        memory[0] = 32'h00500093;  // addi x1, x0, 5
        memory[1] = 32'h00A00113;  // addi x2, x0, 10
        memory[2] = 32'h002081B3;  // add x3, x1, x2
        memory[3] = 32'h00302023;  // sw x3, 0(x0)
        memory[4] = 32'h00002203;  // lw x4, 0(x0)
        // Rest of memory initialized to 0
        for (i = 5; i < 256; i = i + 1)
            memory[i] = 32'h0;
    end
    
    // Word-aligned access (address ignores lower 2 bits)
    assign instruction = memory[pc[9:2]]; // PC is byte-addressed, but memory is word-addressed

endmodule