module control_unit (
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg mem_to_reg,
    output reg alu_src,
    output reg [1:0] alu_op,
    output reg [3:0] alu_control
);

    // RISC-V opcode definitions
    parameter R_TYPE     = 7'b0110011;
    parameter I_TYPE_ALU = 7'b0010011;
    parameter I_TYPE_LOAD = 7'b0000011;
    parameter S_TYPE     = 7'b0100011;
    parameter B_TYPE     = 7'b1100011;
    parameter U_TYPE_LUI = 7'b0110111;
    parameter U_TYPE_AUIPC = 7'b0010111;
    parameter J_TYPE_JAL = 7'b1101111;
    parameter I_TYPE_JALR = 7'b1100111;
    
    // Main control signals
    always @(*) begin
        case(opcode)
            R_TYPE: begin
                reg_write = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                mem_to_reg = 1'b0;
                alu_src = 1'b0;
                alu_op = 2'b10;
            end
            I_TYPE_ALU: begin
                reg_write = 1'b1;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                mem_to_reg = 1'b0;
                alu_src = 1'b1;
                alu_op = 2'b10;
            end
            I_TYPE_LOAD: begin
                reg_write = 1'b1;
                mem_read = 1'b1;
                mem_write = 1'b0;
                branch = 1'b0;
                mem_to_reg = 1'b1;
                alu_src = 1'b1;
                alu_op = 2'b00;
            end
            S_TYPE: begin
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b1;
                branch = 1'b0;
                mem_to_reg = 1'bx; // Don't care
                alu_src = 1'b1;
                alu_op = 2'b00;
            end
            B_TYPE: begin
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b1;
                mem_to_reg = 1'bx; // Don't care
                alu_src = 1'b0;
                alu_op = 2'b01;
            end
            default: begin
                reg_write = 1'b0;
                mem_read = 1'b0;
                mem_write = 1'b0;
                branch = 1'b0;
                mem_to_reg = 1'b0;
                alu_src = 1'b0;
                alu_op = 2'b00;
            end
        endcase
    end

    // ALU control logic
    always @(*) begin
        case(alu_op)
            2'b00: alu_control = 4'b0000; // ADD for loads/stores
            2'b01: begin // Branch instructions
                case(funct3)
                    3'b000: alu_control = 4'b1010; // BEQ
                    3'b001: alu_control = 4'b1011; // BNE
                    3'b100: alu_control = 4'b1100; // BLT
                    3'b101: alu_control = 4'b1101; // BGE
                    3'b110: alu_control = 4'b1110; // BLTU
                    3'b111: alu_control = 4'b1111; // BGEU
                    default: alu_control = 4'b1010; // Default to BEQ
                endcase
            end
            2'b10: begin // R-type or I-type ALU
                case(funct3)
                    3'b000: begin
                        // ADD or SUB (for R-type)
                        if (opcode == R_TYPE && funct7 == 7'b0100000)
                            alu_control = 4'b0001; // SUB
                        else
                            alu_control = 4'b0000; // ADD
                    end
                    3'b001: alu_control = 4'b0101; // SLL
                    3'b010: alu_control = 4'b1000; // SLT
                    3'b011: alu_control = 4'b1001; // SLTU
                    3'b100: alu_control = 4'b0100; // XOR
                    3'b101: begin
                        if (funct7 == 7'b0100000)
                            alu_control = 4'b0111; // SRA
                        else
                            alu_control = 4'b0110; // SRL
                    end
                    3'b110: alu_control = 4'b0011; // OR
                    3'b111: alu_control = 4'b0010; // AND
                    default: alu_control = 4'b0000;
                endcase
            end
            default: alu_control = 4'b0000;
        endcase
    end

endmodule