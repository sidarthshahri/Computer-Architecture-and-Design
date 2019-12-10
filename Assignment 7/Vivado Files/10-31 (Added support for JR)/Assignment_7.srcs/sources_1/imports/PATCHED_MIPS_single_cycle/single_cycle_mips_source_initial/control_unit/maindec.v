module maindec (
        input  wire [5:0] opcode,
        output wire       branch,
        output wire       jump,
        output wire       reg_dst,
        output wire       we_reg,
        output wire       alu_src,
        output wire       we_dm,
        output wire       dm2reg,
        output wire [1:0] alu_op
    );

    reg [8:0] ctrl;

    assign {branch, jump, reg_dst, we_reg, alu_src, we_dm, dm2reg, alu_op} = ctrl;

    always @ (opcode) begin
        case (opcode)
            6'b00_0000: ctrl = 9'b0_0_1_1_0_0_0_10; // R-type
            6'b00_1000: ctrl = 9'b0_0_0_1_1_0_0_00; // ADDI
            6'b00_0100: ctrl = 9'b1_0_0_0_0_0_0_01; // BEQ
            6'b00_0010: ctrl = 9'b0_1_0_0_0_0_0_00; // J
            6'b10_1011: ctrl = 9'b0_0_0_0_1_1_0_00; // SW
            6'b10_0011: ctrl = 9'b0_0_0_1_1_0_1_00; // LW
            default:    ctrl = 9'bx_x_x_x_x_x_x_xx;
        endcase
    end

endmodule