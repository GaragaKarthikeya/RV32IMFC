module tb_riscv_cpu;
    reg clk;
    reg rst_n;
    wire [31:0] pc_out;
    integer i;
    
    // Instantiate the RISC-V CPU
    riscv_cpu dut (
        .clk(clk),
        .rst_n(rst_n),
        .pc_out(pc_out)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Waveform dumping
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_riscv_cpu);
    end
    
    // Test sequence
    initial begin
        $display("Starting RISC-V CPU test...");
        
        // Reset the CPU
        rst_n = 0;
        #10;
        rst_n = 1;
        
        // Run longer to allow all instructions to execute
        #1500;  // Increased from 1000 to 1500
        
        // Print register file contents at end
        $display("\nFinal Register File Contents:");
        for (i = 0; i < 10; i = i + 1) begin
            $display("x%0d = %0d (0x%h)", i, dut.rf.registers[i], dut.rf.registers[i]);
        end
        
        // Print Fibonacci sequence from memory
        $display("\nFibonacci Sequence in Memory:");
        for (i = 0; i < 8; i = i + 1) begin
            $display("mem[%0d] = %0d (0x%h)", i, dut.dmem.memory[i], dut.dmem.memory[i]);
        end
        
        // End simulation
        $display("\nEnd of test. PC = %h", pc_out);
        $finish;
    end
    
endmodule
