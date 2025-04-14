module register_file (
    input wire clk,
    input wire rst_n,
    input wire reg_write,
    input wire [4:0] read_reg1,
    input wire [4:0] read_reg2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    output wire [31:0] read_data1,
    output wire [31:0] read_data2
);

    // 32 registers, each 32-bit wide
    reg [31:0] registers [0:31];
    integer i;
    
    // Initialize all registers to 0
    initial begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 32'h0;
    end
    
    // Write operation (at positive clock edge)
    always @(posedge clk) begin
        if (reg_write && write_reg != 0) // Register x0 must always be 0
            registers[write_reg] <= write_data;
    end
    
    // Read operations (combinational)
    assign read_data1 = (read_reg1 == 0) ? 32'h0 : registers[read_reg1];
    assign read_data2 = (read_reg2 == 0) ? 32'h0 : registers[read_reg2];

endmodule