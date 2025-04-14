module immediate_generator (
    input wire [31:0] instruction,
    output reg [31:0] imm_extended
);

    wire [6:0] opcode = instruction[6:0];
    
    always @(*) begin
        case(opcode)
            7'b0010011, // I-type ALU operations
            7'b0000011: // I-type loads
                imm_extended = {{20{instruction[31]}}, instruction[31:20]};
                
            7'b0100011: // S-type
                imm_extended = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
                
            7'b1100011: // B-type
                imm_extended = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
                
            7'b0110111, // U-type LUI
            7'b0010111: // U-type AUIPC
                imm_extended = {instruction[31:12], 12'h000};
                
            7'b1101111: // J-type JAL
                imm_extended = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
                
            default:
                imm_extended = 32'h0;
        endcase
    end

endmodule