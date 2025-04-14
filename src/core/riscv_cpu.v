module riscv_cpu (
    input wire clk,
    input wire rst_n,
    output wire [31:0] pc_out
);
    // Wires for connecting components
    wire [31:0] pc_current;
    wire [31:0] pc_next;
    wire [31:0] instruction;
    wire [31:0] alu_result;
    wire [31:0] read_data1, read_data2;
    wire [31:0] imm_extended;
    wire [31:0] write_data;
    wire [31:0] read_data_mem;
    wire [4:0] rd, rs1, rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [6:0] opcode;
    
    // Control signals
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire branch;
    wire mem_to_reg;
    wire alu_src;
    wire [1:0] alu_op;
    wire [3:0] alu_control;
    wire zero_flag;
    wire branch_result;    // New wire for branch condition result
    wire pc_src;
    
    // Program Counter
    program_counter pc (
        .clk(clk),
        .rst_n(rst_n),
        .pc_next(pc_next),
        .pc_current(pc_current)
    );
    
    // Instruction Memory
    instruction_memory imem (
        .pc(pc_current),
        .instruction(instruction)
    );
    
    // Instruction decoding
    assign opcode = instruction[6:0];
    assign rd = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign funct7 = instruction[31:25];
    
    // Control Unit
    control_unit cu (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .alu_op(alu_op),
        .alu_control(alu_control)
    );
    
    // Register File
    register_file rf (
        .clk(clk),
        .rst_n(rst_n),
        .reg_write(reg_write),
        .read_reg1(rs1),
        .read_reg2(rs2),
        .write_reg(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    
    // Immediate Generator
    immediate_generator immgen (
        .instruction(instruction),
        .imm_extended(imm_extended)
    );
    
    // ALU source mux
    wire [31:0] alu_input2 = alu_src ? imm_extended : read_data2;
    
    // ALU
    alu main_alu (
        .a(read_data1),
        .b(alu_input2),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(zero_flag),
        .branch_result(branch_result)    // Connect the branch_result output
    );
    
    // Data Memory
    data_memory dmem (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(alu_result),
        .write_data(read_data2),
        .read_data(read_data_mem)
    );
    
    // Write back mux
    assign write_data = mem_to_reg ? read_data_mem : alu_result;
    
    // Branch logic - use branch_result instead of zero_flag
    assign pc_src = branch & branch_result;
    assign pc_next = pc_src ? (pc_current + imm_extended) : (pc_current + 4);
    
    // Output
    assign pc_out = pc_current;
    
endmodule