module data_memory (
    input wire clk,
    input wire mem_read,
    input wire mem_write,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output wire [31:0] read_data
);

    // Memory array (1KB for simplicity)
    reg [31:0] memory [0:255];
    integer i;
    
    // Initialize memory to 0
    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'h0;
    end
    
    // Write operation (synchronous)
    always @(posedge clk) begin
        if (mem_write)
            memory[address[9:2]] <= write_data;
    end
    
    // Read operation (asynchronous)
    assign read_data = mem_read ? memory[address[9:2]] : 32'h0;

endmodule