module instruction_memory (
    input wire [31:0] pc,
    output wire [31:0] instruction
);

    // For a simple implementation, we'll use a small ROM
    reg [31:0] memory [0:255]; // 256 words of memory
    integer i, file_handle;
    
    // Initialize from file if provided, otherwise use default program
    initial begin
        // Default: Initialize all memory to 0
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'h0;
            
        // Try to load the program
        $display("Loading program from test.hex");
        file_handle = $fopen("test.hex", "r");
        if (file_handle == 0) begin
            $display("ERROR: Could not open test.hex");
        end else begin
            $fclose(file_handle);
            $readmemh("test.hex", memory);
            $display("Program loaded successfully");
        end
        
        // Debug: Display the first few instructions
        $display("First 8 instructions:");
        for (i = 0; i < 8; i = i + 1)
            $display("memory[%0d] = 0x%h", i, memory[i]);
    end
    
    // Word-aligned access (address ignores lower 2 bits)
    assign instruction = memory[pc[9:2]]; // PC is byte-addressed, but memory is word-addressed

endmodule
