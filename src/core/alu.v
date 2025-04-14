module alu (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [3:0] alu_control,
    output reg [31:0] result,
    output wire zero,
    // Add branch-specific outputs
    output reg branch_result
);

    // ALU control codes
    parameter ALU_ADD = 4'b0000;
    parameter ALU_SUB = 4'b0001;
    parameter ALU_AND = 4'b0010;
    parameter ALU_OR  = 4'b0011;
    parameter ALU_XOR = 4'b0100;
    parameter ALU_SLL = 4'b0101; // Shift left logical
    parameter ALU_SRL = 4'b0110; // Shift right logical
    parameter ALU_SRA = 4'b0111; // Shift right arithmetic
    parameter ALU_SLT = 4'b1000; // Set less than (signed)
    parameter ALU_SLTU = 4'b1001; // Set less than unsigned
    // Branch operation codes
    parameter ALU_BEQ = 4'b1010; // Branch equal
    parameter ALU_BNE = 4'b1011; // Branch not equal
    parameter ALU_BLT = 4'b1100; // Branch less than
    parameter ALU_BGE = 4'b1101; // Branch greater than or equal
    parameter ALU_BLTU = 4'b1110; // Branch less than unsigned
    parameter ALU_BGEU = 4'b1111; // Branch greater than or equal unsigned
    
    // ALU operation
    always @(*) begin
        case (alu_control)
            ALU_ADD: result = a + b;
            ALU_SUB: result = a - b;
            ALU_AND: result = a & b;
            ALU_OR:  result = a | b;
            ALU_XOR: result = a ^ b;
            ALU_SLL: result = a << b[4:0];
            ALU_SRL: result = a >> b[4:0];
            ALU_SRA: result = $signed(a) >>> b[4:0];
            ALU_SLT: result = ($signed(a) < $signed(b)) ? 32'h1 : 32'h0;
            ALU_SLTU: result = (a < b) ? 32'h1 : 32'h0;
            // Branch operations compute the same result as SUB
            ALU_BEQ, ALU_BNE, ALU_BLT, ALU_BGE, ALU_BLTU, ALU_BGEU: result = a - b;
            default: result = 32'h0;
        endcase
    end
    
    // Zero flag
    assign zero = (result == 32'h0);

    // Branch evaluation result
    always @(*) begin
        case (alu_control)
            ALU_BEQ:  branch_result = (a == b);
            ALU_BNE:  branch_result = (a != b);
            ALU_BLT:  branch_result = ($signed(a) < $signed(b));
            ALU_BGE:  branch_result = ($signed(a) >= $signed(b));
            ALU_BLTU: branch_result = (a < b);
            ALU_BGEU: branch_result = (a >= b);
            default:  branch_result = 1'b0;
        endcase
    end

endmodule